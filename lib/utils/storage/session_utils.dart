import 'package:lokal/utils/storage/preference_util.dart';
import 'package:lokal/utils/storage/user_data_handler.dart';

class Session {
  final int? userId;
  final DateTime? openedTime;
  final DateTime? lastLogin;
  final String? deviceId;
  final String? sessionId;

  Session({
    this.userId,
    this.lastLogin,
    this.deviceId,
    this.sessionId,
    this.openedTime,
  });
}

class SessionManager {
  static const String _userIdKey = 'user_id';
  static const String _lastLoginKey = 'last_login';
  static const String _deviceIdKey = 'device_id';
  static const String _sessionIdKey = 'session_id';
  static const String _openTimeKey = 'open_time';

  static Future<void> saveSession([Session? session]) async {
    session ??= Session();
    await _saveUserId(session.userId);
    await _saveLastLogin(session.lastLogin);
    await _saveDeviceId(session.deviceId);
    await _saveSessionId(session.sessionId);
    await _saveOpenedTime(session.openedTime);
  }

  static Future<void> _saveUserId(int? userId) async {
    await PreferenceUtils.setInt(
        _userIdKey, userId ?? UserDataHandler.getUserId());
  }

  static Future<void> _saveLastLogin(DateTime? lastLogin) async {
    if (lastLogin != null) {
      await PreferenceUtils.setString(
          _lastLoginKey, lastLogin.toIso8601String());
    }
  }

  static Future<void> _saveDeviceId(String? deviceId) async {
    await PreferenceUtils.setString(
        _deviceIdKey, deviceId ?? UserDataHandler.getDeviceId());
  }

  static Future<void> _saveSessionId(String? sessionId) async {
    await PreferenceUtils.setString(
        _sessionIdKey,
        '${UserDataHandler.getDeviceId()}${DateTime.now().millisecondsSinceEpoch}');
  }

  static Future<void> _saveOpenedTime(DateTime? openedTime) async {
    if (openedTime != null) {
      await PreferenceUtils.setString(
          _openTimeKey, openedTime.toIso8601String());
    }
  }

  static Future<Session?> getSession() async {
    final userId = PreferenceUtils.getInt(_userIdKey, -1);
    final lastLoginString = PreferenceUtils.getString(_lastLoginKey);
    final deviceId = PreferenceUtils.getString(_deviceIdKey);
    final sessionId = PreferenceUtils.getString(_sessionIdKey);
    final openTime = PreferenceUtils.getString(_openTimeKey);

    if (userId != -1 && lastLoginString.isNotEmpty) {
      return Session(
        userId: userId,
        lastLogin:
            DateTime.tryParse(lastLoginString),
        deviceId: deviceId,
        sessionId: sessionId,
        openedTime: DateTime.tryParse(openTime),
      );
    }

    return null;
  }

  static Future<void> clearSession() async {
    await PreferenceUtils.clearStorage();
  }
}







