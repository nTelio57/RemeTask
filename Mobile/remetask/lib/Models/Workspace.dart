import 'package:json_annotation/json_annotation.dart';

import 'User.dart';
part 'Workspace.g.dart';

@JsonSerializable()
class Workspace {
  Workspace(this.id, this.name, this.owner);

  int id;
  String name;
  User owner;

  factory Workspace.fromJson(Map<String, dynamic> json) => _$WorkspaceFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);
}