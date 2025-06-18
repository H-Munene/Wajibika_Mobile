// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  user_id: (json['user_id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  wajibika_points: (json['wajibika_points'] as num).toInt(),
  token: json['token'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.user_id,
  'username': instance.username,
  'email': instance.email,
  'wajibika_points': instance.wajibika_points,
  'token': instance.token,
};
