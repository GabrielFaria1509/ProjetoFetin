import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'secure_storage_service.dart';

class LanguageService {
  static Map<String, String> _strings = {};
  static String _currentLanguage = 'pt-br';
  
  // Idiomas disponíveis
  static const Map<String, String> availableLanguages = {
    'pt-br': 'Português (Brasil)',
    'en-us': 'English (US)',
  };
  
  // Inicializar serviço de idioma
  static Future<void> initialize([BuildContext? context]) async {
    // Detectar idioma do sistema usando WidgetsBinding
    String systemLanguage = 'pt-br';
    
    try {
      final locale = WidgetsBinding.instance.platformDispatcher.locale;
      final languageCode = locale.languageCode.toLowerCase();
      
      // Mapear códigos de idioma para nossos arquivos
      if (languageCode == 'en') {
        systemLanguage = 'en-us';
      } else if (languageCode == 'pt') {
        systemLanguage = 'pt-br';
      }
    } catch (e) {
      // Fallback para português se não conseguir detectar
      systemLanguage = 'pt-br';
    }
    
    // Usar idioma do sistema se disponível, senão português
    if (availableLanguages.containsKey(systemLanguage)) {
      _currentLanguage = systemLanguage;
    } else {
      _currentLanguage = 'pt-br';
    }
    
    await _loadLanguage(_currentLanguage);
  }
  
  // Carregar arquivo de idioma
  static Future<void> _loadLanguage(String languageCode) async {
    try {
      final xmlString = await rootBundle.loadString('languages/$languageCode.xml');
      final document = XmlDocument.parse(xmlString);
      
      _strings.clear();
      
      // Extrair strings do XML
      for (final element in document.findAllElements('string')) {
        final name = element.getAttribute('name');
        final value = element.innerText;
        
        if (name != null && value.isNotEmpty) {
          _strings[name] = value;
        }
      }
      
      _currentLanguage = languageCode;
    } catch (e) {
      // Se falhar, usar português como fallback
      if (languageCode != 'pt-br') {
        await _loadLanguage('pt-br');
      }
    }
  }
  
  // Alterar idioma
  static Future<void> setLanguage(String languageCode) async {
    if (availableLanguages.containsKey(languageCode)) {
      await _loadLanguage(languageCode);
      await SecureStorageService.setSecureString('app_language', languageCode);
    }
  }
  
  // Obter string traduzida
  static String getString(String key, [List<dynamic>? args]) {
    String text = _strings[key] ?? key;
    
    // Substituir placeholders %s, %d
    if (args != null && args.isNotEmpty) {
      for (int i = 0; i < args.length; i++) {
        text = text.replaceFirst(RegExp(r'%[sd]'), args[i].toString());
      }
    }
    
    return text;
  }
  
  // Obter idioma atual
  static String get currentLanguage => _currentLanguage;
  
  // Obter nome do idioma atual
  static String get currentLanguageName => availableLanguages[_currentLanguage] ?? 'Português (Brasil)';
  
  // Verificar se é RTL (para idiomas futuros como árabe)
  static bool get isRTL => false; // Por enquanto sempre LTR
}

// Extension para facilitar uso
extension StringTranslation on String {
  String get tr => LanguageService.getString(this);
  String trArgs(List<dynamic> args) => LanguageService.getString(this, args);
}