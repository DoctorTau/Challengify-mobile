import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'challenge.dart';

part 'result.g.dart';

@JsonSerializable(explicitToJson: true)
class Result {
  @JsonKey(name: 'resultId')
  final int resultId;
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  final DateTime timestamp;
  @JsonKey(defaultValue: '')
  final String mediaPath;

  @JsonKey(ignore: true)
  final User? user;
  
  @JsonKey(ignore: true)
  final Challenge? challenge;

  Result({
    required this.resultId,
    required this.name,
    this.description = '',
    DateTime? timestamp,
    this.mediaPath = '',
    this.user,
    this.challenge,
  }) : timestamp = timestamp ?? DateTime.now().toUtc();

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
