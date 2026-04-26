import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import '../models/workflow_models.dart';

class LocalStorageService {
  static const String PROCESSES_BOX = 'processes';
  static const String TASKS_BOX = 'tasks';
  static const String NOTIFICATIONS_BOX = 'notifications';
  static const String SYNC_METADATA_BOX = 'sync_metadata';
  static const String AUTH_TOKEN_KEY = 'auth_token';
  static const String AUTH_USER_ID_KEY = 'auth_user_id';
  static const String AUTH_USERNAME_KEY = 'auth_username';

  late Box<CachedProcessInstance> _processesBox;
  late Box<CachedTask> _tasksBox;
  late Box<CachedNotification> _notificationsBox;
  late Box<String> _syncMetadataBox;
  
  final Logger _logger = Logger();

  /// Inicializa Hive y abre las cajas
  Future<void> init() async {
    try {
      // Registrar adaptadores
      Hive.registerAdapter(CachedProcessInstanceAdapter());
      Hive.registerAdapter(CachedTaskAdapter());
      Hive.registerAdapter(CachedNotificationAdapter());

      // Abrir cajas
      _processesBox = await Hive.openBox<CachedProcessInstance>(PROCESSES_BOX);
      _tasksBox = await Hive.openBox<CachedTask>(TASKS_BOX);
      _notificationsBox = await Hive.openBox<CachedNotification>(NOTIFICATIONS_BOX);
      _syncMetadataBox = await Hive.openBox<String>(SYNC_METADATA_BOX);

      _logger.i('LocalStorageService initialized');
    } catch (e) {
      _logger.e('Error initializing LocalStorageService: $e');
      rethrow;
    }
  }

  // ============ Procesos ============

  Future<void> saveProceses(List<ProcessInstance> processes) async {
    try {
      await _processesBox.clear();
      for (final process in processes) {
        final cached = CachedProcessInstance(
          id: process.id,
          policyId: process.policyId,
          policyName: process.policyName,
          status: process.status,
          variables: jsonEncode(process.variables),
          initiatedAt: process.initiatedAt,
          completedAt: process.completedAt,
          syncedAt: DateTime.now(),
        );
        await _processesBox.put(process.id, cached);
      }
      _logger.i('Saved ${processes.length} processes');
    } catch (e) {
      _logger.e('Error saving processes: $e');
    }
  }

  List<ProcessInstance> getCachedProcesses() {
    try {
      return _processesBox.values.map((cached) {
        return ProcessInstance(
          id: cached.id,
          policyId: cached.policyId,
          policyName: cached.policyName,
          policyVersion: 1, // TODO: obtener del cache
          status: cached.status,
          variables: jsonDecode(cached.variables),
          initiatedAt: cached.initiatedAt,
          completedAt: cached.completedAt,
          history: [],
        );
      }).toList();
    } catch (e) {
      _logger.e('Error reading processes: $e');
      return [];
    }
  }

  ProcessInstance? getCachedProcess(String processId) {
    try {
      final cached = _processesBox.get(processId);
      if (cached == null) return null;

      return ProcessInstance(
        id: cached.id,
        policyId: cached.policyId,
        policyName: cached.policyName,
        policyVersion: 1,
        status: cached.status,
        variables: jsonDecode(cached.variables),
        initiatedAt: cached.initiatedAt,
        completedAt: cached.completedAt,
        history: [],
      );
    } catch (e) {
      _logger.e('Error reading process: $e');
      return null;
    }
  }

  // ============ Tareas ============

  Future<void> saveTasks(List<Task> tasks) async {
    try {
      await _tasksBox.clear();
      for (final task in tasks) {
        final cached = CachedTask(
          id: task.id,
          processInstanceId: task.processInstanceId,
          nodeId: task.nodeId,
          nodeName: task.nodeName,
          status: task.status,
          formData: jsonEncode(task.formData),
          createdAt: task.createdAt,
          syncedAt: DateTime.now(),
        );
        await _tasksBox.put(task.id, cached);
      }
      _logger.i('Saved ${tasks.length} tasks');
    } catch (e) {
      _logger.e('Error saving tasks: $e');
    }
  }

  List<Task> getCachedTasks() {
    try {
      return _tasksBox.values.map((cached) {
        return Task(
          id: cached.id,
          processInstanceId: cached.processInstanceId,
          nodeId: cached.nodeId,
          nodeName: cached.nodeName,
          assignee: '', // TODO
          createdAt: cached.createdAt,
          status: cached.status,
          formData: jsonDecode(cached.formData),
        );
      }).toList();
    } catch (e) {
      _logger.e('Error reading tasks: $e');
      return [];
    }
  }

  Task? getCachedTask(String taskId) {
    try {
      final cached = _tasksBox.get(taskId);
      if (cached == null) return null;

      return Task(
        id: cached.id,
        processInstanceId: cached.processInstanceId,
        nodeId: cached.nodeId,
        nodeName: cached.nodeName,
        assignee: '',
        createdAt: cached.createdAt,
        status: cached.status,
        formData: jsonDecode(cached.formData),
      );
    } catch (e) {
      _logger.e('Error reading task: $e');
      return null;
    }
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    try {
      final cached = _tasksBox.get(taskId);
      if (cached != null) {
        cached.status = newStatus;
        await cached.save();
        _logger.i('Updated task $taskId status to $newStatus');
      }
    } catch (e) {
      _logger.e('Error updating task status: $e');
    }
  }

  // ============ Notificaciones ============

  Future<void> saveNotifications(List<NotificationModel> notifications) async {
    try {
      for (final notification in notifications) {
        final cached = CachedNotification(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          type: notification.type,
          read: notification.read,
          createdAt: notification.createdAt,
        );
        await _notificationsBox.put(notification.id, cached);
      }
      _logger.i('Saved ${notifications.length} notifications');
    } catch (e) {
      _logger.e('Error saving notifications: $e');
    }
  }

  List<NotificationModel> getCachedNotifications() {
    try {
      return _notificationsBox.values.map((cached) {
        return NotificationModel(
          id: cached.id,
          userId: '', // TODO
          title: cached.title,
          body: cached.body,
          type: cached.type,
          relatedId: '',
          createdAt: cached.createdAt,
          read: cached.read,
        );
      }).toList();
    } catch (e) {
      _logger.e('Error reading notifications: $e');
      return [];
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      final cached = _notificationsBox.get(notificationId);
      if (cached != null) {
        cached.read = true;
        await cached.save();
      }
    } catch (e) {
      _logger.e('Error marking notification as read: $e');
    }
  }

  // ============ Metadatos de sincronización ============

  Future<void> setLastSyncTime(String key, DateTime time) async {
    try {
      await _syncMetadataBox.put(key, time.toIso8601String());
    } catch (e) {
      _logger.e('Error setting sync time: $e');
    }
  }

  DateTime? getLastSyncTime(String key) {
    try {
      final timeString = _syncMetadataBox.get(key);
      if (timeString == null) return null;
      return DateTime.parse(timeString);
    } catch (e) {
      _logger.e('Error getting sync time: $e');
      return null;
    }
  }

  // ============ Limpieza ============

  Future<void> clearAll() async {
    try {
      await Future.wait([
        _processesBox.clear(),
        _tasksBox.clear(),
        _notificationsBox.clear(),
        _syncMetadataBox.clear(),
      ]);
      _logger.i('All caches cleared');
    } catch (e) {
      _logger.e('Error clearing caches: $e');
    }
  }

  Future<void> close() async {
    try {
      await Future.wait([
        _processesBox.close(),
        _tasksBox.close(),
        _notificationsBox.close(),
        _syncMetadataBox.close(),
      ]);
    } catch (e) {
      _logger.e('Error closing boxes: $e');
    }
  }

  Future<void> saveAuthSession(String token, String userId, String username) async {
    await _syncMetadataBox.put(AUTH_TOKEN_KEY, token);
    await _syncMetadataBox.put(AUTH_USER_ID_KEY, userId);
    await _syncMetadataBox.put(AUTH_USERNAME_KEY, username);
  }

  String? getAuthToken() {
    return _syncMetadataBox.get(AUTH_TOKEN_KEY);
  }

  String? getStoredUserId() {
    return _syncMetadataBox.get(AUTH_USER_ID_KEY);
  }

  String? getStoredUsername() {
    return _syncMetadataBox.get(AUTH_USERNAME_KEY);
  }

  Future<void> clearAuthSession() async {
    await _syncMetadataBox.delete(AUTH_TOKEN_KEY);
    await _syncMetadataBox.delete(AUTH_USER_ID_KEY);
    await _syncMetadataBox.delete(AUTH_USERNAME_KEY);
  }
}
