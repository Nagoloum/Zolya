import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class LocalStorageService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure;

  LocalStorageService(this._prefs, this._secure);

  Future<void> saveAccessToken(String token) => _secure.write(key: AppConstants.accessTokenKey, value: token);
  Future<String?> getAccessToken() => _secure.read(key: AppConstants.accessTokenKey);
  Future<void> deleteAccessToken() => _secure.delete(key: AppConstants.accessTokenKey);

  Future<void> saveRefreshToken(String token) => _secure.write(key: AppConstants.refreshTokenKey, value: token);
  Future<String?> getRefreshToken() => _secure.read(key: AppConstants.refreshTokenKey);

  Future<void> clearTokens() async {
    await _secure.delete(key: AppConstants.accessTokenKey);
    await _secure.delete(key: AppConstants.refreshTokenKey);
  }

  Future<void> saveUser(Map<String, dynamic> userJson) async {
    await _prefs.setString(AppConstants.userKey, jsonEncode(userJson));
  }

  Map<String, dynamic>? getUser() {
    final raw = _prefs.getString(AppConstants.userKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clearUser() => _prefs.remove(AppConstants.userKey);

  Future<void> clearAll() async {
    await _prefs.clear();
    await _secure.deleteAll();
  }
}
