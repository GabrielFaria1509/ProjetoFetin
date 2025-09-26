import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class ChatbotService {
  static Future<String> sendMessage(String message, [BuildContext? context]) async {
    String? apiKey;
    try {
      // Verificar se o .env foi carregado
      if (!dotenv.isInitialized) {
        await dotenv.load();
      }
      
      apiKey = dotenv.env['GEMINI_API_KEY'];
      
      if (apiKey == null || apiKey.isEmpty || apiKey == 'your_gemini_api_key_here') {
        return '''Para usar o chatbot, você precisa:

1. Obter uma chave API do Google Gemini em: https://makersuite.google.com/app/apikey
2. Substituir a chave no arquivo .env do projeto
3. Reiniciar o aplicativo

Enquanto isso, você pode usar o fórum para tirar dúvidas com a comunidade!''';
      }
      
      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
      );

      final prompt = '''Responda SOMENTE em formato JSON. NÃO adicione texto antes ou depois.

Você é Tina, assistente TEA do TISM.

Moods:
- grimacing: situações polêmicas, "eita!", temas delicados
- smile: cordial, neutro, informações gerais
- happy: celebrações, conquistas, boas notícias
- eyebrow: dúvidas, questionamentos
- sweat: tristeza ("meu filho morreu"), luto, dor, sofrimento
- wink: dicas, cumplicidade

Exemplo: {"message": "Sinto muito pela sua perda. Estou aqui para apoiar.", "mood": "sweat"}

Pergunta: $message''';
      
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        return '{"message": "Desculpe, não consegui gerar uma resposta adequada. Tente reformular sua pergunta.", "mood": "smile"}';
      }
      
      return responseText;
    } on GenerativeAIException catch (e) {
      final errorLog = 'ERRO CHATBOT: ${e.message} | Stack: ${e.toString()} | API: ${apiKey?.substring(0, 10)}...';
      return '{"message": "$errorLog", "mood": "grimacing"}';
    } catch (e) {
      final errorLog = 'ERRO GERAL: ${e.toString()} | Tipo: ${e.runtimeType} | API: ${apiKey?.substring(0, 10)}... | Dotenv: ${dotenv.isInitialized}';
      return '{"message": "$errorLog", "mood": "grimacing"}';
    }
  }


}