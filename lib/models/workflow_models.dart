import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'workflow_models.freezed.dart';
part 'workflow_models.g.dart';

// ============ GraphQL Models ============

@freezed
class ProcessInstance with _$ProcessInstance {
  const factory ProcessInstance({
    required String id,
    required String policyId,
    required String policyName,
    required int policyVersion,
    required String status, // RUNNING, COMPLETED, FAILED
    required Map<String, dynamic> variables,
    required DateTime initiatedAt,
    DateTime? completedAt,
    required List<HistoryEntry> history,
  }) = _ProcessInstance;

  factory ProcessInstance.fromJson(Map<String, dynamic> json) =>
      _$ProcessInstanceFromJson(json);
}

@freezed
class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String nodeId,
    required String nodeType,
    required String nodeName,
    required String status,
    required DateTime timestamp,
    Map<String, dynamic>? taskResult,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntryFromJson(json);
}

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String processInstanceId,
    required String nodeId,
    required String nodeName,
    required String assignee,
    required DateTime createdAt,
    DateTime? dueDate,
    required String status, // PENDING, COMPLETED, REJECTED
    required Map<String, dynamic> formData,
    List<String>? requiredDocuments,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) =>
      _$TaskFromJson(json);
}

@freezed
class Policy with _$Policy {
  const factory Policy({
    required String id,
    required String name,
    required int version,
    required String status,
    DateTime? createdAt,
    String? description,
  }) = _Policy;

  factory Policy.fromJson(Map<String, dynamic> json) =>
      _$PolicyFromJson(json);
}

@freezed
class DocumentUpload with _$DocumentUpload {
  const factory DocumentUpload({
    required String id,
    required String processInstanceId,
    required String fileName,
    required String fileType,
    required int fileSize,
    required String mimeType,
    required DateTime uploadedAt,
    required String status, // PENDING, UPLOADED, REJECTED
    String? rejectionReason,
  }) = _DocumentUpload;

  factory DocumentUpload.fromJson(Map<String, dynamic> json) =>
      _$DocumentUploadFromJson(json);
}

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required String title,
    required String body,
    required String type, // TASK_ASSIGNED, PROCESS_COMPLETED, DOCUMENT_REJECTED
    required String relatedId, // processInstanceId or taskId
    required DateTime createdAt,
    required bool read,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

// ============ Hive Local Storage Models ============

@HiveType(typeId: 1)
class CachedProcessInstance extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String policyId;

  @HiveField(2)
  late String policyName;

  @HiveField(3)
  late String status;

  @HiveField(4)
  late String variables; // JSON string

  @HiveField(5)
  late DateTime initiatedAt;

  @HiveField(6)
  late DateTime? completedAt;

  @HiveField(7)
  late DateTime syncedAt;

  CachedProcessInstance({
    required this.id,
    required this.policyId,
    required this.policyName,
    required this.status,
    required this.variables,
    required this.initiatedAt,
    this.completedAt,
    required this.syncedAt,
  });
}

@HiveType(typeId: 2)
class CachedTask extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String processInstanceId;

  @HiveField(2)
  late String nodeId;

  @HiveField(3)
  late String nodeName;

  @HiveField(4)
  late String assignee;

  @HiveField(5)
  late String status;

  @HiveField(6)
  late String formData; // JSON string

  @HiveField(7)
  late DateTime createdAt;

  @HiveField(8)
  late DateTime syncedAt;

  CachedTask({
    required this.id,
    required this.processInstanceId,
    required this.nodeId,
    required this.nodeName,
    required this.assignee,
    required this.status,
    required this.formData,
    required this.createdAt,
    required this.syncedAt,
  });
}

@HiveType(typeId: 3)
class CachedNotification extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String body;

  @HiveField(3)
  late String type;

  @HiveField(4)
  late bool read;

  @HiveField(5)
  late DateTime createdAt;

  CachedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.read,
    required this.createdAt,
  });
}
