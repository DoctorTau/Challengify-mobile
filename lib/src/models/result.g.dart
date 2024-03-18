// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'resultId': instance.resultId,
      'name': instance.name,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'mediaPath': instance.mediaPath,
      'user': instance.user.toJson(),
      'challenge': instance.challenge.toJson(),
    };

_$ResultImpl _$$ResultImplFromJson(Map<String, dynamic> json) => _$ResultImpl(
      resultId: json['resultId'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      mediaPath: json['mediaPath'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      challenge: Challenge.fromJson(json['challenge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResultImplToJson(_$ResultImpl instance) =>
    <String, dynamic>{
      'resultId': instance.resultId,
      'name': instance.name,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'mediaPath': instance.mediaPath,
      'user': instance.user,
      'challenge': instance.challenge,
    };
