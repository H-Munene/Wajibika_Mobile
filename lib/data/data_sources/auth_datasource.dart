
import 'package:bloc_clean_arch/data/data.dart';

abstract interface class AuthDatasource {
  Future<UserModel> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
