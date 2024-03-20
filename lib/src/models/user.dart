import 'package:json_annotation/json_annotation.dart';
import 'challenge.dart';
import 'result.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'userId')
  final int userId;
  final String name;
  final String email;
  final String passwordHash;
  final String passwordSalt;
  @JsonKey(defaultValue: 0)
  final int status;
  final DateTime createdAt;

  @JsonKey(ignore: true)
  final List<Challenge>? challenges;
  
  @JsonKey(ignore: true)
  final List<Result>? results;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.passwordSalt,
    this.status = 0,
    DateTime? createdAt,
    this.challenges,
    this.results,
  }) : createdAt = createdAt ?? DateTime.now().toUtc();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
