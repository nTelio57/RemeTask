import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/Task.dart';

import 'Team.dart';
import 'User.dart';
part 'TaskGroup.g.dart';

@JsonSerializable()
class TaskGroup {
  TaskGroup(this.id, this.name, this.tag, this.user, this.team, this.tasks);

  int id;
  String name;
  String tag;
  User? user;
  Team? team;
  List<Task> tasks;

  factory TaskGroup.fromJson(Map<String, dynamic> json) => _$TaskGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TaskGroupToJson(this);
}