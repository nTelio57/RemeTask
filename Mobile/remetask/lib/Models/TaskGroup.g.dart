// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskGroup _$TaskGroupFromJson(Map<String, dynamic> json) => TaskGroup(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      workspace: json['workspace'] == null
          ? null
          : Workspace.fromJson(json['workspace'] as Map<String, dynamic>),
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
      workspaceId: json['workspaceId'] as int?,
    );

Map<String, dynamic> _$TaskGroupToJson(TaskGroup instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'tag': instance.tag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('workspace', instance.workspace?.toJson());
  val['workspaceId'] = instance.workspaceId;
  val['tasks'] = instance.tasks?.map((e) => e.toJson()).toList();
  return val;
}
