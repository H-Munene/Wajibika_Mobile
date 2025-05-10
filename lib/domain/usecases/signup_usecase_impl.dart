import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/domain/repository/auth_repository.dart';
import 'package:bloc_clean_arch/domain/usecases/usecase.dart';
import 'package:fpdart/src/either.dart';

class UserSignUpParams {
  UserSignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;
}

class UserSignUpUseCase implements Usecase<String, UserSignUpParams> {
  UserSignUpUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(
    UserSignUpParams userSignUpParams,
  ) async {
    return await authRepository.signUpWithUsernameEmailPassword(
      username: userSignUpParams.username,
      email: userSignUpParams.email,
      password: userSignUpParams.password,
    );
  }
}
