import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import '../models/workflow_models.dart';
import 'graphql_queries.dart';

class GraphQLService {
  late GraphQLClient _client;
  final String apiUrl;
  final String? authToken;
  final Logger _logger = Logger();

  GraphQLService({required this.apiUrl, this.authToken}) {
    _initializeClient();
  }

  void _initializeClient() {
    final httpLink = HttpLink(
      apiUrl,
      httpClient: _createHttpClient(),
    );

    final authLink = AuthLink(
      getToken: () async => authToken != null ? 'Bearer $authToken' : null,
    );

    Link link = authLink.concat(httpLink);

    _client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link,
    );
  }

  dynamic _createHttpClient() {
    // Crear cliente con timeout extendido
    try {
      // Para web, devuelve null (usa fetch por defecto)
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene lista de procesos para un usuario
  Future<List<ProcessInstance>> getProcesses(String userId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getProcessesQuery),
          variables: {'userId': userId},
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['processes'] as List? ?? [];
      return data
          .map((p) => ProcessInstance.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching processes: $e');
      rethrow;
    }
  }

  /// Obtiene tareas asignadas a un usuario
  Future<List<Task>> getTasks(String userId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getTasksQuery),
          variables: {'userId': userId},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['tasks'] as List? ?? [];
      return data
          .map((t) => Task.fromJson(t as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching tasks: $e');
      rethrow;
    }
  }

  /// Obtiene detalle de una tarea
  Future<Task?> getTaskDetail(String taskId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getTaskDetailQuery),
          variables: {'taskId': taskId},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['task'];
      if (data == null) return null;
      return Task.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error fetching task detail: $e');
      rethrow;
    }
  }

  /// Obtiene detalles de un proceso específico
  Future<ProcessInstance?> getProcessDetail(String processId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getProcessDetailQuery),
          variables: {'processId': processId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['process'];
      if (data == null) return null;
      
      return ProcessInstance.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error fetching process detail: $e');
      rethrow;
    }
  }

  /// Completa una tarea
  Future<bool> completeTask(String taskId, Map<String, dynamic> result) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(completeTaskMutation),
          variables: {
            'taskId': taskId,
            'result': result,
          },
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      final success = response.data?['completeTask']?['success'] as bool? ?? false;
      return success;
    } catch (e) {
      _logger.e('Error completing task: $e');
      rethrow;
    }
  }

  Future<bool> rejectTask(String taskId, String reason) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(rejectTaskMutation),
          variables: {'taskId': taskId, 'reason': reason},
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      return response.data?['rejectTask']?['success'] as bool? ?? false;
    } catch (e) {
      _logger.e('Error rejecting task: $e');
      rethrow;
    }
  }

  /// Sube un documento
  Future<DocumentUpload?> uploadDocument({
    required String processId,
    required String fileName,
    required String fileBase64,
    required String mimeType,
  }) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(uploadDocumentMutation),
          variables: {
            'processId': processId,
            'fileName': fileName,
            'fileBase64': fileBase64,
            'mimeType': mimeType,
          },
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      final data = response.data?['uploadDocument']?['document'];
      if (data == null) return null;

      return DocumentUpload.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error uploading document: $e');
      rethrow;
    }
  }

  /// Obtiene notificaciones del usuario
  Future<List<NotificationModel>> getNotifications(String userId, {int limit = 50}) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getNotificationsQuery),
          variables: {'userId': userId, 'limit': limit},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['notifications'] as List? ?? [];
      return data
          .map((n) => NotificationModel.fromJson(n as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching notifications: $e');
      rethrow;
    }
  }

  /// Marca una notificación como leída
  Future<bool> markNotificationAsRead(String notificationId) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(markNotificationAsReadMutation),
          variables: {'notificationId': notificationId},
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      return response.data?['markNotificationAsRead']?['success'] as bool? ?? false;
    } catch (e) {
      _logger.e('Error marking notification as read: $e');
      rethrow;
    }
  }

  Future<bool> markAllNotificationsAsRead(String userId) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(markAllNotificationsAsReadMutation),
          variables: {'userId': userId},
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      return response.data?['markAllNotificationsAsRead']?['success'] as bool? ?? false;
    } catch (e) {
      _logger.e('Error marking all notifications as read: $e');
      rethrow;
    }
  }

  /// Obtiene documentos de un proceso
  Future<List<DocumentUpload>> getDocuments(String processId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getDocumentsQuery),
          variables: {'processId': processId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['documents'] as List? ?? [];
      return data
          .map((d) => DocumentUpload.fromJson(d as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching documents: $e');
      rethrow;
    }
  }

  Future<List<Policy>> getPublishedPolicies() async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getPublishedPoliciesQuery),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['publishedPolicies'] as List? ?? [];
      return data.map((p) => Policy.fromJson(p as Map<String, dynamic>)).toList();
    } catch (e) {
      _logger.e('Error fetching published policies: $e');
      rethrow;
    }
  }

  Future<ProcessInstance> startProcess({
    required String policyId,
    required String clientId,
    required Map<String, dynamic> variables,
  }) async {
    try {
      final response = await _client.mutate(
        MutationOptions(
          document: gql(startProcessMutation),
          variables: {
            'input': {
              'policyId': policyId,
              'clientId': clientId,
              'variables': variables,
            },
          },
        ),
      );

      if (response.hasException) {
        throw Exception(response.exception.toString());
      }

      final data = response.data?['startProcess'];
      if (data == null) {
        throw Exception('No se recibió proceso creado');
      }

      return ProcessInstance.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      _logger.e('Error starting process: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getCurrentUserQuery),
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return result.data?['currentUser'] as Map<String, dynamic>?;
    } catch (e) {
      _logger.e('Error fetching current user: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getUserStatisticsQuery),
          variables: {'userId': userId},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      return (result.data?['userStatistics'] as Map<String, dynamic>?) ?? {};
    } catch (e) {
      _logger.e('Error fetching user statistics: $e');
      rethrow;
    }
  }

  Future<List<ProcessInstance>> getProcessHistory(String userId, {int limit = 30}) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(getProcessHistoryQuery),
          variables: {'userId': userId, 'limit': limit},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['processHistory'] as List? ?? [];
      return data.map((p) => ProcessInstance.fromJson(p as Map<String, dynamic>)).toList();
    } catch (e) {
      _logger.e('Error fetching process history: $e');
      rethrow;
    }
  }
}
