import 'package:json_annotation/json_annotation.dart';
import 'package:remetask/Models/User.dart';
import 'package:remetask/Models/Workspace.dart';
part 'Invitation.g.dart';

@JsonSerializable()
class Invitation {
  Invitation({this.id, this.invitationDate, this.workspace, this.inviter, this.invitee, this.workspaceId, this.inviteeId, this.inviterId});

  int? id;
  DateTime? invitationDate;
  @JsonKey(toJson: null, includeIfNull: false)
  Workspace? workspace;
  @JsonKey(toJson: null, includeIfNull: false)
  User? inviter;
  @JsonKey(toJson: null, includeIfNull: false)
  User? invitee;

  int? workspaceId;
  int? inviterId;
  int? inviteeId;

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}