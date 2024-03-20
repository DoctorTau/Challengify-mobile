// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_creation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeCreationDtoImpl _$$ChallengeCreationDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ChallengeCreationDtoImpl(
      title: json['title'] as String,
      description: json['description'] as String?,
      periodicity: json['periodicity'] as int?,
    );

Map<String, dynamic> _$$ChallengeCreationDtoImplToJson(
        _$ChallengeCreationDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'periodicity': instance.periodicity,
    };
