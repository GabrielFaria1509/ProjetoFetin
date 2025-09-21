import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'secure_storage_service.dart';

class AuthIntegrationService {
  static const String _baseUrl = 'https://tism-backend-api-rgxd.onrender.com';

  // Login apenas com Backend Rails
  static Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        try {
          final errorData = json.decode(response.body);
          return {'success': false, 'error': errorData['error'] ?? 'Email ou senha inválidos'};
        } catch (e) {
          return {'success': false, 'error': 'Erro no servidor: ${response.statusCode}'};
        }
      }
    } on TimeoutException {
      return {'success': false, 'error': 'Timeout: Servidor demorou para responder'};
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão'};
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
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'user_type': userType,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return {'success': true, 'user': data['user'], 'message': data['message']};
      } else if (response.statusCode == 202) {
        // Conta criada mas precisa verificar email
        final data = json.decode(response.body);
        return {
          'success': true, 
          'needsVerification': true,
          'message': data['message'] ?? 'Verifique seu email para ativar a conta',
          'userData': {
            'name': name,
            'username': username,
            'email': email,
            'password': password,
            'user_type': userType,
          }
        };
      } else {
        try {
          final errorData = json.decode(response.body);
          return {'success': false, 'error': errorData['error'] ?? 'Erro no cadastro'};
        } catch (e) {
          return {'success': false, 'error': 'Erro no servidor: ${response.statusCode}'};
        }
      }
    } on TimeoutException {
      return {'success': false, 'error': 'Timeout: Servidor demorou para responder'};
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão'};
    }
  }

  // Salvar dados do usuário localmente
  static Future<void> _saveUserData(Map<String, dynamic> user) async {
    await SecureStorageService.clearAll(); // Limpar dados antigos
    await SecureStorageService.setSecureInt('user_id', user['id']);
    await SecureStorageService.setSecureString('user_name', user['name']);
    await SecureStorageService.setSecureString('username', user['username']);
    await SecureStorageService.setSecureString('user_email', user['email']);
    await SecureStorageService.setSecureString('user_type', user['user_type']);
    await SecureStorageService.setSecureString('account_type', user['account_type']);
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