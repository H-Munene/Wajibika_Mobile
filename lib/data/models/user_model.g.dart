// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  user_id: (json['user_id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  token: json['token'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.user_id,
  'username': instance.username,
  'email': instance.email,
  'token': instance.token,
};
