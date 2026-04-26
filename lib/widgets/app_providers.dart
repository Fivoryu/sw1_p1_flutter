import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workflow_models.dart';
import '../services/auth_service.dart';
import '../services/graphql_service.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';
import '../config/app_config.dart';

// ============ Service Providers ============

final graphQLServiceProvider = Provider((ref) {
  final token = ref.watch(authTokenProvider);
  return GraphQLService(apiUrl: AppConfig.developmentGraphQLUrl, authToken: token);
});

final localStorageProvider = Provider((ref) {
  // Use the singleton instance initialized in AppConfig
  return AppConfig.localStorage;
});

final authServiceProvider = Provider((ref) {
  return AuthService(baseUrl: AppConfig.developmentApiUrl);
});

final notificationServiceProvider = Provider((ref) {
  return NotificationService();
});

// ============ User State ============

final authTokenProvider = StateProvider<String?>((ref) => AppConfig.localStorage.getAuthToken());
final userIdProvider = StateProvider<String?>((ref) => AppConfig.localStorage.getStoredUserId());
final usernameProvider = StateProvider<String?>((ref) => AppConfig.localStorage.getStoredUsername());

final currentUserProvider = Provider<String>((ref) {
  return ref.watch(userIdProvider) ?? '';
});

final currentUsernameProvider = Provider<String>((ref) {
  return ref.watch(usernameProvider) ?? '';
});

// ============ Processes ============

final processesProvider = FutureProvider<List<ProcessInstance>>((ref) async {
  final userId = ref.watch(currentUserProvider);
  final graphQL = ref.watch(graphQLServiceProvider);
  final localStorage = ref.watch(localStorageProvider);

  try {
    final processes = await graphQL.getProcesses(userId);
    await localStorage.saveProceses(processes);
    return processes;
  } catch (e) {
    // Fallback a datos en caché
    return localStorage.getCachedProcesses();
  }
});

final processDetailProvider =
    FutureProvider.family<ProcessInstance?, String>((ref, processId) async {
  final graphQL = ref.watch(graphQLServiceProvider);
  final localStorage = ref.watch(localStorageProvider);

  try {
    return await graphQL.getProcessDetail(processId);
  } catch (e) {
    // Fallback a datos en caché
    return localStorage.getCachedProcess(processId);
  }
});

// ============ Tasks ============

final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final username = ref.watch(currentUsernameProvider);
  final graphQL = ref.watch(graphQLServiceProvider);
  final localStorage = ref.watch(localStorageProvider);

  try {
    final tasks = await graphQL.getTasks(username);
    await localStorage.saveTasks(tasks);
    return tasks;
  } catch (e) {
    // Fallback a datos en caché
    return localStorage.getCachedTasks();
  }
});

final taskDetailProvider = FutureProvider.family<Task?, String>((ref, taskId) async {
  final localStorage = ref.watch(localStorageProvider);
  return localStorage.getCachedTask(taskId);
});

// ============ Notifications ============

final notificationsProvider = FutureProvider<List<NotificationModel>>((ref) async {
  final userId = ref.watch(currentUserProvider);
  final graphQL = ref.watch(graphQLServiceProvider);
  final localStorage = ref.watch(localStorageProvider);

  try {
    final notifications = await graphQL.getNotifications(userId);
    await localStorage.saveNotifications(notifications);
    return notifications;
  } catch (e) {
    // Fallback a datos en caché
    return localStorage.getCachedNotifications();
  }
});

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsProvider);
  return notifications.when(
    data: (notifs) => notifs.where((n) => !n.read).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

// ============ Documents ============

final documentsProvider =
    FutureProvider.family<List<DocumentUpload>, String>((ref, processId) async {
  final graphQL = ref.watch(graphQLServiceProvider);
  return await graphQL.getDocuments(processId);
});

// ============ Workflow Controller ============

class WorkflowController extends StateNotifier<AsyncValue<void>> {
  final GraphQLService _graphQL;
  final LocalStorageService _localStorage;

  WorkflowController(this._graphQL, this._localStorage)
      : super(const AsyncValue.data(null));

  Future<void> completeTask(String taskId, Map<String, dynamic> result) async {
    state = const AsyncValue.loading();
    try {
      final success = await _graphQL.completeTask(taskId, result);
      if (success) {
        await _localStorage.updateTaskStatus(taskId, 'COMPLETED');
      }
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<DocumentUpload?> uploadDocument({
    required String processId,
    required String fileName,
    required String fileBase64,
    required String mimeType,
  }) async {
    state = const AsyncValue.loading();
    try {
      final document = await _graphQL.uploadDocument(
        processId: processId,
        fileName: fileName,
        fileBase64: fileBase64,
        mimeType: mimeType,
      );
      state = const AsyncValue.data(null);
      return document;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _graphQL.markNotificationAsRead(notificationId);
    } catch (e) {
      // Log error but don't fail
    }
  }

  Future<void> syncAllData(String userId) async {
    state = const AsyncValue.loading();
    try {
      await Future.wait([
        _graphQL.getProcesses(userId).then(_localStorage.saveProceses),
        _graphQL.getTasks(userId).then(_localStorage.saveTasks),
        _graphQL.getNotifications(userId).then(_localStorage.saveNotifications),
      ]);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final workflowControllerProvider =
    StateNotifierProvider<WorkflowController, AsyncValue<void>>((ref) {
  final graphQL = ref.watch(graphQLServiceProvider);
  final localStorage = ref.watch(localStorageProvider);
  return WorkflowController(graphQL, localStorage);
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController(this._authService, this._localStorage, this._ref) : super(const AsyncValue.data(null));

  final AuthService _authService;
  final LocalStorageService _localStorage;
  final Ref _ref;

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    final response = await _authService.login(username, password);
    final token = response['token'] as String;
    final user = response['user'] as Map<String, dynamic>;
    final userId = user['id'] as String;
    final authenticatedUsername = user['username'] as String;

    await _localStorage.saveAuthSession(token, userId, authenticatedUsername);
    _ref.read(authTokenProvider.notifier).state = token;
    _ref.read(userIdProvider.notifier).state = userId;
    _ref.read(usernameProvider.notifier).state = authenticatedUsername;
    state = const AsyncValue.data(null);
  }

  Future<void> logout() async {
    await _localStorage.clearAuthSession();
    await _localStorage.clearAll();
    _ref.read(authTokenProvider.notifier).state = null;
    _ref.read(userIdProvider.notifier).state = null;
    _ref.read(usernameProvider.notifier).state = null;
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  final localStorage = ref.watch(localStorageProvider);
  return AuthController(authService, localStorage, ref);
});
