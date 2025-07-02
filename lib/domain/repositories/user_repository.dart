import 'package:bloc_clean_arch/core/core.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, void>> saveUserID({required String id});
  Either<Failure, String> getUserID();
  Future<Either<Failure, void>> saveUserName({required String username});
  Either<Failure, String> getUserName();
  Future<Either<Failure, void>> updateUsername({required String newUsername});
  Future<Either<Failure, void>> saveUserEmail({required String email});
  Either<Failure, String> getUserEmail();
  Future<Either<Failure, void>> updateEmail({required String newEmail});
  Future<void> deleteSavedUserDetails();
  Future<Either<Failure, void>> setDoNotShowOnboardingScreen();
  bool doNotshowOnboardingScreen();
  Future<Either<Failure, void>> saveToken({required String token});
  Either<Failure, String> getToken();
}
