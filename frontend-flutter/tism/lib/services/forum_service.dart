import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForumService {
  static String get _baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  static Future<bool> createPost(String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;
      
      final response = await http.post(
        Uri.parse('$_baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'content': content,
        }),
      );
      
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      final uri = userId != null 
        ? Uri.parse('$_baseUrl/posts?user_id=$userId')
        : Uri.parse('$_baseUrl/posts');
      
      final response = await http.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['posts'] ?? []);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> likePost(int postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;
      
      final response = await http.post(
        Uri.parse('$_baseUrl/posts/$postId/like'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> savePost(int postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;
      
      final response = await http.post(
        Uri.parse('$_baseUrl/posts/$postId/save_post'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getComments(String postId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts/$postId/comments'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['comments']);
      } else {
        throw Exception('Erro ao carregar comentários');
      }
    } catch (e) {
      throw Exception('Erro ao carregar comentários: $e');
    }
  }

  static Future<void> createComment(String postId, String userId, String content) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/posts/$postId/comments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'user_id': userId,
          'content': content,
        }),
      );
      
      if (response.statusCode != 201) {
        throw Exception('Erro ao criar comentário');
      }
    } catch (e) {
      throw Exception('Erro ao criar comentário: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> searchPosts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/posts/search?q=${Uri.encodeComponent(query)}'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['posts'] ?? []);
      } else {
        throw Exception('Erro na busca');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  static Future<void> deletePost(String postId, String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/posts/$postId?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode != 200) {
        throw Exception('Erro ao deletar post');
      }
    } catch (e) {
      throw Exception('Erro ao deletar post: $e');
    }
  }

  static Future<void> deleteComment(String postId, String commentId, String userId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/comments/$commentId?user_id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode != 200) {
        final errorBody = response.body.isNotEmpty ? json.decode(response.body) : {};
        final errorMessage = errorBody['error'] ?? 'Erro desconhecido';
        throw Exception('Status ${response.statusCode}: $errorMessage');
      }
    } catch (e) {
      throw Exception('Erro ao deletar comentário: $e');
    }
  }
}