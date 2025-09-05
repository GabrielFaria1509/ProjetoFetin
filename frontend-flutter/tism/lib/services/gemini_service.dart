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
    final prompt = '''${ChatbotConfig.CUSTOM_PROMPT}

Pergunta do usuário: $userMessage''';
    return await generateResponse(prompt);
  }

  static Future<String> generateFallbackResponse(String userMessage) async {
    try {
      return await generateAutismResponse(userMessage);
    } catch (e) {
      return '''Olá! 👋 

Estou temporariamente com dificuldades técnicas, mas posso ajudar com informações básicas sobre TEA.

Para sua pergunta sobre "$userMessage", recomendo:

• Consultar um neuropediatra ou psiquiatra infantil
• Buscar informações em sites confiáveis como ABRA (Associação Brasileira de Autismo)
• Entrar em contato com APAE local
• Procurar grupos de apoio para famílias

Lembre-se: cada pessoa com TEA é única e merece apoio individualizado! 💙''';
    }
  }
}