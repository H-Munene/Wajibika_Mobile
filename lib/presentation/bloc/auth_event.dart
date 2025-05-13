part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  AuthSignUp({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;
}

final class AuthLogin extends AuthEvent {
  AuthLogin({required this.email, required this.password});

  final String email;
  final String password;
}

final class AuthSignOut extends AuthEvent {}