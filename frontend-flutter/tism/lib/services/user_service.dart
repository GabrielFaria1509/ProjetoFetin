import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserService {
  static const String _keyUsername = 'username';
  static const String _keyUserType = 'user_type';
  static const String _keyProfileImage = 'profile_image';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyEmail = 'email';
  
  // URL do backend dinâmica
  static String get _baseUrl => const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000');

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, user['id']);
    await prefs.setString('name', user['name'] ?? '');
    await prefs.setString(_keyUsername, user['username'] ?? '');
    await prefs.setString(_keyEmail, user['email'] ?? '');
    await prefs.setString(_keyUserType, user['user_type'] ?? 'Responsável');
    await prefs.setString('account_type', user['account_type'] ?? 'normal');
    await prefs.setBool(_keyIsLoggedIn, true);
    if (user['profile_picture'] != null) {
      await prefs.setString(_keyProfileImage, user['profile_picture']);
    }
  }
  
  // Manter método antigo para compatibilidade
  static Future<void> saveUser({
    required String username,
    String userType = 'Responsável',
    String? profileImagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyUserType, userType);
    await prefs.setBool(_keyIsLoggedIn, true);
    if (profileImagePath != null) {
      await prefs.setString(_keyProfileImage, profileImagePath);
    }
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;

    if (!isLoggedIn) return null;

    return {
      'id': prefs.getInt(_keyUserId),
      'name': prefs.getString('name') ?? '',
      'username': prefs.getString(_keyUsername) ?? '',
      'email': prefs.getString(_keyEmail) ?? '',
      'userType': prefs.getString(_keyUserType) ?? 'Responsável',
      'accountType': prefs.getString('account_type') ?? 'normal',
      'profileImagePath': prefs.getString(_keyProfileImage),
      'isLoggedIn': isLoggedIn,
    };
  }

  static Future<bool> updateUserType(String userType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);
      
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
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);
      
      if (userId == null) return false;
      
      await prefs.setString(_keyProfileImage, avatarUrl);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> updateName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);
      
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
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(_keyUserId);
      
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }
}
