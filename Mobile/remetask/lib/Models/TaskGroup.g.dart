// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskGroup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskGroup _$TaskGroupFromJson(Map<String, dynamic> json) => TaskGroup(
      json['id'] as int,
      json['name'] as String,
      json['tag'] as String,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      json['workspace'] == null
          ? null
          : Workspace.fromJson(json['workspace'] as Map<String, dynamic>),
      (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskGroupToJson(TaskGroup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tag': instance.tag,
      'user': instance.user?.toJson(),
      'workspace': instance.workspace?.toJson(),
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };
