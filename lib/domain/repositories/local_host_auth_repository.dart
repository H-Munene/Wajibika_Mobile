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

  Future<Either<Failure, void>> submitReport({
    required String imagePath,
    required String category,
    required String description,
  });

  Future<Either<Failure, ReportVolunteerHistoryModel>>
  getReportandVolunteerHistory();

  Future<Either<Failure, ReportListSpecificDateModel>>
  getReportHistorySpecificDate({required String date});

  Future<Either<Failure, VolunteerListSpecificDateModel>>
  getVolunteerHistorySpecificDate({required String date});

  Future<Either<Failure, void>> changeUsername({required String new_username});

  Future<Either<Failure, void>> changeEmailUsername({
    required String new_username,
    required String new_email,
    required String current_password,
  });

  Future<Either<Failure, void>> changeEmail({
    required String new_email,
    required String current_password,
  });

  Future<int> requestPasswordReset({required String current_email});

  Future<Either<Failure, void>> changePassword({
    required String current_email,
    required String terminal_token,
    required String new_password,
  });
}
