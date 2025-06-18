abstract interface class LocalDbDataSource {
  Future<void> saveUserID({required String id});
  String? getUserID();
  Future<void> saveUserName({required String username});
  String? getUserName();
  Future<void> saveUserEmail({required String email});
  String? getUserEmail();
  Future<void> deleteSavedUserDetails();
  Future<void> setDoNotShowOnboardingScreen();
  bool doNotShowOnboardingScreen();

  //UPDATE 
}
