// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      owner: json['owner'] as int?,
      taskGroups: (json['taskGroups'] as List<dynamic>?)
          ?.map((e) => TaskGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
      'taskGroups': instance.taskGroups,
    };
