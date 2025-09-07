import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/chatbot_config.dart';

class GeminiService {
  static GenerativeModel? _model;
  static bool _initialized = false;

  static Future<void> _initialize() async {
    if (_initialized) return;
    
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    
    if (apiKey == null || apiKey.isEmpty || apiKey == 'your_gemini_api_key_here') {
      throw Exception('API key do Gemini não configurada no arquivo .env');
    }

    _model = GenerativeModel(
      model: 'gemini-1.5-flash-8b',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
    );
    
    _initialized = true;
  }

  static Future<String> generateResponse(String prompt) async {
    await _initialize();
    
    try {
      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);
      
      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        return 'Desculpe, não consegui gerar uma resposta adequada. Tente reformular sua pergunta.';
      }
    } catch (e) {
      throw Exception('Erro ao gerar resposta: $e');
    }
  }

  static Future<String> generateAutismResponse(String userMessage) async {
    final prompt = '''
Você é TISM, um assistente especializado em TEA (Transtorno do Espectro Autista) desenvolvido para apoiar famílias e pessoas com autismo.

Suas características:
- Empático, acolhedor e baseado em evidências científicas
- Usa linguagem clara e acessível
- Oferece informações práticas e acionáveis
- Sempre sugere buscar profissionais quando necessário
- Foca em esperança e possibilidades

Pergunta: $userMessage

Responda de forma:
✓ Clara e objetiva (máximo 300 palavras)
✓ Com informações precisas sobre TEA
✓ Incluindo orientações práticas
✓ Oferecendo apoio emocional quando apropriado
✓ Sugerindo recursos e próximos passos
✓ Sempre recomendando profissionais especializados quando necessário

Use emojis moderadamente para tornar a resposta mais acolhedora.''';

    return await generateResponse(prompt);
  }

  static Future<String> generateCustomResponse(String userMessage) async {
    try {
      await _initialize();
      final prompt = '''${ChatbotConfig.customPrompt}

Pergunta do usuário: $userMessage''';
      return await generateResponse(prompt);
    } catch (e) {
      return await generateFallbackResponse(userMessage);
    }
  }

  static Future<String> generateFallbackResponse(String userMessage) async {
    return _getSmartResponse(userMessage);
  }
  
  static String _getSmartResponse(String message) {
    final msg = message.toLowerCase();
    
    if (msg.contains('diagnóstico') || msg.contains('diagnostico')) {
      return '''👩‍⚕️ **Sobre Diagnóstico de TEA**

O diagnóstico do TEA deve ser feito por profissionais especializados:

• **Neuropediatra** - especialista em desenvolvimento
• **Psiquiatra infantil** - avaliação comportamental
• **Psicólogo** - testes e observações

**Sinais importantes:**
• Dificuldades na comunicação
• Padrões repetitivos de comportamento
• Desafios na interação social

📝 **Próximos passos:** Procure um neuropediatra para avaliação completa. Quanto mais cedo, melhor! 💙''';
    }
    
    if (msg.contains('sintoma') || msg.contains('sinal')) {
      return '''🔍 **Principais Sinais do TEA**

**Comunicação:**
• Atraso ou ausência da fala
• Dificuldade em manter conversas
• Uso repetitivo da linguagem

**Comportamento:**
• Movimentos repetitivos
• Resistência a mudanças na rotina
• Interesses muito específicos

**Interação Social:**
• Dificuldade no contato visual
• Desafios para fazer amizades
• Dificuldade em compartilhar interesses

⚠️ **Importante:** Cada pessoa é única! Procure avaliação profissional. 💙''';
    }
    
    if (msg.contains('terapia') || msg.contains('tratamento')) {
      return '''🌱 **Terapias para TEA**

**Principais abordagens:**
• **ABA** - Análise do Comportamento Aplicada
• **Fonoaudiologia** - desenvolvimento da comunicação
• **Terapia Ocupacional** - habilidades do dia a dia
• **Psicoterapia** - apoio emocional

**Dicas importantes:**
• Intervenção precoce é fundamental
• Cada criança responde diferente
• Combine diferentes abordagens
• Inclua a família no processo

💪 **Lembre-se:** Progressão acontece no tempo de cada um! 💙''';
    }
    
    if (msg.contains('escola') || msg.contains('inclusão')) {
      return '''🏫 **Inclusão Escolar no TEA**

**Direitos garantidos:**
• Matrícula em escola regular
• Acompanhante especializado se necessário
• Adaptações curriculares
• Ambiente acessível

**Dicas para famílias:**
• Converse com a escola sobre as necessidades
• Compartilhe estratégias que funcionam em casa
• Mantenha diálogo constante com professores
• Celebre cada conquista!

📄 **Importante:** Conheça a Lei 12.764/2012 (Lei Berenice Piana) 💙''';
    }
    
    return '''💙 **Olá! Sou o assistente TEA do TISM**

Estou aqui para ajudar com informações sobre:

• 🔍 Sinais e características do TEA
• 👩‍⚕️ Orientações sobre diagnóstico
• 🌱 Terapias e intervenções
• 🏫 Inclusão escolar
• 💪 Apoio à família

**Seja mais específico:** "Como identificar sinais de autismo?" ou "Que terapias são recomendadas?"

🤗 **Lembre-se:** Você não está sozinho(a) nessa jornada!''';
  }
}