import 'package:flutter/material.dart';
import 'package:bloc_clean_arch/core/core.dart';
import 'package:bloc_clean_arch/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDbDatasourceImpl implements LocalDbDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDbDatasourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<void> deleteSavedUserDetails() async {
    await _sharedPreferences.remove(_LocalDbKeys.idKey);
    await _sharedPreferences.remove(_LocalDbKeys.usernameKey);
    await _sharedPreferences.remove(_LocalDbKeys.emailKey);
    await _sharedPreferences.remove(_LocalDbKeys.tokenKey);
    debugPrint('🗑️ Cleared User repo');
  }

  @override
  String? getUserEmail() {
    try {
      return _sharedPreferences.getString(_LocalDbKeys.emailKey);
    } catch (_) {
      throw ServerException(message: 'User email not found');
    }
  }

  @override
  String? getUserID() {
    try {
      return _sharedPreferences.getString(_LocalDbKeys.idKey);
    } catch (_) {
      throw ServerException(message: 'UserID not found');
    }
  }

  @override
  String? getUserName() {
    try {
      return _sharedPreferences.getString(_LocalDbKeys.usernameKey);
    } catch (_) {
      throw ServerException(message: 'Username not found');
    }
  }

  @override
  Future<void> saveUserEmail({required String email}) async {
    debugPrint('🔐Email Saved');
    await _sharedPreferences.setString(_LocalDbKeys.emailKey, email);
  }

  @override
  Future<void> saveUserID({required String id}) async {
    debugPrint('🔐ID Saved');
    await _sharedPreferences.setString(_LocalDbKeys.idKey, id);
  }

  @override
  Future<void> saveUserName({required String username}) async {
    debugPrint('🔐Username Saved');
    await _sharedPreferences.setString(_LocalDbKeys.usernameKey, username);
  }

  @override
  Future<void> setDoNotShowOnboardingScreen() async {
    await _sharedPreferences.setBool(_LocalDbKeys.onBoardingScreenKey, true);
  }

  @override
  bool doNotShowOnboardingScreen() {
    final doNotShowOnboardingScreen = _sharedPreferences.getBool(
      _LocalDbKeys.onBoardingScreenKey,
    );

    if (doNotShowOnboardingScreen == null) {
      return false;
    }

    return doNotShowOnboardingScreen;
  }

  @override
  String? getToken() {
    try {
      return _sharedPreferences.getString(_LocalDbKeys.tokenKey);
    } catch (_) {
      throw ServerException(message: 'Token not found');
    }
  }

  @override
  Future<void> saveToken({required String token}) async {
    debugPrint('🔐Token Saved');
    await _sharedPreferences.setString(_LocalDbKeys.tokenKey, token);
  }
}

class _LocalDbKeys {
  static String idKey = 'id';
  static String usernameKey = 'username';
  static String emailKey = 'email';
  static String onBoardingScreenKey = 'doNotShowOnboardingScreen';
  static String tokenKey = 'token';
}
