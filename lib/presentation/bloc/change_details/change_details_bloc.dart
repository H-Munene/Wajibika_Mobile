import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'change_details_event.dart';
part 'change_details_state.dart';

class ChangeDetailsBloc extends Bloc<ChangeDetailsEvent, ChangeDetailsState> {
  final ChangeUsernameUsecaseImpl _changeUsernameUsecaseImpl;
  final ChangeEmailUsernameUsecaseImpl _changeEmailUsernameUsecaseImpl;
  final RequestPasswordResetUsecaseImpl _requestPasswordResetUsecaseImpl;
  final ChangePasswordUsecaseImpl _changePasswordUsecaseImpl;
  final ChangeEmailUsecaseImpl _changeEmailUsecaseImpl;

  ChangeDetailsBloc({
    required ChangeUsernameUsecaseImpl changeUsernameUsecaseImpl,
    required ChangeEmailUsernameUsecaseImpl changeEmailUsernameUsecaseImpl,
    required RequestPasswordResetUsecaseImpl requestPasswordResetUsecaseImpl,
    required ChangePasswordUsecaseImpl changePasswordUsecaseImpl,
    required ChangeEmailUsecaseImpl changeEmailUsecaseImpl,
  }) : _changeUsernameUsecaseImpl = changeUsernameUsecaseImpl,
       _changeEmailUsernameUsecaseImpl = changeEmailUsernameUsecaseImpl,
       _requestPasswordResetUsecaseImpl = requestPasswordResetUsecaseImpl,
       _changePasswordUsecaseImpl = changePasswordUsecaseImpl,
       _changeEmailUsecaseImpl = changeEmailUsecaseImpl,
       super(const ChangeDetailsState(isLoading: false)) {
    on<ChangeUsernameEvent>(_onChangeUsername);
    on<ChangeEmailEvent>(_onChangeEmail);
    on<ChangeEmailUsernameEvent>(_onChangeEmailUsername);
    on<ChangePasswordEvent>(_onChangePassword);
    on<ChangeRequestPasswordResetEvent>(_requestPasswordReset);
  }

  Future<void> _onChangeUsername(
    ChangeUsernameEvent event,
    Emitter<ChangeDetailsState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true, updatedIsSuccessful: null));

    final response = await _changeUsernameUsecaseImpl.call(
      ChangeUsernameParams(newUsername: event.username),
    );

    response.fold(
      (error) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: false),
        );
      },
      (_) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: true),
        );
      },
    );
  }

  Future<void> _onChangeEmail(
    ChangeEmailEvent event,
    Emitter<ChangeDetailsState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true, updatedIsSuccessful: null));

    final response = await _changeEmailUsecaseImpl.call(
      ChangeEmailParams(
        current_password: event.current_password,
        newEmail: event.email,
      ),
    );

    response.fold(
      (error) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: false),
        );
      },
      (_) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: true),
        );
      },
    );
  }

  Future<void> _onChangeEmailUsername(
    ChangeEmailUsernameEvent event,
    Emitter<ChangeDetailsState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true, updatedIsSuccessful: null));
    final response = await _changeEmailUsernameUsecaseImpl.call(
      ChangeEmailUsernameParams(
        new_username: event.username,
        new_email: event.email,
        current_password: event.currentPassword,
      ),
    );

    response.fold(
      (error) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: false),
        );
      },
      (_) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: true),
        );
      },
    );
  }

  Future<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ChangeDetailsState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true, updatedIsSuccessful: null));

    final response = await _changePasswordUsecaseImpl.call(
      ChangePasswordParams(
        current_email: event.email,
        terminal_token: event.token,
        new_password: event.newPassword,
      ),
    );

    response.fold(
      (error) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: false),
        );
      },
      (_) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: true),
        );
      },
    );
  }

  Future<void> _requestPasswordReset(
    ChangeRequestPasswordResetEvent event,
    Emitter<ChangeDetailsState> emit,
  ) async {
    emit(state.copyWith(updatedIsLoading: true, updatedIsSuccessful: null));

    final response = await _requestPasswordResetUsecaseImpl.call(
      RequestPasswordResetParams(current_email: event.current_email),
    );

    response.fold(
      (error) {
        state.copyWith(updatedIsLoading: false, updatedIsSuccessful: false);
      },
      (_) {
        emit(
          state.copyWith(updatedIsLoading: false, updatedIsSuccessful: true),
        );
      },
    );
  }
}
