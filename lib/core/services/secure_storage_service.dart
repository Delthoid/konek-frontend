import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const String _tokenKey = 'jwt_token';
  static const String _refreshTokenKey = 'refresh_token';

  static const String userKey = 'user_data';

  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  // For actions in general
  Future<void> deleteKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> saveKeyValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getKeyValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}