import 'package:json_annotation/json_annotation.dart';
import 'result.dart';
import 'user.dart';

part 'challenge.g.dart';

@JsonSerializable(explicitToJson: true)
class Challenge {
  @JsonKey(name: 'challengeId')
  final int challengeId;
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  final DateTime startDate;
  @JsonKey(defaultValue: 24)
  final int periodicity;

  @JsonKey(ignore: true)
  final List<Result>? results;
  
  @JsonKey(ignore: true)
  final List<User>? participants;

  Challenge({
    required this.challengeId,
    required this.name,
    this.description = '',
    DateTime? startDate,
    this.periodicity = 24,
    this.results,
    this.participants,
  }) : startDate = startDate ?? DateTime.now().toUtc();

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);
  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}
