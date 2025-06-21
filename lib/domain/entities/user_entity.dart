import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.user_id,
    required this.username,
    required this.email,
    required this.token,
  });

  final int user_id;
  final String username;
  final String email;
  final String token;

  @override
  List<Object?> get props => [user_id, username, email, token];
}
