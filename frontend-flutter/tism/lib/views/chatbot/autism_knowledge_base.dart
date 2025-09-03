class AutismKnowledgeBase {
  static const Map<String, Map<String, dynamic>> _knowledge = {
    'compreendendo_autismo': {
      'keywords': ['o que é', 'que é', 'definição', 'conceito', 'autismo', 'tea'],
      'response': '**Compreendendo o Autismo (TEA)**\n\nO Transtorno do Espectro Autista é uma condição neurológica que afeta:\n• Comunicação\n• Interação social\n• Comportamentos repetitivos\n• Sensibilidades sensoriais',
      'follow_up': ['sintomas', 'diagnostico', 'tratamento']
    },
  };

  static String findResponse(String query) {
    final lowerQuery = query.toLowerCase();
    
    for (final entry in _knowledge.values) {
      final keywords = entry['keywords'] as List<String>;
      for (final keyword in keywords) {
        if (lowerQuery.contains(keyword.toLowerCase())) {
          return entry['response'] as String;
        }
      }
    }
    
    return getDefaultResponse();
  }

  static String getDefaultResponse() {
    return '💙 **Olá! Estou aqui para ajudar com informações sobre TEA.**\n\n'
           'Posso orientar sobre:\n'
           '• Sinais e sintomas do autismo\n'
           '• Processo de diagnóstico\n'
           '• Terapias e intervenções\n'
           '• Direitos e inclusão\n'
           '• Apoio familiar\n\n'
           'Como posso ajudar você hoje?';
  }

  static List<String> getFollowUpSuggestions(String response) {
    return [
      'Como identificar sinais precoces?',
      'Quais terapias são mais eficazes?',
      'Como conseguir diagnóstico?'
    ];
  }
}