class MemoryOptimizedCache {
  static const int _maxCacheSize = 10; // Mais agressivo para velocidade
  static const int _maxResponseLength = 500; // Respostas mais curtas
  
  final Map<String, String> _responseCache = {};
  final Map<String, int> _accessCount = {}; // Conta acessos para LRU
  
  static final MemoryOptimizedCache _instance = MemoryOptimizedCache._internal();
  factory MemoryOptimizedCache() => _instance;
  MemoryOptimizedCache._internal();
  
  String? getCachedResponse(String message) {
    final key = _normalizeMessage(message);
    final response = _responseCache[key];
    
    if (response != null) {
      _accessCount[key] = (_accessCount[key] ?? 0) + 1;
    }
    
    return response;
  }
  
  void cacheResponse(String message, String response) {
    // Não cacheia respostas muito longas
    if (response.length > _maxResponseLength) return;
    
    final key = _normalizeMessage(message);
    
    // Remove cache menos usado se exceder limite
    if (_responseCache.length >= _maxCacheSize) {
      _removeLeastUsed();
    }
    
    _responseCache[key] = response;
    _accessCount[key] = 1;
  }
  
  void _removeLeastUsed() {
    if (_accessCount.isEmpty) return;
    
    final leastUsedKey = _accessCount.entries
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;
    
    _responseCache.remove(leastUsedKey);
    _accessCount.remove(leastUsedKey);
  }
  
  String _normalizeMessage(String message) {
    final normalized = message.toLowerCase().trim();
    return normalized.length > 50 ? normalized.substring(0, 50) : normalized;
  }
  
  void clearCache() {
    _responseCache.clear();
    _accessCount.clear();
  }
  
  int get cacheSize => _responseCache.length;
  
  // Otimização automática de memória
  void optimizeMemory() {
    if (_responseCache.length > _maxCacheSize ~/ 2) {
      final keysToRemove = _accessCount.entries
          .where((e) => e.value == 1)
          .map((e) => e.key)
          .take(5)
          .toList();
      
      for (final key in keysToRemove) {
        _responseCache.remove(key);
        _accessCount.remove(key);
      }
    }
  }
}