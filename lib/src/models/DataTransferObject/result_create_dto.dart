import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'result_create_dto.freezed.dart';
part 'result_create_dto.g.dart';

@freezed
class ResultCreateRequestDto with _$ResultCreateRequestDto {
  factory ResultCreateRequestDto({
    required String name,
    required String description,
    @Default('') String mediaPath,
  }) = _ResultCreateRequestDto;

  factory ResultCreateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ResultCreateRequestDtoFromJson(json);
}
