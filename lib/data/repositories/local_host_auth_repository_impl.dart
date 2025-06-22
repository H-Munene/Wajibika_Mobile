import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';

import 'package:fpdart/fpdart.dart';

class LocalHostAuthRepositoryImpl implements LocalHostAuthRepository {
  final LocalHostAuthDataSource _localHostAuthDatasource;

  LocalHostAuthRepositoryImpl({required LocalHostAuthDataSource authDatasource})
    : _localHostAuthDatasource = authDatasource;

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _localHostAuthDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      );

      return right(userModel);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _localHostAuthDatasource
          .signUpWithUsernameEmailPassword(
            username: username,
            email: email,
            password: password,
          );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return right(await _localHostAuthDatasource.signOut());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserSession() async {
    try {
      final user = await _localHostAuthDatasource.getUserSession();

      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, HomeFeedModel>> getHomeFeed() async {
    try {
      final homeFeed = await _localHostAuthDatasource.getHomeFeed();

      return right(homeFeed);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitReport({
    required String imagePath,
    required String category,
    required String description,
  }) async {
    try {
      final reportSubmitionResponse = await _localHostAuthDatasource
          .submitReport(
            imagePath: imagePath,
            category: category,
            description: description,
          );

      return right(reportSubmitionResponse);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
