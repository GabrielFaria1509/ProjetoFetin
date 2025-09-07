import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ForumService {
  static const String _baseUrl = 'https://tism-backend-api-rgxd.onrender.com';

  static Future<List<ForumPost>> getPosts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/forum_posts'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final posts = data.map((json) => ForumPost.fromJson(json)).toList();
        
        // Se não há posts, retorna posts de exemplo
        if (posts.isEmpty) {
          return _getMockPosts();
        }
        return posts;
      }
      return _getMockPosts();
    } catch (e) {
      return _getMockPosts();
    }
  }
  
  static List<ForumPost> _getMockPosts() {
    return [
      ForumPost(
        id: 1,
        content: 'Olá pessoal! Sou nova aqui e gostaria de compartilhar minha experiência. Meu filho foi diagnosticado com TEA aos 3 anos e desde então temos aprendido muito juntos. Alguém tem dicas sobre rotinas que funcionam bem?',
        username: 'Maria Silva',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likesCount: 5,
        commentsCount: 3,
        isLiked: false,
      ),
      ForumPost(
        id: 2,
        content: 'Queria agradecer a todos por todo o apoio que encontrei aqui. Como professor, aprendi muito sobre inclusão escolar através das experiências compartilhadas por vocês. Continuem compartilhando!',
        username: 'Prof. João',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likesCount: 12,
        commentsCount: 7,
        isLiked: true,
      ),
      ForumPost(
        id: 3,
        content: 'Alguém conhece boas atividades sensoriais para crianças com TEA? Minha filha tem 4 anos e estou sempre procurando novas ideias para ajudá-la no desenvolvimento.',
        username: 'Ana Costa',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likesCount: 8,
        commentsCount: 15,
        isLiked: false,
      ),
    ];
  }

  static Future<bool> createPost(String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;

      final response = await http.post(
        Uri.parse('$_baseUrl/forum_posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': content,
          'user_id': userId,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> toggleLike(int postId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;

      final response = await http.post(
        Uri.parse('$_baseUrl/forum_posts/$postId/toggle_like'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'user_id': userId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<List<ForumComment>> getComments(int postId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/forum_posts/$postId/comments'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ForumComment.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addComment(int postId, String content) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      
      if (userId == null) return false;

      final response = await http.post(
        Uri.parse('$_baseUrl/forum_posts/$postId/comments'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'content': content,
          'user_id': userId,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}

class ForumPost {
  final int id;
  final String content;
  final String username;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;

  ForumPost({
    required this.id,
    required this.content,
    required this.username,
    required this.createdAt,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    return ForumPost(
      id: json['id'],
      content: json['content'],
      username: json['username'] ?? 'Usuário',
      createdAt: DateTime.parse(json['created_at']),
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isLiked: json['is_liked'] ?? false,
    );
  }
}

class ForumComment {
  final int id;
  final String content;
  final String username;
  final DateTime createdAt;

  ForumComment({
    required this.id,
    required this.content,
    required this.username,
    required this.createdAt,
  });

  factory ForumComment.fromJson(Map<String, dynamic> json) {
    return ForumComment(
      id: json['id'],
      content: json['content'],
      username: json['username'] ?? 'Usuário',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}