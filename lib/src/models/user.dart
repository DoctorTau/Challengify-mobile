import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int userId;
  final String name;
  final String email;
  final DateTime createdAt;
  @JsonKey(name: 'challengeIds', fromJson: _listIntJson)
  final List<int> challengeIds;
  @JsonKey(name: 'resultIds', fromJson: _listIntJson)
  final List<int> resultIds;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.challengeIds,
    required this.resultIds,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

List<int> _listIntJson(Map<String, dynamic> jsonStr) {
  List<dynamic> values = jsonStr['\$values'];
  return values.map((value) => value as int).toList();
}

