# Workflow Mobile Client

App móvil para clientes en busca de monitorear y completar procesos de workflow del Banco.

## 🎯 Características

- ✅ Ver estado de procesos en tiempo real
- ✅ Completar tareas asignadas
- ✅ Cargar documentos requeridos
- ✅ Notificaciones push (FCM)
- ✅ Historial de procesos completados
- ✅ Funciona sin conexión (datos en caché local)

## 🛠️ Tecnología

- **Framework**: Flutter (Dart)
- **API**: GraphQL
- **Estado**: Riverpod
- **Almacenamiento Local**: Hive
- **Notificaciones**: Firebase Cloud Messaging (FCM)
- **Navegación**: GoRouter
- **Plataforma**: Android

## 📁 Estructura del Proyecto

```
workflow-mobile-client/
├── lib/
│   ├── main.dart                    # Punto de entrada
│   ├── models/
│   │   └── workflow_models.dart     # Modelos Freezed + Hive
│   ├── screens/
│   │   ├── home_screen.dart         # Pantalla principal
│   │   ├── process_detail_screen.dart
│   │   ├── task_detail_screen.dart
│   │   ├── notifications_screen.dart
│   │   ├── history_screen.dart
│   │   └── profile_screen.dart
│   ├── services/
│   │   ├── graphql_service.dart     # Cliente GraphQL
│   │   ├── graphql_queries.dart     # Queries y Mutations
│   │   ├── local_storage_service.dart
│   │   └── notification_service.dart
│   ├── widgets/
│   │   ├── app_providers.dart       # Riverpod providers
│   │   ├── process_card.dart
│   │   ├── task_card.dart
│   │   └── sync_indicator.dart
│   └── config/
│       ├── app_config.dart          # Configuraciones
│       └── router_config.dart       # Rutas
├── android/
│   └── app/
│       └── AndroidManifest.xml      # Permisos y Firebase
└── pubspec.yaml                     # Dependencias

```

## 🚀 Instalación

### Requisitos
- Flutter 3.0+
- Dart 3.0+
- Android SDK 31+
- Firebase Project configurado

### Pasos

1. **Clonar repositorio**
```bash
cd workflow-mobile-client
```

2. **Obtener dependencias**
```bash
flutter pub get
```

3. **Generar código (Freezed, Hive)**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Conectar Firebase**
- Descargar `google-services.json` del proyecto Firebase
- Copiarlo en `android/app/`

5. **Ejecutar en dispositivo/emulador**
```bash
flutter run
```

## 📱 Pantallas Principales

### 1. **Home Screen** (`/`)
- Tab 1: Lista de procesos activos
- Tab 2: Tareas asignadas al usuario
- Botón de sincronización
- Badge de notificaciones no leídas

### 2. **Process Detail** (`/process/:id`)
- Información del proceso
- Estado actual
- Historial de eventos
- Botón para ver historial completo

### 3. **Task Detail** (`/task/:id`)
- Detalles de la tarea
- Documentos requeridos
- Botones para completar/rechazar tarea
- Opción de cargar archivos

### 4. **Notifications** (`/notifications`)
- Lista de todas las notificaciones
- Indicador de leídas/no leídas
- Filtro por tipo

### 5. **History** (`/history`)
- Procesos completados/fallidos
- Timeline de eventos
- Detalles expandibles

### 6. **Profile** (`/profile`)
- Información del usuario
- Estadísticas personales
- Preferencias de la app
- Opción de logout

## 🔄 Flujo de Datos

```
GraphQL Service
    ↓
Riverpod Providers
    ↓
State Management
    ↓
UI Screens
    ↓
User Interaction
    ↓
Local Storage (Hive)
    ↓
Offline Sync Queue
```

## 🔔 Notificaciones Push

Las notificaciones se reciben mediante Firebase Cloud Messaging:

- **TASK_ASSIGNED**: Nueva tarea asignada
- **PROCESS_COMPLETED**: Proceso completado
- **DOCUMENT_REJECTED**: Documento rechazado

### Configuración FCM

1. Crear proyecto en Firebase Console
2. Descargar `google-services.json`
3. Copiar a `android/app/`
4. El backend debe enviar mensajes a los FCM tokens registrados

## 💾 Almacenamiento Local

Usando Hive para persistencia offline:

- **Procesos**: Caché de procesos activos/completados
- **Tareas**: Lista de tareas pendientes
- **Notificaciones**: Historial de notificaciones
- **Sincronización**: Metadatos de últimas sincronizaciones

## 📊 Providers Principales

```dart
// Servicios
graphQLServiceProvider       // Cliente GraphQL
localStorageProvider        // Hive storage
notificationServiceProvider // FCM

// Estado
userIdProvider              // ID del usuario actual
currentUserProvider         // Usuario actual

// Datos
processesProvider           // Lista de procesos
tasksProvider              // Lista de tareas
notificationsProvider      // Notificaciones
unreadNotificationsCountProvider

// Controlador
workflowControllerProvider  // Lógica de negocio
```

## 🔐 Seguridad

- Tokens JWT para autenticación (TODO)
- HTTPS para comunicación
- Datos sensibles en Hive encriptado (opcional)
- Permisos Android configurados

## 📝 TODO (Futuro)

- [ ] Autenticación con JWT
- [ ] Encriptación de datos en Hive
- [ ] Carga de archivos (PDF/Imágenes)
- [ ] Modo offline completo
- [ ] Sync automático en background
- [ ] Tests unitarios
- [ ] Tests integración
- [ ] Tema oscuro
- [ ] Múltiples idiomas (i18n)
- [ ] Versión iOS

## 🐛 Debugging

Habilitar logs detallados:
```dart
final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);
```

Ver logs en Firebase:
```bash
firebase logging --follow
```

## 📞 Soporte

Para problemas con:
- **Flutter**: https://flutter.dev/docs
- **GraphQL**: https://www.apollographql.com/docs
- **Firebase**: https://firebase.google.com/docs
- **Riverpod**: https://riverpod.dev

## 📄 Licencia

Todos los derechos reservados © Banco

---

**Última actualización**: Abril 20, 2026
