import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data_sources/local_db_datasource.dart';
import 'package:bloc_clean_arch/domain/repositories/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDbDataSource _localDbDataSource;

  UserRepositoryImpl({required LocalDbDataSource localDbDataSource})
    : _localDbDataSource = localDbDataSource;

  @override
  Future<void> deleteSavedUserDetails() async {
    await _localDbDataSource.deleteSavedUserDetails();
  }

  @override
  Either<Failure, String> getUserEmail() {
    try {
      final email = _localDbDataSource.getUserEmail();

      return right(email!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Either<Failure, String> getUserID() {
    try {
      final id = _localDbDataSource.getUserID();

      return right(id!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Either<Failure, String> getUserName() {
    try {
      final username = _localDbDataSource.getUserName();

      return right(username!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserEmail({required String email}) async {
    try {
      return right(await _localDbDataSource.saveUserEmail(email: email));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserID({required String id}) async {
    try {
      return right(await _localDbDataSource.saveUserID(id: id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserName({required String username}) async {
    try {
      return right(await _localDbDataSource.saveUserName(username: username));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
