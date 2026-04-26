# Integración Backend - Mobile App

## 🔗 Conexión GraphQL

### 1. Configurar URL del Backend

En `lib/config/app_config.dart`:

```dart
// Desarrollo
static const String developmentGraphQLUrl = 'http://10.0.2.2:8080/graphql';

// Producción
static const String productionGraphQLUrl = 'https://api.banco.com/graphql';
```

Nota: `10.0.2.2` es la IP para acceder a localhost desde emulador Android

### 2. Añadir GraphQL Endpoint al Backend

El backend (Spring Boot) necesita:

```java
// application.yml
graphql:
  endpoint: /graphql
  playground:
    enabled: true
```

## 📱 Flujo de Autenticación

### Backend → Mobile

1. **Login** (no implementado aún)
```graphql
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    token
    user {
      id
      name
      email
    }
  }
}
```

2. **Token Storage**
```dart
// Guardar token en Hive
await _secureStorage.write(key: 'jwt_token', value: token);
```

3. **Incluir en Headers**
```dart
// GraphQL AuthLink (ya configurado)
final authLink = AuthLink(
  getToken: () async => 'Bearer $token',
);
```

## 🔄 Sincronización de Datos

### Cuando la app se abre:

```
1. Verificar conexión
2. Sincronizar procesos (getProcesses)
3. Sincronizar tareas (getTasks)
4. Sincronizar notificaciones (getNotifications)
5. Guardar en Hive
6. Marcar último sync time
```

### Notificaciones Push → Mobile

Backend envía FCM:

```java
// Firebase Admin SDK
FirebaseMessaging.getInstance().send(
  Message.builder()
    .putData("title", "Nueva tarea asignada")
    .putData("type", "TASK_ASSIGNED")
    .putData("taskId", "12345")
    .setNotification(new Notification("Título", "Cuerpo"))
    .setToken(deviceToken)
    .build()
);
```

Mobile lo recibe:

```dart
FirebaseMessaging.onMessage.listen((message) {
  // Mostrar notificación
});
```

## 📤 Completar Tarea

### Flujo

```
Mobile
  ↓
completeTask(taskId, result)
  ↓
GraphQL Mutation
  ↓
Backend Spring Boot
  ↓
Actualizar en MongoDB
  ↓
Notificar Temporal
  ↓
Continuar workflow
```

### Código Backend Necesario

```java
@GraphQLMutation
public CompletedTaskResponse completeTask(
    @GraphQLArgument String taskId,
    @GraphQLArgument Map<String, Object> result
) {
    Task task = taskRepository.findById(taskId);
    task.setStatus("COMPLETED");
    task.setResult(result);
    taskRepository.save(task);
    
    // Notificar al workflow de Temporal
    workflowClient.signalWorkflow(...);
    
    return new CompletedTaskResponse(true, task);
}
```

## 📄 Cargar Documentos

### Flujo

```
Mobile (Seleccionar archivo)
  ↓
Convertir a Base64
  ↓
uploadDocument(processId, fileName, fileBase64, mimeType)
  ↓
GraphQL Mutation
  ↓
Backend Spring Boot
  ↓
Guardar en MongoDB/S3
  ↓
Devolver URL/Status
```

### Código Backend Necesario

```java
@GraphQLMutation
public DocumentUploadResponse uploadDocument(
    @GraphQLArgument String processInstanceId,
    @GraphQLArgument String fileName,
    @GraphQLArgument String fileData,
    @GraphQLArgument String mimeType
) {
    // Decodificar Base64
    byte[] fileBytes = Base64.getDecoder().decode(fileData);
    
    // Guardar archivo
    String fileUrl = storageService.save(fileBytes, fileName);
    
    // Crear documento en MongoDB
    DocumentUpload doc = new DocumentUpload(
        processInstanceId, fileName, fileUrl, mimeType
    );
    documentRepository.save(doc);
    
    return new DocumentUploadResponse(true, doc);
}
```

## 🔐 Variables de Entorno

### Android

En `android/local.properties`:

```properties
flutter.minSdkVersion=31
flutter.targetSdkVersion=34
flutter.compileSdkVersion=34

# Backend URL
BACKEND_URL=http://10.0.2.2:8080
GRAPHQL_URL=http://10.0.2.2:8080/graphql
```

### firebase-app-distribution (opcional)

```bash
firebase appdistribution:distribute app-debug.apk \
  --app=1:123456789:android:abc123 \
  --testers-file=testers.txt
```

## 📊 Endpoint GraphQL Schema

Backend necesita exponer:

```graphql
type Query {
  processes(userId: String!): [ProcessInstance!]!
  tasks(assignee: String!): [Task!]!
  process(id: String!): ProcessInstance
  notifications(userId: String!, limit: Int!): [Notification!]!
  documents(processInstanceId: String!): [DocumentUpload!]!
}

type Mutation {
  completeTask(input: CompleteTaskInput!): CompleteTaskResponse!
  uploadDocument(input: UploadDocumentInput!): UploadDocumentResponse!
  markNotificationAsRead(id: String!): MarkNotificationResponse!
}

type Subscription {
  taskAssigned(userId: String!): Task!
  processStatusChanged(processId: String!): ProcessInstance!
}
```

## 🚀 Deployment Checklist

### Backend
- [ ] GraphQL endpoint configurado
- [ ] CORS habilitado para mobile
- [ ] Firebase Admin SDK integrado
- [ ] Storage (S3 o local) configurado
- [ ] Base de datos MongoDB conectada

### Mobile
- [ ] `google-services.json` copiado
- [ ] URLs de backend actualizadas
- [ ] Permisos Android solicitados
- [ ] Build apk para testing
- [ ] Conectado a Firebase Console

### Firebase
- [ ] Proyecto creado
- [ ] FCM habilitado
- [ ] Service account descargado
- [ ] App Android registrada
- [ ] SHA-1 fingerprint agregado

## 📞 Troubleshooting

### "Connection refused" en localhost

**Problema**: El emulador no puede conectarse a `localhost:8080`

**Solución**: Usar `10.0.2.2` en lugar de `localhost`

```dart
const String apiUrl = 'http://10.0.2.2:8080/graphql';
```

### FCM Token no se registra

**Problema**: `getToken()` retorna null

**Solución**: 
1. Verificar que Firebase está inicializado
2. Revisar que `google-services.json` está correcto
3. Verificar permisos en AndroidManifest

### GraphQL errors en queries

**Problema**: "Cannot query field..."

**Solución**: 
1. Verificar schema del backend
2. Ejecutar introspection query
3. Sincronizar schema entre frontend y backend

```bash
# Generar schema desde backend
apollo client:download-schema schema.json --endpoint=http://localhost:8080/graphql
```

---

**Última actualización**: Abril 20, 2026
