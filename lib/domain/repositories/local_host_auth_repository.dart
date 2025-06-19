import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class LocalHostAuthRepository {
  Future<Either<Failure, int>> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserModel>> getUserSession();

  Future<Either<Failure, HomeFeedModel>> getHomeFeed();
}
