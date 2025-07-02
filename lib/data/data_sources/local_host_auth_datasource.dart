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

  Future<ReportListSpecificDateModel> getReportHistorySpecificDate({
    required String date,
  });
  Future<VolunteerListSpecificDateModel> getVolunteerHistorySpecificDate({
    required String date,
  });

  Future<void> changeUsername({required String new_username});
  Future<void> changeEmail({
    required String new_email,
    required String current_password,
  });

  Future<void> changeEmailUsername({
    required String new_username,
    required String new_email,
    required String current_password,
  });

  Future<int> requestPasswordReset({required String current_email});

  Future<void> changePassword({
    required String current_email,
    required String terminal_token,
    required String new_password,
  });
}
