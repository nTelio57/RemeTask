import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/Task.dart';

import 'Workspace.dart';
import 'User.dart';
part 'TaskGroup.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskGroup {
  TaskGroup(this.id, this.name, this.tag, this.workspace, this.tasks);

  int id;
  String name;
  String tag;
  Workspace? workspace;
  List<Task> tasks;

  factory TaskGroup.fromJson(Map<String, dynamic> json) => _$TaskGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TaskGroupToJson(this);

  int getTotalCompletedCount()
  {
    int sum = 0;
    tasks.forEach((element) { if(element.isCompleted!)sum++; });
    return sum;
  }
}