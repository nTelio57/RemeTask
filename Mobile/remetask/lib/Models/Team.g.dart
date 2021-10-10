// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      json['id'] as int,
      json['name'] as String,
      User.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
    };
