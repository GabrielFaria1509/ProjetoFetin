import 'memory_optimized_cache.dart';
import '../../services/gemini_service.dart';
import '../../config/chatbot_config.dart';

class ChatbotService {
  static final MemoryOptimizedCache _cache = MemoryOptimizedCache();
  
  static Future<String> sendMessage(String message) async {
    // Cache primeiro - prioridade máxima
    final cachedResponse = _cache.getCachedResponse(message);
    if (cachedResponse != null) {
      return cachedResponse;
    }
    
    // Sempre usa IA agora
    final response = await GeminiService.generateCustomResponse(message);
    
    _cache.cacheResponse(message, response);
    return response;
  }
  
  static List<String> getSuggestions(String message) {
    return [
      'Como identificar sinais de autismo?',
      'Que terapias são recomendadas?',
      'Como lidar com crises?',
      'Dicas para inclusão escolar',
    ];
  }
  
  static void clearCache() {
    _cache.clearCache();
  }
  
  static int getCacheSize() {
    return _cache.cacheSize;
  }
}