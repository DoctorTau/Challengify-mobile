// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'passwordSalt': instance.passwordSalt,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$UserStatusEnumMap[instance.status]!,
      'challenges': instance.challenges.map((e) => e.toJson()).toList(),
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

const _$UserStatusEnumMap = {
  UserStatus.Regular: 'Regular',
  UserStatus.Premium: 'Premium',
};

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: json['userId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      passwordSalt: json['passwordSalt'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      challenges: (json['challenges'] as List<dynamic>)
          .map((e) => Challenge.fromJson(e as Map<String, dynamic>))
          .toList(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'passwordSalt': instance.passwordSalt,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$UserStatusEnumMap[instance.status]!,
      'challenges': instance.challenges,
      'results': instance.results,
    };
