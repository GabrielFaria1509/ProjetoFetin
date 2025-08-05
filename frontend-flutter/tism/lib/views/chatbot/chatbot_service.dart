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
    
    // Saudações
    if (msg.contains('oi') || msg.contains('olá') || msg.contains('bom dia') || msg.contains('boa tarde') || msg.contains('boa noite')) {
      return '👋 Olá! Sou o assistente TISM, especializado em TEA. Como posso ajudar você hoje? Posso falar sobre sintomas, diagnóstico, terapias, educação e muito mais!';
    }
    
    // Agradecimentos
    if (msg.contains('obrigad') || msg.contains('valeu') || msg.contains('brigad')) {
      return '😊 Fico feliz em ajudar! Se tiver mais dúvidas sobre TEA, estarei sempre aqui. Lembre-se: cada pessoa no espectro é única e especial!';
    }
    
    // TEA Geral
    if (msg.contains('o que é') && (msg.contains('autismo') || msg.contains('tea'))) {
      return '🧠 O TEA (Transtorno do Espectro Autista) é uma condição neurológica que afeta:\n\n• Comunicação e linguagem\n• Interação social\n• Comportamentos e interesses\n\nÉ chamado "espectro" porque os sintomas variam muito entre as pessoas. Cada indivíduo é único!';
    }
    
    if (msg.contains('autismo') || msg.contains('tea')) {
      return '💙 O autismo é uma forma diferente de perceber e interagir com o mundo. Pessoas com TEA podem ter habilidades incríveis e contribuições valiosas para a sociedade!';
    }
    
    // Sintomas e Sinais
    if (msg.contains('sintoma') || msg.contains('sinal') || msg.contains('como identificar')) {
      return '🔍 Sinais precoces do TEA:\n\n👁️ Dificuldade no contato visual\n🗣️ Atraso ou diferenças na fala\n🔄 Comportamentos repetitivos\n👥 Dificuldades na interação social\n🎯 Interesses muito específicos\n\n⚠️ Importante: Apenas profissionais podem fazer diagnóstico!';
    }
    
    // Diagnóstico
    if (msg.contains('diagnóstico') || msg.contains('como diagnosticar')) {
      return '🏥 O diagnóstico do TEA:\n\n👨‍⚕️ Feito por profissionais especializados\n📋 Baseado em observação comportamental\n🧩 Avaliações específicas (ADOS, ADI-R)\n⏰ Pode ser feito a partir dos 18 meses\n\n🔍 Procure: neuropediatra, psiquiatra ou psicólogo especializado.';
    }
    
    // Terapias
    if (msg.contains('terapia') || msg.contains('tratamento') || msg.contains('aba')) {
      return '🎯 Principais terapias para TEA:\n\n🧩 ABA - Análise do Comportamento Aplicada\n🗣️ Fonoaudiologia - comunicação\n🤲 Terapia Ocupacional - habilidades diárias\n💭 Psicoterapia - aspectos emocionais\n🎵 Musicoterapia - expressão e socialização\n\n✨ O tratamento deve ser personalizado!';
    }
    
    // Educação
    if (msg.contains('escola') || msg.contains('educação') || msg.contains('inclusão')) {
      return '🏫 Inclusão escolar no TEA:\n\n📚 Direito garantido por lei\n👩‍🏫 Apoio pedagógico especializado\n🔧 Adaptações curriculares\n👥 Mediador escolar quando necessário\n🤝 Parceria família-escola\n\n💡 Cada criança tem seu ritmo de aprendizagem!';
    }
    
    // Família
    if (msg.contains('família') || msg.contains('pais') || msg.contains('como ajudar')) {
      return '👨‍👩‍👧‍👦 Dicas para famílias:\n\n💙 Aceite e ame incondicionalmente\n📅 Mantenha rotinas estruturadas\n🗣️ Comunique-se de forma clara\n🎯 Celebre pequenas conquistas\n🤝 Busque apoio profissional\n👥 Conecte-se com outras famílias\n\n🌟 Você não está sozinho nessa jornada!';
    }
    
    // Comportamentos
    if (msg.contains('comportamento') || msg.contains('crise') || msg.contains('birra')) {
      return '🧘‍♀️ Lidando com comportamentos:\n\n🔍 Identifique os gatilhos\n😌 Mantenha a calma\n🔄 Use estratégias de regulação\n⏰ Respeite o tempo da pessoa\n🎯 Ofereça alternativas\n💪 Seja consistente\n\n📞 Em crises intensas, busque ajuda profissional.';
    }
    
    // Direitos
    if (msg.contains('direito') || msg.contains('lei') || msg.contains('benefício')) {
      return '⚖️ Direitos da pessoa com TEA:\n\n🎫 Cartão de prioridade\n🚌 Passe livre no transporte\n💰 BPC (Benefício de Prestação Continuada)\n🏥 Atendimento prioritário\n🏫 Educação inclusiva\n💼 Cotas no mercado de trabalho\n\n📋 Lei 12.764/2012 - Lei Berenice Piana';
    }
    
    // Desenvolvimento
    if (msg.contains('desenvolvimento') || msg.contains('habilidade')) {
      return '🌱 Desenvolvimento no TEA:\n\n🧠 Cada pessoa tem seu ritmo\n💪 Foque nas potencialidades\n🎯 Estimule habilidades sociais\n🗣️ Trabalhe a comunicação\n🎨 Explore talentos especiais\n⏰ Tenha paciência e persistência\n\n✨ Pequenos progressos são grandes vitórias!';
    }
    
    // Resposta padrão mais inteligente
    return '🤖 Entendi sua pergunta! Sou especializado em TEA e posso ajudar com:\n\n• Sintomas e diagnóstico\n• Terapias e tratamentos\n• Educação e inclusão\n• Direitos e benefícios\n• Apoio familiar\n• Desenvolvimento\n\n💡 Reformule sua pergunta ou escolha um tópico. Também temos artigos no Feed Educativo!';
  }
}