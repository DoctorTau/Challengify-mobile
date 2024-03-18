import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/models/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserStatus { Regular, Premium }

@freezed
@JsonSerializable(explicitToJson: true)
class User with _$User {
  factory User({
    required int userId,
    required String name,
    required String email,
    required String passwordHash,
    required String passwordSalt,
    required DateTime createdAt,
    required UserStatus status,
    required List<Challenge> challenges,
    required List<Result> results,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
