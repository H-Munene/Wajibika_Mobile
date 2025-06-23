import 'package:bloc_clean_arch/data/data.dart';

abstract interface class LocalHostAuthDataSource {
  Future<int> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<UserModel?> getUserSession();

  Future<HomeFeedModel> getHomeFeed();

  Future<void> submitReport({
    required String imagePath,
    required String category,
    required String description,
  });

  Future<ReportVolunteerHistoryModel> getReportandVolunteerHistory();

  Future<ReportVolunteerListSpecificDateModel> getReportHistorySpecificDate({
    required String date,
  });
  Future<ReportVolunteerListSpecificDateModel> getVolunteerHistorySpecificDate({
    required String date,
  });
}
