import 'package:flutter/material.dart';
import 'package:tism/services/language_service.dart';

/// Utility functions for text processing
class TextUtils {
  /// Ensures line breaks work correctly in Text widgets across all languages
  static String processLineBreaks(String text) {
    return text
        .replaceAll('\\\\n', '\n')  // Convert escaped \n to actual line breaks
        .replaceAll('\\n', '\n');   // Ensure single \n stays as line breaks
  }
  
  /// Get text direction based on current language
  static TextDirection getTextDirection() {
    return languageService.isRTL ? TextDirection.rtl : TextDirection.ltr;
  }
  
  /// Get left alignment based on text direction
  static Alignment getLeftAlignment() {
    return languageService.isRTL ? Alignment.centerRight : Alignment.centerLeft;
  }
}