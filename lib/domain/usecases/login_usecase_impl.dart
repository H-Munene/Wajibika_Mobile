import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginParams {
  UserLoginParams({required this.email, required this.password});

  final String email;
  final String password;
}

class UserLoginUseCase implements Usecase<UserModel, UserLoginParams> {
  UserLoginUseCase({required this.localHostAuthRepository});

  final LocalHostAuthRepository localHostAuthRepository;
  @override
  Future<Either<Failure, UserModel>> call(
    UserLoginParams userLoginParams,
  ) async {
    return await localHostAuthRepository.loginWithEmailPassword(
      email: userLoginParams.email,
      password: userLoginParams.password,
    );
  }
}
