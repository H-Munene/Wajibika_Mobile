// ignore_for_file: prefer_single_quotes

import 'dart:convert';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/core/secrets/localhost_endpoints.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:bloc_clean_arch/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocahostAuthDatasourceImpl implements LocalHostAuthDataSource {
  LocahostAuthDatasourceImpl({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<Map<String, String>> _getHeaders({
    required bool needsAuthorization,
  }) async {
    return {
      if (needsAuthorization)
        'Authorization': _userRepository.getToken().fold(
          (_) => '',
          (token) => 'Bearer $token',
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

      // success
      if (userLoginResponse.statusCode == 200) {
        final Map<String, dynamic> userRegisterResponseBody =
            jsonDecode(userLoginResponse.body) as Map<String, dynamic>;

        return UserModel.fromJson(
          userRegisterResponseBody['user'] as Map<String, dynamic>,
        );
      }

      //failed
      //get error message
      final Map<String, dynamic> errorMessage =
          jsonDecode(userLoginResponse.body) as Map<String, dynamic>;

      throw ServerException(message: errorMessage['message'] as String);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: 'Some error occurred. Please try again!');
    }
  }

  @override
  Future<void> signOut() async {
    await _userRepository.deleteSavedUserDetails();
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

  @override
  Future<HomeFeedModel> getHomeFeed() async {
    final Uri url = Uri.parse(LocalhostEndpoints.homeFeedEndpoint);

    try {
      final homeFeedResponse = await http
          .get(url, headers: await _getHeaders(needsAuthorization: true))
          .timeout(const Duration(seconds: 10));
      debugPrint('*****Status code :  ${homeFeedResponse.statusCode}*****');
      if (homeFeedResponse.statusCode == 200) {
        final Map<String, dynamic> homeFeed =
            jsonDecode(homeFeedResponse.body) as Map<String, dynamic>;
        return HomeFeedModel.fromJson(
          homeFeed['home_feed'] as Map<String, dynamic>,
        );
      }

      throw ServerException(
        message: 'Failed to retrieve home feed. Refresh the page!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Some error occurred. Please refresh the page!}',
      );
    }
  }

  @override
  Future<void> submitReport({
    required String imagePath,
    required String category,
    required String description,
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.submitReportEndpoint);

    final reportSubmissionRequest = http.MultipartRequest('POST', url);
    reportSubmissionRequest.headers['Authorization'] = _userRepository
        .getToken()
        .fold((_) => '', (token) => 'Bearer $token');
    reportSubmissionRequest.fields['category'] = category;
    reportSubmissionRequest.fields['description'] = description;
    reportSubmissionRequest.files.add(
      await http.MultipartFile.fromPath('report_image', imagePath),
    );

    try {
      final makeRequest = await reportSubmissionRequest.send();

      final reportSubmissionResponse = await http.Response.fromStream(
        makeRequest,
      );

      if (reportSubmissionResponse.statusCode == 201) {}
    } catch (e) {
      throw ServerException(message: 'Failed to submit report');
    }
  }

  @override
  Future<ReportVolunteerHistoryModel> getReportandVolunteerHistory() async {
    final Uri url = Uri.parse(
      LocalhostEndpoints.userReportVolunteerHistoryEndpoint,
    );

    try {
      final response = await http.get(
        url,
        headers: await _getHeaders(needsAuthorization: true),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        return ReportVolunteerHistoryModel.fromJson(responseBody);
      }

      throw ServerException(
        message: 'Failed to retrieve history. Refresh the page!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to retrieve history. Refresh page',
      );
    }
  }

  @override
  Future<ReportListSpecificDateModel> getReportHistorySpecificDate({
    required String date,
  }) async {
    final Uri url = Uri.parse(
      LocalhostEndpoints.userReportHistoryOnDateEndpoint(date: date),
    );

    try {
      final request = await http.get(
        url,
        headers: await _getHeaders(needsAuthorization: true),
      );

      if (request.statusCode == 200) {
        final Map<String, dynamic> reportHistoryOnDate =
            jsonDecode(request.body) as Map<String, dynamic>;

        return ReportListSpecificDateModel.fromJson(reportHistoryOnDate);
      }
      throw ServerException(
        message: 'Failed to get report history for this day!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        // message: 'Failed to get report history for this day!!',
        message: e.toString(),
      );
    }
  }

  @override
  Future<VolunteerListSpecificDateModel> getVolunteerHistorySpecificDate({
    required String date,
  }) async {
    final Uri uri = Uri.parse(
      LocalhostEndpoints.userVolunteerHistoryOnDateEndpoint(date: date),
    );

    try {
      final response = await http.get(
        uri,
        headers: await _getHeaders(needsAuthorization: true),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> volunteerHistoryOnDate =
            jsonDecode(response.body) as Map<String, dynamic>;

        return VolunteerListSpecificDateModel.fromJson(volunteerHistoryOnDate);
      }

      throw ServerException(message: 'Failed to get volunteer history');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to get volunteer history for this day',
      );
    }
  }

  @override
  Future<void> changeUsername({required String new_username}) async {
    final Uri url = Uri.parse(LocalhostEndpoints.updateProfileEndpoint);

    try {
      final request = await http.put(
        url,
        headers: await _getHeaders(needsAuthorization: true),
        body: jsonEncode({'new_username': new_username}),
      );

      if (request.statusCode == 200) {
        return;
      }

      throw ServerException(
        message: 'Username change failed. Please try again',
      );
    } catch (e) {
      if (e is ServerException) rethrow;

      throw ServerException(
        message: 'Username change failed. Please try again!',
      );
    }
  }

  @override
  Future<void> changeEmail({
    required String new_email,
    required String current_password,
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.updateProfileEndpoint);

    try {
      final request = await http.put(
        url,
        headers: await _getHeaders(needsAuthorization: true),
        body: jsonEncode({
          'new_email': new_email,
          'current_password': current_password,
        }),
      );

      if (request.statusCode == 200) {
        return;
      }
      throw ServerException(
        message: 'Failed to update email. Please try again!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to update email. Please try again!',
      );
    }
  }

  @override
  Future<void> changeEmailUsername({
    required String new_username,
    required String new_email,
    required String current_password,
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.updateProfileEndpoint);

    try {
      final request = await http.put(
        url,
        headers: await _getHeaders(needsAuthorization: true),
        body: jsonEncode({
          'new_username': new_username,
          'new_email': new_email,
          'current_password': current_password,
        }),
      );

      if (request.statusCode == 200) {
        return;
      }
      throw ServerException(
        message: 'Failed to update your email and username. Please try again!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to update your email and username. Please try again!',
      );
    }
  }

  @override
  Future<int> requestPasswordReset({required String current_email}) async {
    final Uri url = Uri.parse(LocalhostEndpoints.requestPasswordResetEndpoint);

    final request = await http.post(
      url,
      headers: await _getHeaders(needsAuthorization: false),
      body: jsonEncode({"email": current_email}),
    );

    if (request.statusCode == 200) {
      return 200;
    } else {
      return 404;
    }
  }

  @override
  Future<void> changePassword({
    required String current_email,
    required String terminal_token,
    required String new_password,
  }) async {
    final Uri url = Uri.parse(LocalhostEndpoints.updateProfileEndpoint);

    try {
      final request = await http.put(
        url,
        headers: await _getHeaders(needsAuthorization: false),
        body: jsonEncode({
          'email': current_email,
          'token': terminal_token,
          'new_password': new_password,
        }),
      );

      if (request.statusCode == 200) {
        return;
      }
      throw ServerException(
        message: 'Failed to update password. Please try again!',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        message: 'Failed to update your password. Please try again!',
      );
    }
  }
}
