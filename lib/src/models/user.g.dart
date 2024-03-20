// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      passwordSalt: json['passwordSalt'] as String,
      status: json['status'] as int? ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'passwordSalt': instance.passwordSalt,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
