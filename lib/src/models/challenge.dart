import 'package:json_annotation/json_annotation.dart';

part 'challenge.g.dart';

@JsonSerializable()
class Challenge {
  final int challengeId;
  final String name;
  final String description;
  final DateTime startDate;
  final int periodicity;
  final String joinCode;
  @JsonKey(name: 'resultIds', fromJson: _listIntJson)
  final List<int> resultIds;
  @JsonKey(name: 'participantIds', fromJson: _listIntJson)
  final List<int> participantIds;

  Challenge({
    required this.challengeId,
    required this.name,
    required this.description,
    required this.startDate,
    required this.periodicity,
    required this.joinCode,
    required this.resultIds,
    required this.participantIds,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeToJson(this);
}

List<int> _listIntJson(Map<String, dynamic> jsonStr) {
  List<dynamic> values = jsonStr['\$values'];
  return values.map((value) => value as int).toList();
}
