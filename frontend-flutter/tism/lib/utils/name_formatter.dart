class NameFormatter {
  static const List<String> _prepositions = [
    'de', 'da', 'do', 'das', 'dos', 'e', 'del', 'della', 'di', 'du', 'van', 'von', 'la', 'le', 'em', 'na', 'no'
  ];

  static String formatName(String name) {
    if (name.trim().isEmpty) return name;
    
    // Remove espaços múltiplos e divide em palavras
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    final formattedWords = <String>[];
    
    for (int i = 0; i < words.length; i++) {
      final word = words[i].toLowerCase();
      
      // Primeira palavra sempre capitalizada
      if (i == 0) {
        formattedWords.add(_capitalizeWord(word));
      }
      // Preposições ficam minúsculas (exceto se for a última palavra)
      else if (_prepositions.contains(word) && i < words.length - 1) {
        formattedWords.add(word);
      }
      // Outras palavras são capitalizadas
      else {
        formattedWords.add(_capitalizeWord(word));
      }
    }
    
    return formattedWords.join(' ');
  }
  
  static String _capitalizeWord(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1);
  }
}