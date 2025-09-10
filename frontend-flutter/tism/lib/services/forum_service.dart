import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ForumService {
  static const String _baseUrl = 'https://tism-backend-api-rgxd.onrender.com';

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
}