import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/Workspace.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  User(this.id, this.email, {this.workspaces});

  int id;
  String email;
  List<Workspace>? workspaces;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}