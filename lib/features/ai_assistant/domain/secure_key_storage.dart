import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureKeyStorage {
  static const _storage = FlutterSecureStorage();
  static const _apiKeyKey = 'gemini_api_key';

  static Future<void> saveApiKey(String key) async {
    await _storage.write(key: _apiKeyKey, value: key.trim());
  }

  static Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKeyKey);
  }

  static Future<void> clearApiKey() async {
    await _storage.delete(key: _apiKeyKey);
  }
}
