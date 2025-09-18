import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_auth_service.dart';
import 'secure_storage_service.dart';

class AuthIntegrationService {
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  // Login completo com Firebase + Backend
  static Future<Map<String, dynamic>> loginWithEmail(String email, String password) async {
    try {
      // 1. Autenticar no Firebase
      final user = await FirebaseAuthService.signInWithEmail(email, password);
      if (user == null) throw Exception('Falha na autenticação Firebase');

      // 2. Sincronizar com backend
      return await _syncWithBackend(user, password);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Cadastro completo com Firebase + Backend
  static Future<Map<String, dynamic>> registerWithEmail({
    required String name,
    required String username,
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      // 1. Criar conta no Firebase
      final user = await FirebaseAuthService.signUpWithEmail(email, password);
      if (user == null) throw Exception('Falha ao criar conta Firebase');

      // 2. Criar no backend
      final response = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'user_type': userType,
          'firebase_uid': user.uid,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        throw Exception('Erro no backend: ${response.body}');
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Login social (Google/Apple)
  static Future<Map<String, dynamic>> loginSocial(String provider) async {
    try {
      User? user;
      
      if (provider == 'google') {
        user = await FirebaseAuthService.signInWithGoogle();
      } else if (provider == 'apple') {
        user = await FirebaseAuthService.signInWithApple();
      }

      if (user == null) throw Exception('Login cancelado');

      // Criar novo usuário social
      return await _createSocialUser(user);
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Verificar se usuário existe no backend
  static Future<Map<String, dynamic>?> _checkUserExists(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': 'social_check_${DateTime.now().millisecondsSinceEpoch}',
        }),
      );

      // Se retornar 401, usuário não existe ou senha incorreta
      // Se retornar 200, usuário existe
      return null; // Sempre criar novo usuário social
    } catch (e) {
      return null;
    }
  }

  // Criar usuário social no backend
  static Future<Map<String, dynamic>> _createSocialUser(User firebaseUser) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': firebaseUser.displayName ?? 'Usuário',
          'username': firebaseUser.email!.split('@')[0],
          'email': firebaseUser.email!,
          'password': 'social_auth_${firebaseUser.uid}',
          'user_type': 'responsavel',
          'firebase_uid': firebaseUser.uid,
          'account_type': 'normal',
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        throw Exception('Erro ao criar usuário: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao criar usuário social: $e');
    }
  }

  // Sincronizar Firebase com backend
  static Future<Map<String, dynamic>> _syncWithBackend(User firebaseUser, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': firebaseUser.email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        await _saveUserData(data['user']);
        return {'success': true, 'user': data['user']};
      } else {
        throw Exception('Erro no backend: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro de sincronização: $e');
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

  // Logout completo
  static Future<void> logout() async {
    await FirebaseAuthService.signOut();
    await SecureStorageService.clearAll();
  }

  // Verificar se está logado
  static Future<bool> isLoggedIn() async {
    final firebaseUser = FirebaseAuthService.currentUser;
    final userId = await SecureStorageService.getSecureInt('user_id');
    
    return firebaseUser != null && userId != null;
  }
}