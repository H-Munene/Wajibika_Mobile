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

  @override
  Future<Either<Failure, ReportVolunteerHistoryModel>>
  getReportandVolunteerHistory() async {
    try {
      final response =
          await _localHostAuthDatasource.getReportandVolunteerHistory();

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, ReportListSpecificDateModel>>
  getReportHistorySpecificDate({required String date}) async {
    try {
      final response = await _localHostAuthDatasource
          .getReportHistorySpecificDate(date: date);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, VolunteerListSpecificDateModel>>
  getVolunteerHistorySpecificDate({required String date}) async {
    try {
      final response = await _localHostAuthDatasource
          .getVolunteerHistorySpecificDate(date: date);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changeUsername({
    required String new_username,
  }) async {
    try {
      final response = await _localHostAuthDatasource.changeUsername(
        new_username: new_username,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changeEmailUsername({
    required String new_username,
    required String new_email,
    required String current_password,
  }) async {
    try {
      final response = await _localHostAuthDatasource.changeEmailUsername(
        new_username: new_username,
        new_email: new_email,
        current_password: current_password,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String current_email,
    required String terminal_token,
    required String new_password,
  }) async {
    try {
      final response = await _localHostAuthDatasource.changePassword(
        current_email: current_email,
        terminal_token: terminal_token,
        new_password: new_password,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<int> requestPasswordReset({required String current_email}) async {
    final response = await _localHostAuthDatasource.requestPasswordReset(
      current_email: current_email,
    );

    return response;
  }

  @override
  Future<Either<Failure, void>> changeEmail({
    required String new_email,
    required String current_password,
  }) async {
    try {
      final response = await _localHostAuthDatasource.changeEmail(
        new_email: new_email,
        current_password: current_password,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
