// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InvitationResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationResponse _$InvitationResponseFromJson(Map<String, dynamic> json) =>
    InvitationResponse(
      json['response'] as bool,
      json['invitationId'] as int,
    );

Map<String, dynamic> _$InvitationResponseToJson(InvitationResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'invitationId': instance.invitationId,
    };
