import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'secure_storage_service.dart';

class LanguageService extends ChangeNotifier {
  final Map<String, String> _strings = {};
  String _currentLanguage = 'pt';
  Locale _currentLocale = const Locale('pt');
  
  // Idiomas disponíveis
  static const Map<String, String> availableLanguages = {
    'pt': 'Português',
    'en': 'English',
    'fr': 'Français',
    'es': 'Español',
    'de': 'Deutsch',
    'ru': 'Русский',
    'ja': '日本語',
    'it': 'Italiano',
    'ko': '한국어',
    'tr': 'Türkçe',
    'hi': 'हिन्दी',
    'ar': 'العربية',
    'zh': '中文',
  };
  
  // Inicializar serviço de idioma
  Future<void> initialize([BuildContext? context]) async {
    // Detectar idioma do sistema
    String systemLanguage = 'pt';
    
    try {
      if (kIsWeb) {
        // Para web, forçar português por enquanto
        systemLanguage = 'pt';
      } else {
        // Para mobile, usar WidgetsBinding
        final locale = WidgetsBinding.instance.platformDispatcher.locale;
        final languageCode = locale.languageCode.toLowerCase();
        if (availableLanguages.containsKey(languageCode)) {
          systemLanguage = languageCode;
        }
      }
    } catch (e) {
      // Fallback para português se não conseguir detectar
      systemLanguage = 'pt';
    }
    
    // Usar idioma do sistema se disponível, senão português
    if (availableLanguages.containsKey(systemLanguage)) {
      _currentLanguage = systemLanguage;
    } else {
      _currentLanguage = 'pt';
    }
    
    await _loadLanguage(_currentLanguage);
    notifyListeners();
  }
  
  // Carregar arquivo de idioma
  Future<void> _loadLanguage(String languageCode) async {
    try {
      final arbString = await rootBundle.loadString('languages/$languageCode.arb');
      final Map<String, dynamic> arbData = json.decode(arbString);
      
      _strings.clear();
      
      // Extrair strings do ARB (ignorar metadados que começam com @@)
      arbData.forEach((key, value) {
        if (!key.startsWith('@@') && value is String) {
          _strings[key] = value;
        }
      });
      
      _currentLanguage = languageCode;
      _currentLocale = Locale(languageCode);
    } catch (e) {
      // Se falhar, usar português como fallback
      if (languageCode != 'pt') {
        await _loadLanguage('pt');
      }
    }
  }
  
  // Alterar idioma
  Future<void> setLanguage(String languageCode) async {
    if (availableLanguages.containsKey(languageCode)) {
      await _loadLanguage(languageCode);
      await SecureStorageService.setSecureString('app_language', languageCode);
      notifyListeners();
    }
  }
  
  // Obter string traduzida
  String getString(String key) {
    return _strings[key] ?? key;
  }
  
  // Obter idioma atual
  String get currentLanguage => _currentLanguage;
  
  // Obter locale atual
  Locale get currentLocale => _currentLocale;
  
  // Obter nome do idioma atual
  String get currentLanguageName => availableLanguages[_currentLanguage] ?? 'Português';
  
  // Verificar se é RTL
  bool get isRTL => _currentLanguage == 'ar';
  
  // Helper para obter AppLocalizations do contexto
  static AppLocalizations? of(BuildContext context) {
    return AppLocalizations.of(context);
  }
}

// Instância global
final languageService = LanguageService();

// Extension para facilitar uso
extension StringTranslation on String {
  String get tr => languageService.getString(this);
}