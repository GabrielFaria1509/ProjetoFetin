import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'secure_storage_service.dart';

class UserService {
  
  // URL do backend dinâmica
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  // Registrar novo usuário
  static Future<Map<String, dynamic>> register({
    required String name,
    required String username,
    required String email,
    required String password,
    String userType = 'Responsável',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'username': username.toLowerCase(),
          'email': email,
          'password': password,
          'user_type': userType,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 201) {
        // Salvar dados do usuário localmente
        await _saveUserLocally(data['user']);
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão: $e'};
    }
  }
  
  // Login do usuário
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        // Salvar dados do usuário localmente
        await _saveUserLocally(data['user']);
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'error': data['error']};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão: $e'};
    }
  }
  
  // Salvar usuário localmente
  static Future<void> _saveUserLocally(Map<String, dynamic> user) async {
    await SecureStorageService.setSecureInt('user_id', user['id']);
    await SecureStorageService.setSecureString('user_name', user['name'] ?? '');
    await SecureStorageService.setSecureString('username', user['username'] ?? '');
    await SecureStorageService.setSecureString('user_email', user['email'] ?? '');
    await SecureStorageService.setSecureString('user_type', user['user_type'] ?? 'Responsável');
    await SecureStorageService.setSecureString('account_type', user['account_type'] ?? 'normal');
    if (user['profile_picture'] != null) {
      await SecureStorageService.setSecureString('profile_image', user['profile_picture']);
    }
  }
  
  // Manter método antigo para compatibilidade
  static Future<void> saveUser({
    required String username,
    String userType = 'Responsável',
    String? profileImagePath,
  }) async {
    await SecureStorageService.setSecureString('username', username);
    await SecureStorageService.setSecureString('user_type', userType);
    if (profileImagePath != null) {
      await SecureStorageService.setSecureString('profile_image', profileImagePath);
    }
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final userId = await SecureStorageService.getSecureInt('user_id');
    if (userId == null) return null;

    return {
      'id': userId,
      'name': await SecureStorageService.getSecureString('user_name'),
      'username': await SecureStorageService.getSecureString('username'),
      'email': await SecureStorageService.getSecureString('user_email'),
      'userType': await SecureStorageService.getSecureString('user_type'),
      'accountType': await SecureStorageService.getSecureString('account_type'),
      'isLoggedIn': true,
    };
  }

  static Future<bool> updateUserType(String userType) async {
    try {
      final userId = await SecureStorageService.getSecureInt('user_id');
      
      if (userId == null) return false;
      
      final response = await http.put(
        Uri.parse('$_baseUrl/profile/$userId/user_type'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_type': userType}),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveUserLocally(data['user']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateProfileImage(String avatarUrl) async {
    try {
      final userId = await SecureStorageService.getSecureInt('user_id');
      
      if (userId == null) return false;
      
      await SecureStorageService.setSecureString('profile_image', avatarUrl);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> updateName(String name) async {
    try {
      final userId = await SecureStorageService.getSecureInt('user_id');
      
      if (userId == null) return {'success': false, 'error': 'Usuário não encontrado'};
      
      final response = await http.put(
        Uri.parse('$_baseUrl/profile/$userId/name'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name}),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        await _saveUserLocally(data['user']);
        return {'success': true};
      } else {
        return {'success': false, 'error': data['error'] ?? 'Erro ao atualizar nome'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão'};
    }
  }

  static Future<Map<String, dynamic>> updateUsername(String username) async {
    try {
      final userId = await SecureStorageService.getSecureInt('user_id');
      
      if (userId == null) return {'success': false, 'error': 'Usuário não encontrado'};
      
      final response = await http.put(
        Uri.parse('$_baseUrl/profile/$userId/username'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username}),
      );
      
      final data = json.decode(response.body);
      
      if (response.statusCode == 200) {
        await _saveUserLocally(data['user']);
        return {'success': true};
      } else {
        return {'success': false, 'error': data['error'] ?? 'Erro ao atualizar username'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Erro de conexão'};
    }
  }

  static Future<bool> deleteAccount({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        await logout();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> logout() async {
    await SecureStorageService.clearAll();
  }

  static Future<bool> isLoggedIn() async {
    final userId = await SecureStorageService.getSecureInt('user_id');
    return userId != null;
  }
}
