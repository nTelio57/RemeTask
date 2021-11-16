import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/Task.dart';
import 'package:remetask/Models/TaskGroup.dart';

import 'User.dart';
part 'Workspace.g.dart';

@JsonSerializable()
class Workspace {
  Workspace({this.id, this.name = '', this.owner, this.taskGroups, this.users});

  int? id;
  String name;
  String? owner;
  List<TaskGroup>? taskGroups;
  List<User>? users;

  factory Workspace.fromJson(Map<String, dynamic> json) => _$WorkspaceFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);

  int getTotalTaskCount()
  {
    int sum = 0;
    taskGroups!.forEach((element) { sum += element.tasks!.length; });
    return sum;
  }

  int getTotalDeadlineCount()
  {
    int sum = 0;
    taskGroups!.forEach((element) { sum += element.getDeadlineCount(); });
    return sum;
  }

  int getTotalCompletedCount()
  {
    int sum = 0;
    taskGroups!.forEach((element) { sum += element.getTotalCompletedCount(); });
    return sum;
  }

  void addTaskGroup(TaskGroup taskGroup)
  {
    taskGroups!.add(taskGroup);
  }

  void setUsers(List<User> users)
  {
    this.users = users;
  }
}