import 'package:json_annotation/json_annotation.dart';

import 'User.dart';
part 'Team.g.dart';

@JsonSerializable()
class Team {
  Team(this.id, this.name, this.owner);

  int id;
  String name;
  User owner;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}