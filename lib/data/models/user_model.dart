import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel extends UserEntity{
  UserModel({
    required super.user_id,
    required super.username,
    required super.email,
    required super.wajibika_points,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // UserModel copyWith({String? id, String? username, String? email}) {
  //   return UserModel(
  //     id: id ?? this.id,
  //     username: username ?? this.username,
  //     email: email ?? this.email,
  //   );
  // }

  // @override
  // String toString() {
  //   return 'UserModel {id = $id, email = $email, usernmae = $username}';
  // }
}
