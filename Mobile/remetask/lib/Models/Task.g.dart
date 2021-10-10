// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      DateTime.parse(json['deadline'] as String),
      json['isCompleted'] as bool,
      json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      json['priority'] as int,
      json['taskGroup'] == null
          ? null
          : TaskGroup.fromJson(json['taskGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'deadline': instance.deadline.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'completionDate': instance.completionDate?.toIso8601String(),
      'priority': instance.priority,
      'taskGroup': instance.taskGroup,
    };
