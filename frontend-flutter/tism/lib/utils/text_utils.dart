import 'package:flutter/material.dart';

class TextUtils {
  static bool isArabic(String locale) {
    return locale.startsWith('ar');
  }
  
  static TextDirection getTextDirection(String locale) {
    return isArabic(locale) ? TextDirection.rtl : TextDirection.ltr;
  }
  
  static TextAlign getLeftAlignment(String locale) {
    return TextAlign.left; // Always left-aligned, even for Arabic
  }
  
  static TextAlign getAlignment(String locale, TextAlign defaultAlign) {
    // For left-aligned text, force left even for Arabic
    if (defaultAlign == TextAlign.left) {
      return TextAlign.left;
    }
    // For center and right, keep original alignment
    return defaultAlign;
  }
}