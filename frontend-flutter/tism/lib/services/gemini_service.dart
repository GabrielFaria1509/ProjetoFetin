import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../config/chatbot_config.dart';

class GeminiService {
  static GenerativeModel? _model;
  static bool _initialized = false;

  static Future<void> _initialize() async {
    if (_initialized) return;
    
    await dotenv.load(fileName: '.env');
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    
    _model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: apiKey!,
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
    
    final content = [Content.text(prompt)];
    final response = await _model!.generateContent(content);
    
    return response.text ?? 'Desculpe, não consegui gerar uma resposta adequada. Tente reformular sua pergunta.';
  }

  static Future<String> generateAutismResponse(String userMessage) async {
    final prompt = '''${ChatbotConfig.customPrompt}

Pergunta do usuário: $userMessage''';
    return await generateResponse(prompt);
  }

  static Future<String> generateCustomResponse(String userMessage) async {
    return await generateAutismResponse(userMessage);
  }

  static Future<String> generateFallbackResponse(String userMessage) async {
    return await generateAutismResponse(userMessage);
  }
}