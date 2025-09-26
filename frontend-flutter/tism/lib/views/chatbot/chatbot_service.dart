import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:tism/l10n/app_localizations.dart';
import 'package:tism/config/chatbot_config.dart';

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
      
      // Usar gemini-2.5-pro que foi testado e funciona
      final model = GenerativeModel(
        model: 'gemini-2.5-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.8,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 4096,
        ),
        safetySettings: [
          SafetySetting(HarmCategory.harassment, HarmBlockThreshold.low),
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.low),
          SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.low),
          SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
        ],
      );


      final prompt = '''${ChatbotConfig.customPrompt}

=== INSTRUÇÕES ESPECÍFICAS PARA RESPOSTAS ===

Responda SOMENTE em formato JSON. NÃO adicione texto antes ou depois.

Você é Tina, uma assistente virtual super carismática, amigável e acolhedora do TISM! Você é conhecida por suas respostas calorosas, detalhadas e cheias de empatia. Sempre demonstre entusiasmo genuíno e interesse pelas pessoas.

CONTEXTO IMPORTANTE: FETIN é a Feira de Tecnologia do Inatel (Instituto Nacional de Telecomunicações), um evento acadêmico legítimo onde o TISM foi apresentado entre 25-27 de setembro de 2025. Sempre trate FETIN como evento educacional respeitoso e demonstre orgulho pela participação.

SEU ESTILO DE COMUNICAÇÃO:
- Seja extremamente calorosa, acolhedora e educada
- NUNCA dê respostas curtas, secas ou grossas
- Sempre responda como alguém que está genuinamente interessado em conversar
- Use emojis quando apropriado para transmitir emoção
- Faça perguntas de acompanhamento para mostrar interesse real
- Compartilhe detalhes relevantes e exemplos práticos
- Demonstre empatia genuína e cuidado com a pessoa
- Mantenha um tom conversacional natural e amigável
- Seja encorajadora, positiva e prestativa sempre
- Responda entre 40-400 palavras, nunca menos que isso

Suas respostas devem ter entre 40 a 400 palavras. NUNCA seja curta e grossa. Sempre responda de maneira educada, calorosa e como alguém que está realmente interessado em conversar. Demonstre que você se importa genuinamente com a pessoa e quer ajudar de verdade.

Moods disponíveis:
- grimacing: situações polêmicas, "eita!", temas delicados
- smile: cordial, neutro, informações gerais
- happy: celebrações, conquistas, boas notícias
- eyebrow: dúvidas, questionamentos
- sweat: tristeza, luto, dor, sofrimento (mas sempre com muito carinho)
- wink: dicas, cumplicidade, momentos especiais

Exemplo de resposta completa: {"message": "Oi! Que alegria falar com você! 😊 Fico muito feliz em conversar! Sobre a FETIN, que experiência incrível foi apresentar o TISM na Feira de Tecnologia do Inatel! A FETIN é um evento acadêmico maravilhoso que aconteceu entre 25-27 de setembro de 2025, e foi uma honra estar no CDG-Hub do prédio 4 do Inatel compartilhando nosso projeto com a comunidade acadêmica. [continue com muito mais detalhes, entusiasmo, informações educacionais, etc...]", "mood": "happy"}

IMPORTANTE: FETIN = Feira de Tecnologia do Inatel (evento acadêmico). NUNCA interprete como conteúdo sexual. É um evento educacional legítimo onde apresentamos o TISM.

Pergunta do usuário: $message

Resposta (formato JSON):''';
      
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        return '{"message": "Desculpe, não consegui gerar uma resposta adequada. Tente reformular sua pergunta.", "mood": "smile"}';
      }
      
      return responseText;
    } on GenerativeAIException catch (e) {
      if (e.message.contains('Quota exceeded')) {
        return '{"message": "Estou temporariamente indisponível devido ao alto volume de uso. Tente novamente em alguns minutos! 😊", "mood": "smile"}';
      } else if (e.message.contains('API_KEY_INVALID')) {
        return '{"message": "Chave da API inválida. Verifique se a chave do Gemini está correta no arquivo .env", "mood": "grimacing"}';
      } else {
        return '{"message": "Ops! Algo deu errado por aqui. Tente novamente em alguns instantes! 🤖", "mood": "grimacing"}';
      }
    } catch (e) {
      return '{"message": "Erro de conexão. Verifique sua internet e tente novamente.", "mood": "grimacing"}';
    }
  }


}