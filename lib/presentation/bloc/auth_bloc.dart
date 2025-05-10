import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_clean_arch/domain/usecases/signup_usecase_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUseCase _userSignUpUseCase;

  AuthBloc({required UserSignUpUseCase userSignUpUseCase})
    : _userSignUpUseCase = userSignUpUseCase,
      super(AuthInitial()) {
    on<AuthSignUp>(_onUserSignUp);
  }

  Future<void> _onUserSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final userSignUpEvent = await _userSignUpUseCase.call(
      UserSignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    userSignUpEvent.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (userID) => emit(AuthSuccess(userID: userID)),
    );
  }
}
