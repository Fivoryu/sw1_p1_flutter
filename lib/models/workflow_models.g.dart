// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProcessInstanceAdapter extends TypeAdapter<CachedProcessInstance> {
  @override
  final int typeId = 1;

  @override
  CachedProcessInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProcessInstance(
      id: fields[0] as String,
      policyId: fields[1] as String,
      policyName: fields[2] as String,
      status: fields[3] as String,
      variables: fields[4] as String,
      initiatedAt: fields[5] as DateTime,
      completedAt: fields[6] as DateTime?,
      syncedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProcessInstance obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.policyId)
      ..writeByte(2)
      ..write(obj.policyName)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.variables)
      ..writeByte(5)
      ..write(obj.initiatedAt)
      ..writeByte(6)
      ..write(obj.completedAt)
      ..writeByte(7)
      ..write(obj.syncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProcessInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CachedTaskAdapter extends TypeAdapter<CachedTask> {
  @override
  final int typeId = 2;

  @override
  CachedTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedTask(
      id: fields[0] as String,
      processInstanceId: fields[1] as String,
      nodeId: fields[2] as String,
      nodeName: fields[3] as String,
      status: fields[4] as String,
      formData: fields[5] as String,
      createdAt: fields[6] as DateTime,
      syncedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedTask obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.processInstanceId)
      ..writeByte(2)
      ..write(obj.nodeId)
      ..writeByte(3)
      ..write(obj.nodeName)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.formData)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.syncedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CachedNotificationAdapter extends TypeAdapter<CachedNotification> {
  @override
  final int typeId = 3;

  @override
  CachedNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedNotification(
      id: fields[0] as String,
      title: fields[1] as String,
      body: fields[2] as String,
      type: fields[3] as String,
      read: fields[4] as bool,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedNotification obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.read)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProcessInstanceImpl _$$ProcessInstanceImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcessInstanceImpl(
      id: json['id'] as String,
      policyId: json['policyId'] as String,
      policyName: json['policyName'] as String,
      policyVersion: (json['policyVersion'] as num).toInt(),
      status: json['status'] as String,
      variables: json['variables'] as Map<String, dynamic>,
      initiatedAt: DateTime.parse(json['initiatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      history: (json['history'] as List<dynamic>)
          .map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProcessInstanceImplToJson(
        _$ProcessInstanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'policyId': instance.policyId,
      'policyName': instance.policyName,
      'policyVersion': instance.policyVersion,
      'status': instance.status,
      'variables': instance.variables,
      'initiatedAt': instance.initiatedAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'history': instance.history,
    };

_$HistoryEntryImpl _$$HistoryEntryImplFromJson(Map<String, dynamic> json) =>
    _$HistoryEntryImpl(
      nodeId: json['nodeId'] as String,
      nodeType: json['nodeType'] as String,
      nodeName: json['nodeName'] as String,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      taskResult: json['taskResult'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$HistoryEntryImplToJson(_$HistoryEntryImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'nodeType': instance.nodeType,
      'nodeName': instance.nodeName,
      'status': instance.status,
      'timestamp': instance.timestamp.toIso8601String(),
      'taskResult': instance.taskResult,
    };

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      processInstanceId: json['processInstanceId'] as String,
      nodeId: json['nodeId'] as String,
      nodeName: json['nodeName'] as String,
      assignee: json['assignee'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      status: json['status'] as String,
      formData: json['formData'] as Map<String, dynamic>,
      requiredDocuments: (json['requiredDocuments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'processInstanceId': instance.processInstanceId,
      'nodeId': instance.nodeId,
      'nodeName': instance.nodeName,
      'assignee': instance.assignee,
      'createdAt': instance.createdAt.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'status': instance.status,
      'formData': instance.formData,
      'requiredDocuments': instance.requiredDocuments,
    };

_$PolicyImpl _$$PolicyImplFromJson(Map<String, dynamic> json) => _$PolicyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      version: (json['version'] as num).toInt(),
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PolicyImplToJson(_$PolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'version': instance.version,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'description': instance.description,
    };

_$DocumentUploadImpl _$$DocumentUploadImplFromJson(Map<String, dynamic> json) =>
    _$DocumentUploadImpl(
      id: json['id'] as String,
      processInstanceId: json['processInstanceId'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      status: json['status'] as String,
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$$DocumentUploadImplToJson(
        _$DocumentUploadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'processInstanceId': instance.processInstanceId,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'mimeType': instance.mimeType,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'status': instance.status,
      'rejectionReason': instance.rejectionReason,
    };

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String,
      relatedId: json['relatedId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      read: json['read'] as bool,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'relatedId': instance.relatedId,
      'createdAt': instance.createdAt.toIso8601String(),
      'read': instance.read,
    };
