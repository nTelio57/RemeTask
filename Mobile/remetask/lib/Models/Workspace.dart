import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/TaskGroup.dart';

import 'User.dart';
part 'Workspace.g.dart';

@JsonSerializable()
class Workspace {
  Workspace(this.id, this.name, this.ownerId, this.taskGroups);

  int id;
  String name;
  int ownerId;
  List<TaskGroup> taskGroups;

  factory Workspace.fromJson(Map<String, dynamic> json) => _$WorkspaceFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);
}