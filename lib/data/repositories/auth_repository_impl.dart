import 'package:bloc_clean_arch/core/error/failure.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';

import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithUsernameEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDatasource.signUpWithUsernameEmailPassword(
        username: username,
        email: email,
        password: password,
      );

      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
