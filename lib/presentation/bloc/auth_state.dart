part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess({required this.userID});

  final UserModel userID;
}

final class AuthFailure extends AuthState {
  AuthFailure({required this.message});

  final String message;
}
