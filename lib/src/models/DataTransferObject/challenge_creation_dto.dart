import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'challenge_creation_dto.freezed.dart';
part 'challenge_creation_dto.g.dart';

@freezed
class ChallengeCreationDto with _$ChallengeCreationDto {
  factory ChallengeCreationDto({
    required String title,
    String? description,
    int? periodicity,
  }) = _ChallengeCreationDto;

  factory ChallengeCreationDto.fromJson(Map<String, dynamic> json) => _$ChallengeCreationDtoFromJson(json);
}