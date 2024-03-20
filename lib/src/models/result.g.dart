// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      resultId: json['resultId'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      mediaPath: json['mediaPath'] as String? ?? '',
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'resultId': instance.resultId,
      'name': instance.name,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'mediaPath': instance.mediaPath,
    };
