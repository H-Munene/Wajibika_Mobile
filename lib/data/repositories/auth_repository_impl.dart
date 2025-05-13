import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';

import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDatasource;

  AuthRepositoryImpl({required AuthDataSource authDatasource})
    : _authDatasource = authDatasource;

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      );

      return right(response);
    } catch (e) {
      final exception = e as ServerException;
      return left(Failure(exception.message));
    }
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
      final exception = e as ServerException;
      return left(Failure(exception.message));
    }
  }
}
