import 'autism_knowledge_base.dart';
import 'memory_optimized_cache.dart';

class ChatbotService {
  static final MemoryOptimizedCache _cache = MemoryOptimizedCache();
  
  static Future<String> sendMessage(String message) async {
    // Cache primeiro - prioridade máxima
    final cachedResponse = _cache.getCachedResponse(message);
    if (cachedResponse != null) {
      return cachedResponse;
    }
    
    // Usa apenas base local - sem HTTP para velocidade
    final response = _getLocalResponse(message);
    
    // Cache imediato
    _cache.cacheResponse(message, response);
    
    return response;
  }
  


  static String _getLocalResponse(String message) {
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