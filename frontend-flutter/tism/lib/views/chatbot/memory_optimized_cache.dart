class MemoryOptimizedCache {
  static const int _maxCacheSize = 20; // Limite para economizar RAM
  
  final Map<String, String> _responseCache = {};
  final List<String> _cacheKeys = [];
  
  // Singleton para economizar memória
  static final MemoryOptimizedCache _instance = MemoryOptimizedCache._internal();
  factory MemoryOptimizedCache() => _instance;
  MemoryOptimizedCache._internal();
  
  String? getCachedResponse(String message) {
    final key = _normalizeMessage(message);
    return _responseCache[key];
  }
  
  void cacheResponse(String message, String response) {
    final key = _normalizeMessage(message);
    
    // Remove cache antigo se exceder limite
    if (_cacheKeys.length >= _maxCacheSize) {
      final oldestKey = _cacheKeys.removeAt(0);
      _responseCache.remove(oldestKey);
    }
    
    _responseCache[key] = response;
    _cacheKeys.add(key);
  }
  
  String _normalizeMessage(String message) {
    return message
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove pontuação
        .replaceAll(RegExp(r'\s+'), ' '); // Normaliza espaços
  }
  
  void clearCache() {
    _responseCache.clear();
    _cacheKeys.clear();
  }
  
  int get cacheSize => _responseCache.length;
}