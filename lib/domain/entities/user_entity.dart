class UserEntity {
  UserEntity({
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
}
