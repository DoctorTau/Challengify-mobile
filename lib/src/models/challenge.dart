import 'package:challengify_app/src/models/result.dart';
import 'package:challengify_app/src/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

enum ChallengeStatus { Active, Inactive }

@freezed
@JsonSerializable(explicitToJson: true)
class Challenge with _$Challenge {
  factory Challenge({
    required int challengeId,
    required String name,
    String? description,
    required DateTime startDate,
    required int periodicity,
    required List<Result> results,
    required List<User> participants,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);
}

