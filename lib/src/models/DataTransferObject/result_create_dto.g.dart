// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$ResultCreateRequestDtoToJson(
        ResultCreateRequestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'mediaPath': instance.mediaPath,
    };

_$ResultCreateRequestDtoImpl _$$ResultCreateRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ResultCreateRequestDtoImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      mediaPath: json['mediaPath'] as String?,
    );

Map<String, dynamic> _$$ResultCreateRequestDtoImplToJson(
        _$ResultCreateRequestDtoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'mediaPath': instance.mediaPath,
    };
