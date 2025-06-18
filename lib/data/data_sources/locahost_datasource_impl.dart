import 'dart:convert';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:http/http.dart' as http;

class LocahostDatasourceImpl implements AuthDataSource {
  LocahostDatasourceImpl({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<Map<String, String>> _getHeaders({
    required bool needsAuthorization,
  }) async {
    return {
      if (needsAuthorization)
        'Authorization': _userRepository.getToken().fold(
          (_) => '',
          (token) => token,
        ),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers':
          'Origin, Content-Type, X-Auth-Token, Authorization',
    };
  }

  @override
  Future<UserModel?> getUserSession() {
    // TODO: implement getUserSession
    throw UnimplementedError();
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.userLoginEndpoint);

    try {
      final userLoginResponse = await http
          .post(
            url,
            headers: await _getHeaders(needsAuthorization: false),
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));
      if (userLoginResponse.statusCode == 200) {
        final Map<String, dynamic> userRegisterResponseBody =
            jsonDecode(userLoginResponse.body) as Map<String, dynamic>;

        return UserModel.fromJson(
          userRegisterResponseBody['user'] as Map<String, dynamic>,
        );
      }
      throw ServerException(message: 'Login failed. Try again!');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Some error occurred. Please try again!');
    }
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
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.userRegisterEndpoint);

    try {
      final userRegisterResponse = await http
          .post(
            url,
            headers: await _getHeaders(needsAuthorization: false),
            body: jsonEncode({
              'username': username,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (userRegisterResponse.statusCode == 201) {
        final Map<String, dynamic> userRegisterResponseBody =
            jsonDecode(userRegisterResponse.body) as Map<String, dynamic>;

        return userRegisterResponseBody['userId'] as int;
      }
      throw ServerException(message: 'Registration failed. Try again!');
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(message: 'Some error occurred. Please try again!');
    }
  }
}
