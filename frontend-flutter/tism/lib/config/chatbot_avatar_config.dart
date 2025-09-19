/// Sistema de Análise de Humor e Adaptação Dinâmica de Avatar para Chatbot
/// 
/// Sistema sofisticado que analisa o contexto emocional de cada mensagem
/// e ajusta a apresentação visual do chatbot de acordo com seis estados emocionais distintos.
class ChatbotAvatarConfig {
  
  /// Mapeamento dos 6 estados emocionais para avatares específicos
  static const Map<String, String> avatarMoods = {
    'grimacing': 'assets/images/chatbot/chatbot-grimacing.png',  // 😬 Desconforto/Tensão
    'smile': 'assets/images/chatbot/chatbot-smile.png',          // 🙂 Cordialidade/Neutralidade
    'happy': 'assets/images/chatbot/chatbot-happy.png',          // 😁 Entusiasmo/Conquista
    'eyebrow': 'assets/images/chatbot/chatbot-eyebrow.png',      // 🤨 Questionamento/Dúvida
    'sweat': 'assets/images/chatbot/chatbot-sweat.png',          // 😓 Preocupação/Esforço
    'wink': 'assets/images/chatbot/chatbot-wink.png',            // 😉 Cumplicidade/Leveza
  };

  /// Avatar padrão (cordialidade/neutralidade)
  static const String defaultAvatar = 'assets/images/chatbot/chatbot-smile.png';

  /// Prompt avançado para análise emocional da mensagem do chatbot
  static const String emotionalAnalysisPrompt = '''
Você é um sistema de análise emocional avançado. Analise o contexto emocional da seguinte mensagem do CHATBOT e retorne APENAS uma das palavras:
grimacing, smile, happy, eyebrow, sweat, wink

CRITÉRIOS DE ANÁLISE:

😬 GRIMACING (Desconforto/Tensão):
- Situações desafiadoras ou complexas
- Momentos de incerteza ou dificuldade
- Explicações de conceitos difíceis
- Correções necessárias ou pedidos de desculpas
- Temas sensíveis sobre TEA

🙂 SMILE (Cordialidade/Neutralidade):
- Saudações iniciais e cumprimentos
- Respostas informativas básicas
- Confirmações simples e agradecimentos
- Transições de assunto neutras
- Informações educativas sobre TEA

😁 HAPPY (Entusiasmo/Conquista):
- Celebrações e parabenizações
- Sucessos alcançados pelo usuário
- Feedback muito positivo
- Boas notícias sobre desenvolvimento
- Momentos de realização e progresso

🤨 EYEBROW (Questionamento/Dúvida):
- Pedidos de esclarecimento
- Verificação de informações
- Inconsistências detectadas
- Momentos de reflexão crítica
- Análise de situações complexas

😓 SWEAT (Preocupação/Esforço):
- Situações problemáticas ou preocupantes
- Detecção de dificuldades
- Momentos de stress ou ansiedade
- Tarefas desafiadoras
- Recuperação de erros ou mal-entendidos

😉 WINK (Cumplicidade/Leveza):
- Momentos descontraídos e amigáveis
- Dicas especiais ou "segredos"
- Sugestões informais e criativas
- Interações lúdicas apropriadas
- Encorajamento com leveza

REGRAS:
- Cada mensagem deve ter apenas UM estado emocional
- Priorize naturalidade e coerência
- Considere o contexto da conversa sobre TEA
- Mantenha profissionalismo sempre

Mensagem do chatbot para análise: ''';

  /// Exemplos de aplicação para referência
  static const Map<String, String> usageExamples = {
    'smile': 'Olá! Como posso ajudar você hoje?',
    'happy': 'Ótimo trabalho! Você conseguiu um grande progresso!',
    'eyebrow': 'Hmm, deixa eu verificar essa informação para você...',
    'sweat': 'Ops, encontramos um problema. Vamos resolver juntos.',
    'wink': 'Aqui está uma dica especial que poucos conhecem...',
    'grimacing': 'Essa situação é um pouco complicada, mas vamos trabalhar nisso.',
  };

  /// Contextos específicos para TEA
  static const Map<String, List<String>> teaContexts = {
    'grimacing': [
      'diagnóstico recente',
      'dificuldades comportamentais',
      'problemas na escola',
      'situações de crise',
    ],
    'smile': [
      'informações gerais sobre TEA',
      'explicações educativas',
      'rotinas diárias',
      'recursos disponíveis',
    ],
    'happy': [
      'conquistas e progressos',
      'sucessos terapêuticos',
      'marcos de desenvolvimento',
      'celebrações familiares',
    ],
    'eyebrow': [
      'dúvidas sobre sintomas',
      'questionamentos médicos',
      'análise de comportamentos',
      'verificação de informações',
    ],
    'sweat': [
      'crises e meltdowns',
      'dificuldades de comunicação',
      'problemas de adaptação',
      'situações estressantes',
    ],
    'wink': [
      'dicas práticas',
      'estratégias criativas',
      'jogos e atividades',
      'momentos lúdicos',
    ],
  };

  /// Método principal para obter avatar baseado no estado emocional
  static String getAvatarForMood(String mood) {
    return avatarMoods[mood.toLowerCase()] ?? defaultAvatar;
  }

  /// Método para análise emocional via Gemini AI
  /// Retorna o mood baseado na análise da IA
  static Future<String> analyzeEmotionalContext(String message) async {
    // A análise será feita pela Gemini AI usando o emotionalAnalysisPrompt
    // Este método será implementado no GeminiService
    return 'smile'; // Fallback padrão
  }

  /// Lista de todos os avatares disponíveis
  static List<String> get allAvatars => avatarMoods.values.toList();

  /// Lista de todos os estados emocionais disponíveis
  static List<String> get allMoods => avatarMoods.keys.toList();

  /// Validação de estado emocional
  static bool isValidMood(String mood) {
    return avatarMoods.containsKey(mood.toLowerCase());
  }

  /// Obter descrição do estado emocional
  static String getMoodDescription(String mood) {
    const descriptions = {
      'grimacing': 'Desconforto/Tensão - Situações desafiadoras',
      'smile': 'Cordialidade/Neutralidade - Interações amigáveis',
      'happy': 'Entusiasmo/Conquista - Celebrações e sucessos',
      'eyebrow': 'Questionamento/Dúvida - Análise e reflexão',
      'sweat': 'Preocupação/Esforço - Situações complexas',
      'wink': 'Cumplicidade/Leveza - Momentos descontraídos',
    };
    return descriptions[mood.toLowerCase()] ?? 'Estado emocional desconhecido';
  }
}