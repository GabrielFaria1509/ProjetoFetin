import 'autism_knowledge_base.dart';
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
    
    String response;
    
    if (ChatbotConfig.useAi) {
      // Modo IA: usa apenas Gemini AI
      try {
        response = await GeminiService.generateCustomResponse(message);
      } catch (e) {
        response = await GeminiService.generateFallbackResponse(message);
      }
    } else {
      // Modo Local: usa apenas base de conhecimento
      response = _getLocalResponse(message);
    }
    
    _cache.cacheResponse(message, response);
    return response;
  }
  
  static String _getLocalResponse(String message) {
    return AutismKnowledgeBase.findResponse(message);
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