import 'dart:convert';
import 'package:http/http.dart' as http;
import 'autism_knowledge_base.dart';
import 'memory_optimized_cache.dart';

class ChatbotService {
  static const String baseUrl = 'http://localhost:3000/api';
  static final MemoryOptimizedCache _cache = MemoryOptimizedCache();
  
  static Future<String> sendMessage(String message) async {
    // Verifica cache primeiro para economizar recursos
    final cachedResponse = _cache.getCachedResponse(message);
    if (cachedResponse != null) {
      return cachedResponse;
    }
    
    String response;
    
    try {
      final httpResponse = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      ).timeout(const Duration(seconds: 5)); // Timeout reduzido
      
      if (httpResponse.statusCode == 200) {
        final data = jsonDecode(httpResponse.body);
        response = data['message'] ?? _getLocalResponse(message);
      } else {
        response = _getLocalResponse(message);
      }
    } catch (e) {
      // Usa base de conhecimento local
      response = _getLocalResponse(message);
    }
    
    // Cache a resposta para uso futuro
    _cache.cacheResponse(message, response);
    return response;
  }

  static String _getLocalResponse(String message) {
    // Busca na base de conhecimento estruturada
    final response = AutismKnowledgeBase.findResponse(message);
    return response ?? AutismKnowledgeBase.getDefaultResponse();
  }
  
  static List<String> getSuggestions(String message) {
    return AutismKnowledgeBase.getFollowUpSuggestions(message);
  }
  
  static void clearCache() {
    _cache.clearCache();
  }
  
  static int getCacheSize() {
    return _cache.cacheSize;
  }
}