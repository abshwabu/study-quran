import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure Storage service for storing user API keys safely using Keystore (Android) / Keychain (iOS).
class SecureStorageService {
  final FlutterSecureStorage _storage;
  static const String _geminiApiKey = 'gemini_api_key';

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  /// Save user Gemini API key safely
  Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: _geminiApiKey, value: apiKey);
  }

  /// Get stored Gemini API key
  Future<String?> getApiKey() async {
    return await _storage.read(key: _geminiApiKey);
  }

  /// Delete stored API key
  Future<void> deleteApiKey() async {
    await _storage.delete(key: _geminiApiKey);
  }
}
