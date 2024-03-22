// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      resultId: json['resultId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      mediaPath: json['mediaPath'] as String,
      userId: json['userId'] as int,
      challengeId: json['challengeId'] as int,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'resultId': instance.resultId,
      'name': instance.name,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'mediaPath': instance.mediaPath,
      'userId': instance.userId,
      'challengeId': instance.challengeId,
    };
