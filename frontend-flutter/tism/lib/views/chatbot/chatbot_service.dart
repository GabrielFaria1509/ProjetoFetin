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
      return '👋 Olá! Que bom ter você aqui! Sou seu assistente especializado em autismo e estou aqui para te apoiar. Pode me perguntar qualquer coisa sobre TEA - desde os primeiros sinais até dicas práticas do dia a dia. O que você gostaria de saber?';
    }
    
    // Agradecimentos
    if (msg.contains('obrigad') || msg.contains('valeu') || msg.contains('brigad')) {
      return '😊 Fico muito feliz em poder ajudar! Lembre-se: você não está sozinho nessa jornada. Cada pessoa com autismo é única e especial, e cada pequeno passo é uma grande conquista. Sempre que precisar, estarei aqui!';
    }
    
    // TEA Geral - Explicação acessível
    if (msg.contains('o que é') && (msg.contains('autismo') || msg.contains('tea'))) {
      return '💙 O autismo (TEA) é uma forma diferente de ver e sentir o mundo. Imagine que cada pessoa tem um "sistema operacional" único no cérebro:\n\n🧠 Algumas pessoas processam informações de forma diferente\n💬 Podem se comunicar de maneiras únicas\n👥 Têm seu próprio jeito de se relacionar\n🎯 Podem ter interesses super intensos em coisas específicas\n\nNão é doença - é uma condição neurológica que faz parte de quem a pessoa é. E cada pessoa com autismo é completamente única!';
    }
    
    if (msg.contains('autismo') || msg.contains('tea')) {
      return '🌟 O autismo é como ter um cérebro que funciona de forma especial! Pessoas com TEA podem ter talentos incríveis, memória fantástica, atenção aos detalhes e formas únicas de ver o mundo. É uma diferença, não um defeito!';
    }
    
    // Sintomas - Linguagem mais humana
    if (msg.contains('sintoma') || msg.contains('sinal') || msg.contains('como identificar') || msg.contains('como saber')) {
      return '🔍 Sinais que podem indicar autismo (lembre-se: só um profissional pode confirmar):\n\n👀 **Comunicação:**\n• Pouco contato visual\n• Demora para falar ou fala de forma diferente\n• Repete palavras ou frases\n\n🤝 **Relacionamento:**\n• Prefere brincar sozinho\n• Dificuldade para fazer amigos\n• Não aponta para mostrar coisas\n\n🔄 **Comportamentos:**\n• Movimentos repetitivos (balançar, bater palmas)\n• Rotinas muito rígidas\n• Interesses muito específicos\n\n💡 Cada criança é única - alguns sinais podem aparecer, outros não!';
    }
    
    // Diagnóstico - Mais acolhedor
    if (msg.contains('diagnóstico') || msg.contains('como diagnosticar') || msg.contains('médico')) {
      return '🏥 **Como funciona o diagnóstico:**\n\nO diagnóstico é como montar um quebra-cabeças - o profissional observa vários aspectos da vida da pessoa:\n\n👨‍⚕️ **Quem procurar:**\n• Neuropediatra (para crianças)\n• Psiquiatra ou psicólogo especializado\n• Equipe multidisciplinar\n\n📋 **O que acontece:**\n• Conversas com a família\n• Observação do comportamento\n• Testes específicos (quando necessário)\n• Acompanhamento ao longo do tempo\n\n⏰ **Quando:** Pode ser feito desde bem pequeno (18 meses)\n\n💙 Lembre-se: o diagnóstico é o primeiro passo para conseguir o apoio certo!';
    }
    
    // Terapias - Explicação prática
    if (msg.contains('terapia') || msg.contains('tratamento') || msg.contains('aba') || msg.contains('ajuda')) {
      return '🎯 **Terapias que podem ajudar muito:**\n\n🧩 **ABA (Análise do Comportamento):**\nEnsina habilidades do dia a dia de forma divertida e estruturada\n\n🗣️ **Fonoaudiologia:**\nAjuda na comunicação - falar, entender e se expressar\n\n🤲 **Terapia Ocupacional:**\nEnsina atividades práticas como escovar dentes, amarrar sapatos\n\n💭 **Psicoterapia:**\nAjuda com sentimentos e emoções\n\n🎵 **Outras opções:**\nMusicoterapia, equoterapia, natação...\n\n✨ **O segredo:** Cada pessoa precisa de um "mix" diferente de terapias. O importante é começar cedo e ser consistente!';
    }
    
    // Educação - Mais esperançoso
    if (msg.contains('escola') || msg.contains('educação') || msg.contains('inclusão') || msg.contains('estudar')) {
      return '🏫 **Escola e autismo - sim, é possível!**\n\n📚 **Seus direitos:**\n• Toda criança tem direito à educação\n• A escola deve se adaptar à criança\n• Apoio especializado quando necessário\n\n👩‍🏫 **Como funciona:**\n• Professor de apoio (se precisar)\n• Adaptações nas atividades\n• Ambiente mais tranquilo para provas\n• Comunicação constante família-escola\n\n💡 **Dicas importantes:**\n• Converse sempre com os professores\n• Explique as necessidades do seu filho\n• Celebre cada conquista, por menor que seja\n• Lembre-se: cada criança aprende no seu tempo\n\n🌟 Muitas crianças com autismo se dão super bem na escola!';
    }
    
    // Família - Mais acolhedor e prático
    if (msg.contains('família') || msg.contains('pais') || msg.contains('como ajudar') || msg.contains('mãe') || msg.contains('pai')) {
      return '👨‍👩‍👧‍👦 **Para famílias - vocês são incríveis!**\n\n💙 **Primeiros passos:**\n• Aceite que seu filho é perfeito do jeito que é\n• Aprenda sobre autismo, mas lembre-se: seu filho é único\n• Conecte-se com outras famílias\n\n🏠 **No dia a dia:**\n• Crie rotinas previsíveis (café da manhã, banho, dormir)\n• Use comunicação visual (desenhos, fotos)\n• Celebre pequenas conquistas\n• Tenha paciência - desenvolvimento leva tempo\n\n🤝 **Cuidando de você:**\n• Peça ajuda quando precisar\n• Reserve tempo para si mesmo\n• Não se compare com outras famílias\n• Confie no seu instinto de pai/mãe\n\n🌟 Você conhece seu filho melhor que ninguém!';
    }
    
    // Comportamentos - Mais empático
    if (msg.contains('comportamento') || msg.contains('crise') || msg.contains('birra') || msg.contains('agressivo')) {
      return '🧘‍♀️ **Entendendo comportamentos difíceis:**\n\nPrimeiro: comportamentos "difíceis" são formas de comunicação!\n\n🔍 **Por que acontece:**\n• Sobrecarga sensorial (muito barulho, luz)\n• Mudança na rotina\n• Frustração por não conseguir se expressar\n• Cansaço ou fome\n\n😌 **O que fazer:**\n• Mantenha a calma (respire fundo!)\n• Tente identificar o que causou\n• Ofereça um ambiente mais calmo\n• Use poucas palavras, tom suave\n• Dê tempo para a pessoa se acalmar\n\n💡 **Prevenção:**\n• Mantenha rotinas\n• Avise sobre mudanças com antecedência\n• Ensine formas de pedir ajuda\n\n🤗 Lembre-se: não é birra, é comunicação!';
    }
    
    // Direitos - Mais empoderador
    if (msg.contains('direito') || msg.contains('lei') || msg.contains('benefício') || msg.contains('gratuito')) {
      return '⚖️ **Seus direitos - conheça e use!**\n\n🎫 **Prioridade em filas e atendimentos**\n(Cartão de identificação da pessoa com TEA)\n\n🚌 **Transporte gratuito**\n(Passe livre intermunicipal)\n\n💰 **BPC - Benefício de Prestação Continuada**\n(1 salário mínimo mensal)\n\n🏥 **Atendimento de saúde especializado**\n(Pelo SUS, sem fila de espera)\n\n🏫 **Educação inclusiva garantida**\n(Professor de apoio quando necessário)\n\n💼 **Cotas no mercado de trabalho**\n(Para jovens e adultos)\n\n📋 **Base legal:** Lei 12.764/2012 (Lei Berenice Piana)\n\n💪 Não tenha vergonha de usar seus direitos!';
    }
    
    // Desenvolvimento - Mais motivador
    if (msg.contains('desenvolvimento') || msg.contains('habilidade') || msg.contains('progresso') || msg.contains('melhora')) {
      return '🌱 **Desenvolvimento no autismo - cada conquista importa!**\n\n🧠 **A verdade:**\n• Cada pessoa tem seu próprio ritmo\n• Desenvolvimento pode acontecer a vida toda\n• Pequenos passos são grandes vitórias\n\n💪 **Foque nas potencialidades:**\n• Memória incrível para detalhes\n• Honestidade e lealdade\n• Talentos especiais em áreas específicas\n• Forma única de ver o mundo\n\n🎯 **Como estimular:**\n• Use os interesses da pessoa como ponte\n• Ensine habilidades sociais de forma prática\n• Trabalhe comunicação todos os dias\n• Crie oportunidades de interação\n\n⏰ **Tenha paciência:**\n• Progressos podem ser lentos, mas são reais\n• Às vezes há retrocessos - é normal\n• Cada pessoa tem seu tempo\n\n✨ Acredite no potencial - ele existe!';
    }
    
    // Resposta padrão mais acolhedora
    return '🤗 Entendi que você quer saber mais sobre autismo! Estou aqui para te ajudar de forma prática e acolhedora.\n\n💡 **Posso te ajudar com:**\n• Como identificar sinais\n• Processo de diagnóstico\n• Terapias que funcionam\n• Dicas para escola\n• Apoio para família\n• Direitos e benefícios\n• Desenvolvimento e habilidades\n\n🗣️ **Dica:** Seja mais específico na sua pergunta! Por exemplo:\n"Como saber se meu filho tem autismo?"\n"Que terapias ajudam?"\n"Como lidar com crises?"\n\n📚 Também temos artigos completos no Feed Educativo!';
  }
}