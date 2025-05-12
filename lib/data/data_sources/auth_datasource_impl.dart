import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDatasourceImpl implements AuthDatasource {
  AuthDatasourceImpl({required this.supabaseClient});

  final SupabaseClient supabaseClient;
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithUsernameEmailPassword({
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

      return signUpResponse.user!.id;
    } on AuthException catch (e) {
      throw ServerException(statusCode: e.statusCode, message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
