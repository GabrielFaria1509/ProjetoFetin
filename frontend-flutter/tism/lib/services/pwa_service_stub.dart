// Stub para plataformas não-web (mobile)
import 'dart:async';

class PWAService {
  static final PWAService _instance = PWAService._internal();
  factory PWAService() => _instance;
  PWAService._internal();

  // Propriedades sempre false no mobile
  bool get isOnline => true;
  bool get isInstallable => false;
  bool get isPWA => false;

  // Callbacks vazios
  Function(bool)? onConnectivityChanged;
  Function()? onInstallPromptReady;

  // Métodos que não fazem nada no mobile
  Future<void> initialize() async {
    print('[PWA] Mobile platform - PWA features disabled');
  }

  Future<bool> showInstallPrompt() async => false;
  
  Future<void> showNotification({
    required String title,
    String? body,
    String? icon,
    String? tag,
  }) async {}

  Future<void> saveOfflineData(String key, Map<String, dynamic> data) async {}
  
  Future<Map<String, dynamic>?> getOfflineData(String key) async => null;
  
  Future<bool> checkForUpdates() async => false;
  
  Future<void> clearCache() async {}
  
  Map<String, dynamic> getPerformanceInfo() => {'platform': 'mobile'};
  
  void dispose() {}
}