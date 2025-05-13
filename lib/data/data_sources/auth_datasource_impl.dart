import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final signInResponse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final userJson = signInResponse.user!.toJson();

      final userModel = UserModel.fromJson(userJson);

      return userModel;
    } on AuthApiException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // TODO(H-Munene): https://github.com/H-Munene/bloc_CleanArch/issues/5
      throw ServerException(message: 'Login failed. Please try again!!');
    }
  }

  @override
  Future<UserModel> signUpWithUsernameEmailPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final signUpResponse = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );

      final userModel = UserModel.fromJson(signUpResponse.user!.toJson());

      return userModel;
    } on AuthApiException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(
        // TODO(H-Munene): https://github.com/H-Munene/bloc_CleanArch/issues/5
        message: 'Sign in failed. Please try again!!',
      );
    }
  }
}
