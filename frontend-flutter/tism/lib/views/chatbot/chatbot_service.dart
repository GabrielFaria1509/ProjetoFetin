import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String baseUrl = 'http://localhost:3000/api';
  
  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['message'] ?? 'Erro na resposta';
      } else {
        return 'Desculpe, não consegui processar sua mensagem no momento.';
      }
    } catch (e) {
      // Respostas offline para demonstração
      return _getOfflineResponse(message);
    }
  }

  static String _getOfflineResponse(String message) {
    final msg = message.toLowerCase();
    
    if (msg.contains('autismo') || msg.contains('tea')) {
      return 'O TEA (Transtorno do Espectro Autista) é uma condição neurológica que afeta a comunicação, interação social e comportamento. Cada pessoa no espectro é única.';
    }
    
    if (msg.contains('sintoma') || msg.contains('sinal')) {
      return 'Alguns sinais precoces incluem: dificuldade no contato visual, atraso na fala, comportamentos repetitivos e dificuldades na interação social.';
    }
    
    if (msg.contains('diagnóstico')) {
      return 'O diagnóstico do TEA é feito por profissionais especializados através de observação comportamental e avaliações específicas. Procure um neuropediatra ou psiquiatra.';
    }
    
    if (msg.contains('terapia') || msg.contains('tratamento')) {
      return 'As principais terapias incluem ABA, fonoaudiologia, terapia ocupacional e psicoterapia. O tratamento deve ser personalizado para cada pessoa.';
    }
    
    if (msg.contains('escola') || msg.contains('educação')) {
      return 'A inclusão escolar é um direito. É importante trabalhar com a escola para criar um ambiente acolhedor e adaptações necessárias.';
    }
    
    return 'Obrigado pela sua pergunta! Estou aqui para ajudar com informações sobre TEA. Você pode consultar nossos recursos na aba "Feed Educativo" para mais detalhes.';
  }
}