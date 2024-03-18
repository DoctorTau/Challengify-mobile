import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class Result with _$Result {
  factory Result({
    required int resultId,
    required String name,
    String? description,
    required DateTime timestamp,
    String? mediaPath,
    required User user,
    required Challenge challenge,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
