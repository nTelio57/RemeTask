import 'package:json_annotation/json_annotation.dart';

import 'TaskGroup.dart';
part 'Task.g.dart';

@JsonSerializable()
class Task {
  Task(this.id, this.title, this.description, this.deadline, this.isCompleted, this.completionDate, this.priority, this.taskGroup);

  int id;
  String title;
  String description;
  DateTime deadline;
  bool isCompleted;
  DateTime? completionDate;
  int priority;
  TaskGroup? taskGroup;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}