import 'package:bloc_clean_arch/data/data.dart';

class LocahostDatasourceImpl implements AuthDataSource {
  @override
  Future<UserModel?> getUserSession() {
    // TODO: implement getUserSession
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<int> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  }) {
    // TODO: implement signUpWithUsernameEmailPassword
    throw UnimplementedError();
  }
}
