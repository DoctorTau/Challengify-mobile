import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result {
  final int resultId;
  final String name;
  final String description;
  final DateTime timestamp;
  final String mediaPath;
  final int userId;
  final int challengeId;

  Result({
    required this.resultId,
    required this.name,
    required this.description,
    required this.timestamp,
    required this.mediaPath,
    required this.userId,
    required this.challengeId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
