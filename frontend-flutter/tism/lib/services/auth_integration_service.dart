import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'secure_storage_service.dart';

class AuthIntegrationService {
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  // Login apenas com Backend Rails
  static Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        return {'success': false, 'error': 'Email ou senha inválidos'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão: $e'};
    }
  }

  // Cadastro com backend
  static Future<Map<String, dynamic>> registerWithEmail({
    required String name,
    required String username,
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'user_type': userType,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        final errorData = json.decode(response.body);
        return {'success': false, 'error': errorData['error'] ?? 'Erro no cadastro'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão: $e'};
    }
  }

  // Salvar dados do usuário localmente
  static Future<void> _saveUserData(Map<String, dynamic> user) async {
    await SecureStorageService.setSecureInt('user_id', user['id']);
    await SecureStorageService.setSecureString('user_name', user['name'] ?? '');
    await SecureStorageService.setSecureString('username', user['username'] ?? '');
    await SecureStorageService.setSecureString('user_email', user['email'] ?? '');
    await SecureStorageService.setSecureString('user_type', user['user_type'] ?? '');
    await SecureStorageService.setSecureString('account_type', user['account_type'] ?? 'normal');
  }

  // Logout
  static Future<void> logout() async {
    await SecureStorageService.clearAll();
  }

  // Verificar se está logado
  static Future<bool> isLoggedIn() async {
    final userId = await SecureStorageService.getSecureInt('user_id');
    return userId != null;
  }
}