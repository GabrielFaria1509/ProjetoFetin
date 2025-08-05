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
      return '👋 Oi! Sou especialista em TEA. Pode perguntar sobre sintomas, diagnóstico, terapias, escola ou direitos. Como posso ajudar?';
    }
    
    // Agradecimentos
    if (msg.contains('obrigad') || msg.contains('valeu') || msg.contains('brigad')) {
      return '😊 Por nada! Sempre que precisar, estarei aqui. Cada pessoa com autismo é única e especial!';
    }
    
    // TEA Geral
    if ((msg.contains('o que é') || msg.contains('que é')) && (msg.contains('autismo') || msg.contains('tea'))) {
      return '🧠 TEA é uma condição neurológica que afeta:\n• Comunicação\n• Interação social\n• Comportamentos\n\nCada pessoa é única - não é doença, é uma forma diferente de ver o mundo!';
    }
    
    if (msg.contains('autismo') || msg.contains('tea')) {
      return '💙 Autismo é ter um cérebro especial! Pessoas com TEA podem ter talentos incríveis e formas únicas de ver o mundo.';
    }
    
    // Sintomas
    if (msg.contains('sintoma') || msg.contains('sinal') || msg.contains('identificar') || msg.contains('como saber')) {
      return '🔍 Principais sinais:\n\n👀 Comunicação:\n• Pouco contato visual\n• Atraso na fala\n• Repete palavras\n\n🤝 Social:\n• Prefere brincar sozinho\n• Dificuldade para fazer amigos\n\n🔄 Comportamento:\n• Movimentos repetitivos\n• Rotinas rígidas\n• Interesses específicos\n\n⚠️ Só profissional pode diagnosticar!';
    }
    
    // Diagnóstico
    if (msg.contains('diagnóstico') || msg.contains('médico') || msg.contains('profissional')) {
      return '🏥 Diagnóstico:\n\n👨‍⚕️ Procure:\n• Neuropediatra\n• Psiquiatra\n• Psicólogo especializado\n\n📋 Processo:\n• Conversa com família\n• Observação comportamental\n• Testes específicos\n\n⏰ Pode ser feito desde 18 meses\n💙 É o primeiro passo para apoio adequado!';
    }
    
    // Terapias
    if (msg.contains('terapia') || msg.contains('tratamento') || msg.contains('aba') || msg.contains('ajuda')) {
      return '🎯 Terapias principais:\n\n🧩 ABA - ensina habilidades práticas\n🗣️ Fonoaudiologia - comunicação\n🤲 Terapia Ocupacional - atividades diárias\n💭 Psicoterapia - emoções\n🎵 Outras: música, equoterapia, natação\n\n✨ Cada pessoa precisa de um mix diferente!';
    }
    
    // Educação
    if (msg.contains('escola') || msg.contains('educação') || msg.contains('inclusão') || msg.contains('estudar')) {
      return '🏫 Escola e autismo:\n\n📚 Direitos:\n• Educação garantida por lei\n• Escola deve se adaptar\n• Professor de apoio se necessário\n\n💡 Dicas:\n• Converse com professores\n• Explique necessidades da criança\n• Celebre cada conquista\n\n🌟 Muitas crianças com TEA se dão bem na escola!';
    }
    
    // Família
    if (msg.contains('família') || msg.contains('pais') || msg.contains('mãe') || msg.contains('pai') || msg.contains('como ajudar')) {
      return '👨‍👩‍👧‍👦 Para famílias:\n\n💙 Aceite seu filho como ele é\n🏠 Crie rotinas previsíveis\n📸 Use comunicação visual\n🎉 Celebre pequenas conquistas\n🤝 Conecte-se com outras famílias\n⏰ Tenha paciência\n\n🌟 Você conhece seu filho melhor que ninguém!';
    }
    
    // Comportamentos
    if (msg.contains('comportamento') || msg.contains('crise') || msg.contains('birra') || msg.contains('agressivo')) {
      return '🧘‍♀️ Comportamentos difíceis:\n\n🔍 Causas:\n• Sobrecarga sensorial\n• Mudança na rotina\n• Frustração\n• Cansaço/fome\n\n😌 O que fazer:\n• Mantenha calma\n• Identifique a causa\n• Ambiente mais calmo\n• Poucas palavras, tom suave\n\n🤗 Não é birra, é comunicação!';
    }
    
    // Direitos
    if (msg.contains('direito') || msg.contains('lei') || msg.contains('benefício') || msg.contains('gratuito')) {
      return '⚖️ Seus direitos:\n\n🎫 Prioridade em filas\n🚌 Transporte gratuito\n💰 BPC (1 salário mínimo)\n🏥 Atendimento especializado\n🏫 Educação inclusiva\n💼 Cotas no trabalho\n\n📋 Lei 12.764/2012 (Berenice Piana)\n💪 Use seus direitos!';
    }
    
    // Desenvolvimento
    if (msg.contains('desenvolvimento') || msg.contains('habilidade') || msg.contains('progresso') || msg.contains('melhora')) {
      return '🌱 Desenvolvimento:\n\n🧠 Cada pessoa tem seu ritmo\n💪 Foque nas potencialidades\n🎯 Use interesses como ponte\n🗣️ Trabalhe comunicação diariamente\n⏰ Tenha paciência\n\n✨ Pequenos passos são grandes vitórias!';
    }
    
    // Resposta padrão
    return '🤖 Posso ajudar com:\n\n• Sintomas e diagnóstico\n• Terapias\n• Escola\n• Família\n• Direitos\n• Desenvolvimento\n\n💡 Seja específico: "Como identificar autismo?" ou "Que terapias ajudam?"\n\n📚 Veja também o Feed Educativo!';
  }
}