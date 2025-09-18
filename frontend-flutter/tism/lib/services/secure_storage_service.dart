import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SecureStorageService {
  static const String _keyPrefix = 'tism_secure_';
  
  // Chave dinâmica para criptografia
  static String get _encryptionKey => dotenv.env['ENCRYPTION_KEY'] ?? 'dev_key_not_secure';
  
  static String _encrypt(String data) {
    final bytes = utf8.encode(data + _encryptionKey);
    final digest = sha256.convert(bytes);
    return '${base64.encode(utf8.encode(data))}.${digest.toString().substring(0, 16)}';
  }
  
  static String? _decrypt(String encryptedData) {
    try {
      final parts = encryptedData.split('.');
      if (parts.length != 2) return null;
      
      final data = utf8.decode(base64.decode(parts[0]));
      final expectedHash = sha256.convert(utf8.encode(data + _encryptionKey)).toString().substring(0, 16);
      
      if (parts[1] == expectedHash) {
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  
  static Future<void> setSecureString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = _encrypt(value);
    await prefs.setString(_keyPrefix + key, encrypted);
  }
  
  static Future<String?> getSecureString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = prefs.getString(_keyPrefix + key);
    if (encrypted == null) return null;
    return _decrypt(encrypted);
  }
  
  static Future<void> setSecureInt(String key, int value) async {
    await setSecureString(key, value.toString());
  }
  
  static Future<int?> getSecureInt(String key) async {
    final value = await getSecureString(key);
    return value != null ? int.tryParse(value) : null;
  }
  
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_keyPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}