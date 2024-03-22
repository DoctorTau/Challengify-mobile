// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Challenge _$ChallengeFromJson(Map<String, dynamic> json) => Challenge(
      challengeId: json['challengeId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      periodicity: json['periodicity'] as int,
      resultIds: _listIntJson(json['resultIds'] as Map<String, dynamic>),
      participantIds:
          _listIntJson(json['participantIds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChallengeToJson(Challenge instance) => <String, dynamic>{
      'challengeId': instance.challengeId,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'periodicity': instance.periodicity,
      'resultIds': instance.resultIds,
      'participantIds': instance.participantIds,
    };
