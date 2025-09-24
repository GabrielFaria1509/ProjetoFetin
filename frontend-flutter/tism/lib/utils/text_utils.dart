/// Utility functions for text processing
class TextUtils {
  /// Ensures line breaks work correctly in Text widgets across all languages
  static String processLineBreaks(String text) {
    return text
        .replaceAll('\\\\n', '\n')  // Convert escaped \n to actual line breaks
        .replaceAll('\\n', '\n');   // Ensure single \n stays as line breaks
  }
}