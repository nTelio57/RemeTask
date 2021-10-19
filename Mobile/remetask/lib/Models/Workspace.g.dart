// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
      json['id'] as int,
      json['name'] as String,
      json['ownerId'] as int,
      (json['taskGroups'] as List<dynamic>)
          .map((e) => TaskGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'taskGroups': instance.taskGroups,
    };
