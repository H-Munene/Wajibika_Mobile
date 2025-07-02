part of 'change_details_bloc.dart';

sealed class ChangeDetailsEvent extends Equatable {
  const ChangeDetailsEvent();

  @override
  List<Object> get props => [];
}

final class ChangeUsernameEvent extends ChangeDetailsEvent {
  const ChangeUsernameEvent({required this.username});

  final String username;
}

final class ChangeEmailEvent extends ChangeDetailsEvent {
  const ChangeEmailEvent({required this.current_password, required this.email});

  final String email;
  final String current_password;
}

final class ChangeEmailUsernameEvent extends ChangeDetailsEvent {
  const ChangeEmailUsernameEvent({
    required this.currentPassword,
    required this.email,
    required this.username,
  });

  final String email;
  final String username;
  final String currentPassword;
}

final class ChangePasswordEvent extends ChangeDetailsEvent {
  const ChangePasswordEvent({
    required this.email,
    required this.newPassword,
    required this.token,
  });

  final String email;
  final String newPassword;
  final String token;
}

final class ChangeRequestPasswordResetEvent extends ChangeDetailsEvent {
  const ChangeRequestPasswordResetEvent({required this.current_email});

  final String current_email;
}
