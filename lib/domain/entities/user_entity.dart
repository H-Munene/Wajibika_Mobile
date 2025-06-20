import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.user_id,
    required this.username,
    required this.email,
    required this.wajibika_points,
    required this.token,
  });

  final int user_id;
  final String username;
  final String email;
  final int wajibika_points;
  final String token;

  @override
  List<Object?> get props => [user_id, username, email, wajibika_points, token];
}
