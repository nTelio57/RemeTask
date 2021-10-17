import 'package:json_annotation/json_annotation.dart';

import 'TaskGroup.dart';
part 'Task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  Task(this.title, this.description, this.deadline, this.isCompleted, this.completionDate, this.priority, this.taskGroup, this.taskGroupId);

  int? id;
  String title;
  String description;
  DateTime deadline;
  bool? isCompleted;
  DateTime? completionDate;
  int priority;
  TaskGroup? taskGroup;
  int? taskGroupId;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}