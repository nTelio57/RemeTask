// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
      json['id'] as int,
      json['name'] as String,
      User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
    };
