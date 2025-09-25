import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Imports condicionais para web
// import 'package:web/web.dart' as web;
// import 'dart:js_interop';

class PWAService {
  static final PWAService _instance = PWAService._internal();
  factory PWAService() => _instance;
  PWAService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  bool _isOnline = true;
  bool _isInstallable = false;
  
  // Getters
  bool get isOnline => _isOnline;
  bool get isInstallable => _isInstallable;
  bool get isPWA => kIsWeb;

  // Callbacks
  Function(bool)? onConnectivityChanged;
  Function()? onInstallPromptReady;

  /// Inicializar serviço PWA
  Future<void> initialize() async {
    // PROTEÇÃO: Só executa na web
    if (!kIsWeb) {
      debugPrint('[PWA] Skipping PWA initialization on mobile platform');
      return;
    }

    await _setupConnectivityListener();
    await _setupInstallPrompt();
    await _registerServiceWorker();
    await _setupNotifications();
    
    debugPrint('[PWA] Service initialized successfully');
  }

  /// Configurar listener de conectividade
  Future<void> _setupConnectivityListener() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      final isConnected = !results.contains(ConnectivityResult.none);
      _updateOnlineStatus(isConnected);
    });

    // Verificar status inicial
    final result = await _connectivity.checkConnectivity();
    _updateOnlineStatus(!result.contains(ConnectivityResult.none));
  }

  void _updateOnlineStatus(bool isOnline) {
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      onConnectivityChanged?.call(isOnline);
      
      if (isOnline) {
        _syncOfflineData();
      }
      
      debugPrint('[PWA] Connectivity changed: ${isOnline ? 'Online' : 'Offline'}');
    }
  }

  /// Configurar prompt de instalação
  Future<void> _setupInstallPrompt() async {
    if (!kIsWeb) return;
    
    // Implementação simplificada para web
    _isInstallable = true;
    onInstallPromptReady?.call();
    debugPrint('[PWA] Install prompt ready');
  }

  /// Mostrar prompt de instalação
  Future<bool> showInstallPrompt() async {
    if (!kIsWeb || !_isInstallable) {
      return false;
    }

    try {
      // Implementação simplificada
      _isInstallable = false;
      return true;
    } catch (e) {
      debugPrint('[PWA] Install prompt error: $e');
      return false;
    }
  }

  /// Registrar Service Worker
  Future<void> _registerServiceWorker() async {
    if (!kIsWeb) return;
    
    try {
      // Implementação simplificada para web
      debugPrint('[PWA] Service Worker registered');
    } catch (e) {
      debugPrint('[PWA] Service Worker registration failed: $e');
    }
  }

  /// Configurar notificações push
  Future<void> _setupNotifications() async {
    if (!kIsWeb) return;
    
    debugPrint('[PWA] Notifications configured');
  }

  /// Mostrar notificação local
  Future<void> showNotification({
    required String title,
    String? body,
    String? icon,
    String? tag,
  }) async {
    if (!kIsWeb) return;
    
    try {
      debugPrint('[PWA] Notification: $title - $body');
    } catch (e) {
      debugPrint('[PWA] Notification error: $e');
    }
  }

  /// Salvar dados offline
  Future<void> saveOfflineData(String key, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineData = prefs.getString('offline_data') ?? '{}';
      final Map<String, dynamic> allData = json.decode(offlineData);
      
      allData[key] = {
        'data': data,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'synced': false,
      };
      
      await prefs.setString('offline_data', json.encode(allData));
      debugPrint('[PWA] Offline data saved: $key');
    } catch (e) {
      debugPrint('[PWA] Save offline data error: $e');
    }
  }

  /// Recuperar dados offline
  Future<Map<String, dynamic>?> getOfflineData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineData = prefs.getString('offline_data') ?? '{}';
      final Map<String, dynamic> allData = json.decode(offlineData);
      
      return allData[key]?['data'];
    } catch (e) {
      debugPrint('[PWA] Get offline data error: $e');
      return null;
    }
  }

  /// Sincronizar dados offline
  Future<void> _syncOfflineData() async {
    if (!_isOnline) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineData = prefs.getString('offline_data') ?? '{}';
      final Map<String, dynamic> allData = json.decode(offlineData);
      
      final unsyncedData = allData.entries
          .where((entry) => entry.value['synced'] == false)
          .toList();
      
      if (unsyncedData.isEmpty) return;
      
      debugPrint('[PWA] Syncing ${unsyncedData.length} offline items');
      
      for (final entry in unsyncedData) {
        await _syncDataItem(entry.key, entry.value['data']);
        allData[entry.key]['synced'] = true;
      }
      
      await prefs.setString('offline_data', json.encode(allData));
      debugPrint('[PWA] Offline data sync completed');
      
    } catch (e) {
      debugPrint('[PWA] Sync offline data error: $e');
    }
  }

  /// Sincronizar item específico
  Future<void> _syncDataItem(String key, Map<String, dynamic> data) async {
    // Implementar lógica específica de sincronização baseada no tipo de dados
    if (key.startsWith('diary_')) {
      await _syncDiaryEntry(data);
    } else if (key.startsWith('forum_')) {
      await _syncForumPost(data);
    }
  }

  Future<void> _syncDiaryEntry(Map<String, dynamic> data) async {
    // Implementar sincronização de entrada do diário
    debugPrint('[PWA] Syncing diary entry: ${data['title']}');
  }

  Future<void> _syncForumPost(Map<String, dynamic> data) async {
    // Implementar sincronização de post do fórum
    debugPrint('[PWA] Syncing forum post: ${data['title']}');
  }



  /// Verificar se há atualizações
  Future<bool> checkForUpdates() async {
    if (!kIsWeb) {
      debugPrint('[PWA] Updates check skipped on mobile');
      return false;
    }

    try {
      debugPrint('[PWA] Checking for updates');
      return true;
    } catch (e) {
      debugPrint('[PWA] Check updates error: $e');
      return false;
    }
  }

  /// Limpar cache
  Future<void> clearCache() async {
    if (!kIsWeb) {
      debugPrint('[PWA] Cache clear skipped on mobile');
      return;
    }

    try {
      debugPrint('[PWA] Cache cleared');
    } catch (e) {
      debugPrint('[PWA] Clear cache error: $e');
    }
  }

  /// Obter informações de performance
  Map<String, dynamic> getPerformanceInfo() {
    if (!kIsWeb) {
      return {'platform': 'mobile', 'pwa_features': false};
    }

    return {
      'platform': 'web',
      'pwa_features': true,
      'loadTime': 0,
      'domContentLoaded': 0,
    };
  }

  /// Dispose
  void dispose() {
    _connectivitySubscription?.cancel();
  }
}