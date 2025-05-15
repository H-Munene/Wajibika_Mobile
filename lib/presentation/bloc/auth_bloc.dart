import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/usecases/already_signed_in.dart';
import 'package:bloc_clean_arch/domain/usecases/signout_usecase_impl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserLoginUseCase _userLoginUseCase;
  final SignOutUseCase _signOutUseCase;
  final AlreadySignedIn _alreadySignedIn;

  AuthBloc({
    required AlreadySignedIn alreadySignedIn,
    required SignOutUseCase signOutUseCase,
    required UserSignUpUseCase userSignUpUseCase,
    required UserLoginUseCase userLoginUseCase,
  }) : _userSignUpUseCase = userSignUpUseCase,
       _userLoginUseCase = userLoginUseCase,
       _signOutUseCase = signOutUseCase,
       _alreadySignedIn = alreadySignedIn,
       super(AuthInitial()) {
    on<AuthSignUp>(_onUserSignUp);
    on<AuthLogin>(_onUserLogin);
    on<AuthSignOut>(_onUserSignOut);
    on<AuthUserAlreadySignedIn>(_onUserAlreadySignedIn);
  }

  Future<void> _onUserSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final userSignUpEvent = await _userSignUpUseCase.call(
      UserSignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    userSignUpEvent.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onUserLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final userLoginEvent = await _userLoginUseCase.call(
      UserLoginParams(email: event.email, password: event.password),
    );

    userLoginEvent.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onUserSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _signOutUseCase.call(NoParams());

    response.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (_) => emit(AuthInitial()),
    );
  }

  Future<void> _onUserAlreadySignedIn(
    AuthUserAlreadySignedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _alreadySignedIn.call(NoParams());

    response.fold(
      (failure) => emit(AuthInitial()),
      (user) => AuthSuccess(user: user),
    );
  }
}
