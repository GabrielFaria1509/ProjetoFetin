import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotService {
  static Future<String> sendMessage(String message) async {
    try {
      await dotenv.load();
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      
      if (apiKey == null || apiKey.isEmpty) {
        return 'Erro: API key não configurada no arquivo .env';
      }
      
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final prompt = '''Você é um assistente especializado em TEA (Transtorno do Espectro Autista).
Responda de forma empática e útil em português.

Pergunta: $message''';
      
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      return response.text ?? 'Desculpe, não consegui gerar uma resposta.';
    } catch (e) {
      return 'Erro ao conectar com a API: $e';
    }
  }
}