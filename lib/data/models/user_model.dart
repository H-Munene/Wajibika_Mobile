import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity {
  const UserModel({
    required super.user_id,
    required super.username,
    required super.email,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
