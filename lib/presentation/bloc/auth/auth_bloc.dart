import 'package:bloc_clean_arch/data/data.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;
  final UserLoginUseCase _userLoginUseCase;
  final SignOutUseCase _signOutUseCase;
  final AlreadySignedIn _alreadySignedIn;
  final UserRepository _userRepository;

  AuthBloc({
    required AlreadySignedIn alreadySignedIn,
    required SignOutUseCase signOutUseCase,
    required UserSignUpUseCase userSignUpUseCase,
    required UserLoginUseCase userLoginUseCase,
    required UserRepository userRepository,
  }) : _userSignUpUseCase = userSignUpUseCase,
       _userLoginUseCase = userLoginUseCase,
       _signOutUseCase = signOutUseCase,
       _alreadySignedIn = alreadySignedIn,
       _userRepository = userRepository,
       super(AuthLoggedOut()) {
    on<AuthSignUp>(_onUserSignUp);
    on<AuthLogin>(_onUserLogin);
    on<AuthSignOut>(_onUserSignOut);
    on<AuthCheckUserAlreadySignedIn>(_onUserAlreadySignedIn);
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
      (userID) => emit(AuthSuccess()),
    );
  }

  Future<void> _onUserLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final userLoginEvent = await _userLoginUseCase.call(
      UserLoginParams(email: event.email, password: event.password),
    );

    userLoginEvent.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) {
        _userRepository
          ..saveToken(token: user.token)
          ..saveUserEmail(email: user.email)
          ..saveUserID(id: user.user_id.toString())
          ..saveUserName(username: user.username)
          ..setDoNotShowOnboardingScreen();
        emit(AuthLoggedIn(userModel: user));
      },
    );
  }

  Future<void> _onUserSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final response = await _signOutUseCase.call(NoParams());

    await response.fold(
      (_) {
        // clearing the saved details.
        // cannot fail?
        // emit(AuthFailure(message: failure.message));
      },
      (_) async {
        emit(AuthLoggedOut());

        await _userRepository.deleteSavedUserDetails();
      },
    );
  }

  Future<void> _onUserAlreadySignedIn(
    AuthCheckUserAlreadySignedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _alreadySignedIn.call(NoParams());
    response.fold(
      (failure) {
        return emit(AuthLoggedOut());
      },
      (user) {
        _userRepository
          ..saveUserEmail(email: user.email)
          ..saveUserID(id: user.user_id.toString())
          ..saveUserName(username: user.username)
          ..setDoNotShowOnboardingScreen();
        return emit(AuthLoggedIn(userModel: user));
      },
    );
  }
}
