abstract interface class AuthDatasource {
  Future<String> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
