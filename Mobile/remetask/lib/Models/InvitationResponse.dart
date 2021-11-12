import 'package:json_annotation/json_annotation.dart';
part 'InvitationResponse.g.dart';

@JsonSerializable()
class InvitationResponse {
  InvitationResponse(this.response, this.invitationId);

  bool response;
  int invitationId;

  factory InvitationResponse.fromJson(Map<String, dynamic> json) => _$InvitationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationResponseToJson(this);
}