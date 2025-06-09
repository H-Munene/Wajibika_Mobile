part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  AuthFailure({required this.message});

  final String message;
}

final class AuthLoggedOut extends AuthState {}

final class AuthLoggedIn extends AuthState {}
