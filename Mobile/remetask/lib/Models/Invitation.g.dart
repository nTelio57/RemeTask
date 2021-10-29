// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      id: json['id'] as int?,
      invitationDate: json['invitationDate'] == null
          ? null
          : DateTime.parse(json['invitationDate'] as String),
      workspace: json['workspace'] == null
          ? null
          : Workspace.fromJson(json['workspace'] as Map<String, dynamic>),
      inviter: json['inviter'] == null
          ? null
          : User.fromJson(json['inviter'] as Map<String, dynamic>),
      invitee: json['invitee'] == null
          ? null
          : User.fromJson(json['invitee'] as Map<String, dynamic>),
      workspaceId: json['workspaceId'] as int?,
      inviteeId: json['inviteeId'] as int?,
      inviterId: json['inviterId'] as int?,
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'invitationDate': instance.invitationDate?.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('workspace', instance.workspace);
  writeNotNull('inviter', instance.inviter);
  writeNotNull('invitee', instance.invitee);
  val['workspaceId'] = instance.workspaceId;
  val['inviterId'] = instance.inviterId;
  val['inviteeId'] = instance.inviteeId;
  return val;
}
