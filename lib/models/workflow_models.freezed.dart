// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProcessInstance _$ProcessInstanceFromJson(Map<String, dynamic> json) {
  return _ProcessInstance.fromJson(json);
}

/// @nodoc
mixin _$ProcessInstance {
  String get id => throw _privateConstructorUsedError;
  String get policyId => throw _privateConstructorUsedError;
  String get policyName => throw _privateConstructorUsedError;
  int get policyVersion => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // RUNNING, COMPLETED, FAILED
  Map<String, dynamic> get variables => throw _privateConstructorUsedError;
  DateTime get initiatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  List<HistoryEntry> get history => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProcessInstanceCopyWith<ProcessInstance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessInstanceCopyWith<$Res> {
  factory $ProcessInstanceCopyWith(
          ProcessInstance value, $Res Function(ProcessInstance) then) =
      _$ProcessInstanceCopyWithImpl<$Res, ProcessInstance>;
  @useResult
  $Res call(
      {String id,
      String policyId,
      String policyName,
      int policyVersion,
      String status,
      Map<String, dynamic> variables,
      DateTime initiatedAt,
      DateTime? completedAt,
      List<HistoryEntry> history});
}

/// @nodoc
class _$ProcessInstanceCopyWithImpl<$Res, $Val extends ProcessInstance>
    implements $ProcessInstanceCopyWith<$Res> {
  _$ProcessInstanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? policyId = null,
    Object? policyName = null,
    Object? policyVersion = null,
    Object? status = null,
    Object? variables = null,
    Object? initiatedAt = null,
    Object? completedAt = freezed,
    Object? history = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      policyId: null == policyId
          ? _value.policyId
          : policyId // ignore: cast_nullable_to_non_nullable
              as String,
      policyName: null == policyName
          ? _value.policyName
          : policyName // ignore: cast_nullable_to_non_nullable
              as String,
      policyVersion: null == policyVersion
          ? _value.policyVersion
          : policyVersion // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      initiatedAt: null == initiatedAt
          ? _value.initiatedAt
          : initiatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<HistoryEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessInstanceImplCopyWith<$Res>
    implements $ProcessInstanceCopyWith<$Res> {
  factory _$$ProcessInstanceImplCopyWith(_$ProcessInstanceImpl value,
          $Res Function(_$ProcessInstanceImpl) then) =
      __$$ProcessInstanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String policyId,
      String policyName,
      int policyVersion,
      String status,
      Map<String, dynamic> variables,
      DateTime initiatedAt,
      DateTime? completedAt,
      List<HistoryEntry> history});
}

/// @nodoc
class __$$ProcessInstanceImplCopyWithImpl<$Res>
    extends _$ProcessInstanceCopyWithImpl<$Res, _$ProcessInstanceImpl>
    implements _$$ProcessInstanceImplCopyWith<$Res> {
  __$$ProcessInstanceImplCopyWithImpl(
      _$ProcessInstanceImpl _value, $Res Function(_$ProcessInstanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? policyId = null,
    Object? policyName = null,
    Object? policyVersion = null,
    Object? status = null,
    Object? variables = null,
    Object? initiatedAt = null,
    Object? completedAt = freezed,
    Object? history = null,
  }) {
    return _then(_$ProcessInstanceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      policyId: null == policyId
          ? _value.policyId
          : policyId // ignore: cast_nullable_to_non_nullable
              as String,
      policyName: null == policyName
          ? _value.policyName
          : policyName // ignore: cast_nullable_to_non_nullable
              as String,
      policyVersion: null == policyVersion
          ? _value.policyVersion
          : policyVersion // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      initiatedAt: null == initiatedAt
          ? _value.initiatedAt
          : initiatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<HistoryEntry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcessInstanceImpl implements _ProcessInstance {
  const _$ProcessInstanceImpl(
      {required this.id,
      required this.policyId,
      required this.policyName,
      required this.policyVersion,
      required this.status,
      required final Map<String, dynamic> variables,
      required this.initiatedAt,
      this.completedAt,
      required final List<HistoryEntry> history})
      : _variables = variables,
        _history = history;

  factory _$ProcessInstanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcessInstanceImplFromJson(json);

  @override
  final String id;
  @override
  final String policyId;
  @override
  final String policyName;
  @override
  final int policyVersion;
  @override
  final String status;
// RUNNING, COMPLETED, FAILED
  final Map<String, dynamic> _variables;
// RUNNING, COMPLETED, FAILED
  @override
  Map<String, dynamic> get variables {
    if (_variables is EqualUnmodifiableMapView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_variables);
  }

  @override
  final DateTime initiatedAt;
  @override
  final DateTime? completedAt;
  final List<HistoryEntry> _history;
  @override
  List<HistoryEntry> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString() {
    return 'ProcessInstance(id: $id, policyId: $policyId, policyName: $policyName, policyVersion: $policyVersion, status: $status, variables: $variables, initiatedAt: $initiatedAt, completedAt: $completedAt, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessInstanceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.policyId, policyId) ||
                other.policyId == policyId) &&
            (identical(other.policyName, policyName) ||
                other.policyName == policyName) &&
            (identical(other.policyVersion, policyVersion) ||
                other.policyVersion == policyVersion) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables) &&
            (identical(other.initiatedAt, initiatedAt) ||
                other.initiatedAt == initiatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      policyId,
      policyName,
      policyVersion,
      status,
      const DeepCollectionEquality().hash(_variables),
      initiatedAt,
      completedAt,
      const DeepCollectionEquality().hash(_history));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessInstanceImplCopyWith<_$ProcessInstanceImpl> get copyWith =>
      __$$ProcessInstanceImplCopyWithImpl<_$ProcessInstanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessInstanceImplToJson(
      this,
    );
  }
}

abstract class _ProcessInstance implements ProcessInstance {
  const factory _ProcessInstance(
      {required final String id,
      required final String policyId,
      required final String policyName,
      required final int policyVersion,
      required final String status,
      required final Map<String, dynamic> variables,
      required final DateTime initiatedAt,
      final DateTime? completedAt,
      required final List<HistoryEntry> history}) = _$ProcessInstanceImpl;

  factory _ProcessInstance.fromJson(Map<String, dynamic> json) =
      _$ProcessInstanceImpl.fromJson;

  @override
  String get id;
  @override
  String get policyId;
  @override
  String get policyName;
  @override
  int get policyVersion;
  @override
  String get status;
  @override // RUNNING, COMPLETED, FAILED
  Map<String, dynamic> get variables;
  @override
  DateTime get initiatedAt;
  @override
  DateTime? get completedAt;
  @override
  List<HistoryEntry> get history;
  @override
  @JsonKey(ignore: true)
  _$$ProcessInstanceImplCopyWith<_$ProcessInstanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) {
  return _HistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$HistoryEntry {
  String get nodeId => throw _privateConstructorUsedError;
  String get nodeType => throw _privateConstructorUsedError;
  String get nodeName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get taskResult => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HistoryEntryCopyWith<HistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryEntryCopyWith<$Res> {
  factory $HistoryEntryCopyWith(
          HistoryEntry value, $Res Function(HistoryEntry) then) =
      _$HistoryEntryCopyWithImpl<$Res, HistoryEntry>;
  @useResult
  $Res call(
      {String nodeId,
      String nodeType,
      String nodeName,
      String status,
      DateTime timestamp,
      Map<String, dynamic>? taskResult});
}

/// @nodoc
class _$HistoryEntryCopyWithImpl<$Res, $Val extends HistoryEntry>
    implements $HistoryEntryCopyWith<$Res> {
  _$HistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? nodeType = null,
    Object? nodeName = null,
    Object? status = null,
    Object? timestamp = null,
    Object? taskResult = freezed,
  }) {
    return _then(_value.copyWith(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeType: null == nodeType
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as String,
      nodeName: null == nodeName
          ? _value.nodeName
          : nodeName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskResult: freezed == taskResult
          ? _value.taskResult
          : taskResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryEntryImplCopyWith<$Res>
    implements $HistoryEntryCopyWith<$Res> {
  factory _$$HistoryEntryImplCopyWith(
          _$HistoryEntryImpl value, $Res Function(_$HistoryEntryImpl) then) =
      __$$HistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nodeId,
      String nodeType,
      String nodeName,
      String status,
      DateTime timestamp,
      Map<String, dynamic>? taskResult});
}

/// @nodoc
class __$$HistoryEntryImplCopyWithImpl<$Res>
    extends _$HistoryEntryCopyWithImpl<$Res, _$HistoryEntryImpl>
    implements _$$HistoryEntryImplCopyWith<$Res> {
  __$$HistoryEntryImplCopyWithImpl(
      _$HistoryEntryImpl _value, $Res Function(_$HistoryEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? nodeType = null,
    Object? nodeName = null,
    Object? status = null,
    Object? timestamp = null,
    Object? taskResult = freezed,
  }) {
    return _then(_$HistoryEntryImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeType: null == nodeType
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as String,
      nodeName: null == nodeName
          ? _value.nodeName
          : nodeName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      taskResult: freezed == taskResult
          ? _value._taskResult
          : taskResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryEntryImpl implements _HistoryEntry {
  const _$HistoryEntryImpl(
      {required this.nodeId,
      required this.nodeType,
      required this.nodeName,
      required this.status,
      required this.timestamp,
      final Map<String, dynamic>? taskResult})
      : _taskResult = taskResult;

  factory _$HistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryEntryImplFromJson(json);

  @override
  final String nodeId;
  @override
  final String nodeType;
  @override
  final String nodeName;
  @override
  final String status;
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _taskResult;
  @override
  Map<String, dynamic>? get taskResult {
    final value = _taskResult;
    if (value == null) return null;
    if (_taskResult is EqualUnmodifiableMapView) return _taskResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HistoryEntry(nodeId: $nodeId, nodeType: $nodeType, nodeName: $nodeName, status: $status, timestamp: $timestamp, taskResult: $taskResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryEntryImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.nodeType, nodeType) ||
                other.nodeType == nodeType) &&
            (identical(other.nodeName, nodeName) ||
                other.nodeName == nodeName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._taskResult, _taskResult));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, nodeType, nodeName,
      status, timestamp, const DeepCollectionEquality().hash(_taskResult));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      __$$HistoryEntryImplCopyWithImpl<_$HistoryEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _HistoryEntry implements HistoryEntry {
  const factory _HistoryEntry(
      {required final String nodeId,
      required final String nodeType,
      required final String nodeName,
      required final String status,
      required final DateTime timestamp,
      final Map<String, dynamic>? taskResult}) = _$HistoryEntryImpl;

  factory _HistoryEntry.fromJson(Map<String, dynamic> json) =
      _$HistoryEntryImpl.fromJson;

  @override
  String get nodeId;
  @override
  String get nodeType;
  @override
  String get nodeName;
  @override
  String get status;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get taskResult;
  @override
  @JsonKey(ignore: true)
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get processInstanceId => throw _privateConstructorUsedError;
  String get nodeId => throw _privateConstructorUsedError;
  String get nodeName => throw _privateConstructorUsedError;
  String get assignee => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // PENDING, COMPLETED, REJECTED
  Map<String, dynamic> get formData => throw _privateConstructorUsedError;
  List<String>? get requiredDocuments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      String processInstanceId,
      String nodeId,
      String nodeName,
      String assignee,
      DateTime createdAt,
      DateTime? dueDate,
      String status,
      Map<String, dynamic> formData,
      List<String>? requiredDocuments});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? processInstanceId = null,
    Object? nodeId = null,
    Object? nodeName = null,
    Object? assignee = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? formData = null,
    Object? requiredDocuments = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      processInstanceId: null == processInstanceId
          ? _value.processInstanceId
          : processInstanceId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeName: null == nodeName
          ? _value.nodeName
          : nodeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignee: null == assignee
          ? _value.assignee
          : assignee // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      formData: null == formData
          ? _value.formData
          : formData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      requiredDocuments: freezed == requiredDocuments
          ? _value.requiredDocuments
          : requiredDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String processInstanceId,
      String nodeId,
      String nodeName,
      String assignee,
      DateTime createdAt,
      DateTime? dueDate,
      String status,
      Map<String, dynamic> formData,
      List<String>? requiredDocuments});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? processInstanceId = null,
    Object? nodeId = null,
    Object? nodeName = null,
    Object? assignee = null,
    Object? createdAt = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? formData = null,
    Object? requiredDocuments = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      processInstanceId: null == processInstanceId
          ? _value.processInstanceId
          : processInstanceId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      nodeName: null == nodeName
          ? _value.nodeName
          : nodeName // ignore: cast_nullable_to_non_nullable
              as String,
      assignee: null == assignee
          ? _value.assignee
          : assignee // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      formData: null == formData
          ? _value._formData
          : formData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      requiredDocuments: freezed == requiredDocuments
          ? _value._requiredDocuments
          : requiredDocuments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {required this.id,
      required this.processInstanceId,
      required this.nodeId,
      required this.nodeName,
      required this.assignee,
      required this.createdAt,
      this.dueDate,
      required this.status,
      required final Map<String, dynamic> formData,
      final List<String>? requiredDocuments})
      : _formData = formData,
        _requiredDocuments = requiredDocuments;

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String processInstanceId;
  @override
  final String nodeId;
  @override
  final String nodeName;
  @override
  final String assignee;
  @override
  final DateTime createdAt;
  @override
  final DateTime? dueDate;
  @override
  final String status;
// PENDING, COMPLETED, REJECTED
  final Map<String, dynamic> _formData;
// PENDING, COMPLETED, REJECTED
  @override
  Map<String, dynamic> get formData {
    if (_formData is EqualUnmodifiableMapView) return _formData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_formData);
  }

  final List<String>? _requiredDocuments;
  @override
  List<String>? get requiredDocuments {
    final value = _requiredDocuments;
    if (value == null) return null;
    if (_requiredDocuments is EqualUnmodifiableListView)
      return _requiredDocuments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Task(id: $id, processInstanceId: $processInstanceId, nodeId: $nodeId, nodeName: $nodeName, assignee: $assignee, createdAt: $createdAt, dueDate: $dueDate, status: $status, formData: $formData, requiredDocuments: $requiredDocuments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.processInstanceId, processInstanceId) ||
                other.processInstanceId == processInstanceId) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.nodeName, nodeName) ||
                other.nodeName == nodeName) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._formData, _formData) &&
            const DeepCollectionEquality()
                .equals(other._requiredDocuments, _requiredDocuments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      processInstanceId,
      nodeId,
      nodeName,
      assignee,
      createdAt,
      dueDate,
      status,
      const DeepCollectionEquality().hash(_formData),
      const DeepCollectionEquality().hash(_requiredDocuments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {required final String id,
      required final String processInstanceId,
      required final String nodeId,
      required final String nodeName,
      required final String assignee,
      required final DateTime createdAt,
      final DateTime? dueDate,
      required final String status,
      required final Map<String, dynamic> formData,
      final List<String>? requiredDocuments}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get processInstanceId;
  @override
  String get nodeId;
  @override
  String get nodeName;
  @override
  String get assignee;
  @override
  DateTime get createdAt;
  @override
  DateTime? get dueDate;
  @override
  String get status;
  @override // PENDING, COMPLETED, REJECTED
  Map<String, dynamic> get formData;
  @override
  List<String>? get requiredDocuments;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Policy _$PolicyFromJson(Map<String, dynamic> json) {
  return _Policy.fromJson(json);
}

/// @nodoc
mixin _$Policy {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PolicyCopyWith<Policy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PolicyCopyWith<$Res> {
  factory $PolicyCopyWith(Policy value, $Res Function(Policy) then) =
      _$PolicyCopyWithImpl<$Res, Policy>;
  @useResult
  $Res call(
      {String id,
      String name,
      int version,
      String status,
      DateTime? createdAt,
      String? description});
}

/// @nodoc
class _$PolicyCopyWithImpl<$Res, $Val extends Policy>
    implements $PolicyCopyWith<$Res> {
  _$PolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? version = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PolicyImplCopyWith<$Res> implements $PolicyCopyWith<$Res> {
  factory _$$PolicyImplCopyWith(
          _$PolicyImpl value, $Res Function(_$PolicyImpl) then) =
      __$$PolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int version,
      String status,
      DateTime? createdAt,
      String? description});
}

/// @nodoc
class __$$PolicyImplCopyWithImpl<$Res>
    extends _$PolicyCopyWithImpl<$Res, _$PolicyImpl>
    implements _$$PolicyImplCopyWith<$Res> {
  __$$PolicyImplCopyWithImpl(
      _$PolicyImpl _value, $Res Function(_$PolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? version = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? description = freezed,
  }) {
    return _then(_$PolicyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PolicyImpl implements _Policy {
  const _$PolicyImpl(
      {required this.id,
      required this.name,
      required this.version,
      required this.status,
      this.createdAt,
      this.description});

  factory _$PolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PolicyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int version;
  @override
  final String status;
  @override
  final DateTime? createdAt;
  @override
  final String? description;

  @override
  String toString() {
    return 'Policy(id: $id, name: $name, version: $version, status: $status, createdAt: $createdAt, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PolicyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, version, status, createdAt, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      __$$PolicyImplCopyWithImpl<_$PolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PolicyImplToJson(
      this,
    );
  }
}

abstract class _Policy implements Policy {
  const factory _Policy(
      {required final String id,
      required final String name,
      required final int version,
      required final String status,
      final DateTime? createdAt,
      final String? description}) = _$PolicyImpl;

  factory _Policy.fromJson(Map<String, dynamic> json) = _$PolicyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get version;
  @override
  String get status;
  @override
  DateTime? get createdAt;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$PolicyImplCopyWith<_$PolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentUpload _$DocumentUploadFromJson(Map<String, dynamic> json) {
  return _DocumentUpload.fromJson(json);
}

/// @nodoc
mixin _$DocumentUpload {
  String get id => throw _privateConstructorUsedError;
  String get processInstanceId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get fileType => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // PENDING, UPLOADED, REJECTED
  String? get rejectionReason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DocumentUploadCopyWith<DocumentUpload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentUploadCopyWith<$Res> {
  factory $DocumentUploadCopyWith(
          DocumentUpload value, $Res Function(DocumentUpload) then) =
      _$DocumentUploadCopyWithImpl<$Res, DocumentUpload>;
  @useResult
  $Res call(
      {String id,
      String processInstanceId,
      String fileName,
      String fileType,
      int fileSize,
      String mimeType,
      DateTime uploadedAt,
      String status,
      String? rejectionReason});
}

/// @nodoc
class _$DocumentUploadCopyWithImpl<$Res, $Val extends DocumentUpload>
    implements $DocumentUploadCopyWith<$Res> {
  _$DocumentUploadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? processInstanceId = null,
    Object? fileName = null,
    Object? fileType = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? uploadedAt = null,
    Object? status = null,
    Object? rejectionReason = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      processInstanceId: null == processInstanceId
          ? _value.processInstanceId
          : processInstanceId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentUploadImplCopyWith<$Res>
    implements $DocumentUploadCopyWith<$Res> {
  factory _$$DocumentUploadImplCopyWith(_$DocumentUploadImpl value,
          $Res Function(_$DocumentUploadImpl) then) =
      __$$DocumentUploadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String processInstanceId,
      String fileName,
      String fileType,
      int fileSize,
      String mimeType,
      DateTime uploadedAt,
      String status,
      String? rejectionReason});
}

/// @nodoc
class __$$DocumentUploadImplCopyWithImpl<$Res>
    extends _$DocumentUploadCopyWithImpl<$Res, _$DocumentUploadImpl>
    implements _$$DocumentUploadImplCopyWith<$Res> {
  __$$DocumentUploadImplCopyWithImpl(
      _$DocumentUploadImpl _value, $Res Function(_$DocumentUploadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? processInstanceId = null,
    Object? fileName = null,
    Object? fileType = null,
    Object? fileSize = null,
    Object? mimeType = null,
    Object? uploadedAt = null,
    Object? status = null,
    Object? rejectionReason = freezed,
  }) {
    return _then(_$DocumentUploadImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      processInstanceId: null == processInstanceId
          ? _value.processInstanceId
          : processInstanceId // ignore: cast_nullable_to_non_nullable
              as String,
      fileName: null == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String,
      fileType: null == fileType
          ? _value.fileType
          : fileType // ignore: cast_nullable_to_non_nullable
              as String,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      uploadedAt: null == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentUploadImpl implements _DocumentUpload {
  const _$DocumentUploadImpl(
      {required this.id,
      required this.processInstanceId,
      required this.fileName,
      required this.fileType,
      required this.fileSize,
      required this.mimeType,
      required this.uploadedAt,
      required this.status,
      this.rejectionReason});

  factory _$DocumentUploadImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentUploadImplFromJson(json);

  @override
  final String id;
  @override
  final String processInstanceId;
  @override
  final String fileName;
  @override
  final String fileType;
  @override
  final int fileSize;
  @override
  final String mimeType;
  @override
  final DateTime uploadedAt;
  @override
  final String status;
// PENDING, UPLOADED, REJECTED
  @override
  final String? rejectionReason;

  @override
  String toString() {
    return 'DocumentUpload(id: $id, processInstanceId: $processInstanceId, fileName: $fileName, fileType: $fileType, fileSize: $fileSize, mimeType: $mimeType, uploadedAt: $uploadedAt, status: $status, rejectionReason: $rejectionReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentUploadImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.processInstanceId, processInstanceId) ||
                other.processInstanceId == processInstanceId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, processInstanceId, fileName,
      fileType, fileSize, mimeType, uploadedAt, status, rejectionReason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentUploadImplCopyWith<_$DocumentUploadImpl> get copyWith =>
      __$$DocumentUploadImplCopyWithImpl<_$DocumentUploadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentUploadImplToJson(
      this,
    );
  }
}

abstract class _DocumentUpload implements DocumentUpload {
  const factory _DocumentUpload(
      {required final String id,
      required final String processInstanceId,
      required final String fileName,
      required final String fileType,
      required final int fileSize,
      required final String mimeType,
      required final DateTime uploadedAt,
      required final String status,
      final String? rejectionReason}) = _$DocumentUploadImpl;

  factory _DocumentUpload.fromJson(Map<String, dynamic> json) =
      _$DocumentUploadImpl.fromJson;

  @override
  String get id;
  @override
  String get processInstanceId;
  @override
  String get fileName;
  @override
  String get fileType;
  @override
  int get fileSize;
  @override
  String get mimeType;
  @override
  DateTime get uploadedAt;
  @override
  String get status;
  @override // PENDING, UPLOADED, REJECTED
  String? get rejectionReason;
  @override
  @JsonKey(ignore: true)
  _$$DocumentUploadImplCopyWith<_$DocumentUploadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // TASK_ASSIGNED, PROCESS_COMPLETED, DOCUMENT_REJECTED
  String get relatedId =>
      throw _privateConstructorUsedError; // processInstanceId or taskId
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get read => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      String relatedId,
      DateTime createdAt,
      bool read});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? relatedId = null,
    Object? createdAt = null,
    Object? read = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      relatedId: null == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationModelImplCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$NotificationModelImplCopyWith(_$NotificationModelImpl value,
          $Res Function(_$NotificationModelImpl) then) =
      __$$NotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      String relatedId,
      DateTime createdAt,
      bool read});
}

/// @nodoc
class __$$NotificationModelImplCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$NotificationModelImpl>
    implements _$$NotificationModelImplCopyWith<$Res> {
  __$$NotificationModelImplCopyWithImpl(_$NotificationModelImpl _value,
      $Res Function(_$NotificationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? relatedId = null,
    Object? createdAt = null,
    Object? read = null,
  }) {
    return _then(_$NotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      relatedId: null == relatedId
          ? _value.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationModelImpl implements _NotificationModel {
  const _$NotificationModelImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.type,
      required this.relatedId,
      required this.createdAt,
      required this.read});

  factory _$NotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
// TASK_ASSIGNED, PROCESS_COMPLETED, DOCUMENT_REJECTED
  @override
  final String relatedId;
// processInstanceId or taskId
  @override
  final DateTime createdAt;
  @override
  final bool read;

  @override
  String toString() {
    return 'NotificationModel(id: $id, userId: $userId, title: $title, body: $body, type: $type, relatedId: $relatedId, createdAt: $createdAt, read: $read)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.read, read) || other.read == read));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, title, body, type, relatedId, createdAt, read);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      __$$NotificationModelImplCopyWithImpl<_$NotificationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationModel implements NotificationModel {
  const factory _NotificationModel(
      {required final String id,
      required final String userId,
      required final String title,
      required final String body,
      required final String type,
      required final String relatedId,
      required final DateTime createdAt,
      required final bool read}) = _$NotificationModelImpl;

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$NotificationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get body;
  @override
  String get type;
  @override // TASK_ASSIGNED, PROCESS_COMPLETED, DOCUMENT_REJECTED
  String get relatedId;
  @override // processInstanceId or taskId
  DateTime get createdAt;
  @override
  bool get read;
  @override
  @JsonKey(ignore: true)
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
