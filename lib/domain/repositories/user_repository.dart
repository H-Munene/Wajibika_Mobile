import 'package:bloc_clean_arch/core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, void>> saveUserID({required String id});
  Either<Failure, String> getUserID();
  Future<Either<Failure, void>> saveUserName({required String username});
  Either<Failure, String> getUserName();
  Future<Either<Failure, void>> saveUserEmail({required String email});
  Either<Failure, String> getUserEmail();
  Future<void> deleteSavedUserDetails();
}
