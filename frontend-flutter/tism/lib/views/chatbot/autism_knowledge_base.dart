class AutismKnowledgeBase {
  static const Map<String, Map<String, dynamic>> _knowledge = {
    'definicao': {
      'keywords': ['o que é', 'que é', 'definição', 'conceito', 'autismo', 'tea'],
      'response': '🧠 **TEA (Transtorno do Espectro Autista)**\n\nÉ uma condição neurológica que afeta:\n• **Comunicação** - verbal e não-verbal\n• **Interação social** - relacionamentos\n• **Comportamentos** - padrões repetitivos\n\n💙 Não é doença - é uma forma diferente de processar o mundo!',
      'follow_up': ['sintomas', 'diagnostico', 'causas']
    },
    
    'sintomas_precoces': {
      'keywords': ['sintomas', 'sinais', 'identificar', 'como saber', 'primeiros sinais', 'bebê', 'criança pequena'],
      'response': '👶 **Sinais Precoces (0-3 anos)**\n\n**Comunicação:**\n• Pouco contato visual\n• Não responde ao nome\n• Atraso na fala ou perda de palavras\n• Não aponta para mostrar interesse\n\n**Social:**\n• Não sorri socialmente\n• Prefere brincar sozinho\n• Não imita gestos\n\n**Comportamento:**\n• Movimentos repetitivos\n• Fixação em objetos\n• Resistência a mudanças\n\n⚠️ **Importante:** Apenas profissionais podem diagnosticar!',
      'follow_up': ['diagnostico', 'profissionais', 'quando_procurar']
    },
    
    'sintomas_escolares': {
      'keywords': ['escola', 'sintomas escola', 'professor', 'sala de aula', 'escolar'],
      'response': '🏫 **Sinais na Escola**\n\n**Para Professores:**\n• Dificuldade em seguir instruções complexas\n• Evita atividades em grupo\n• Comportamentos repetitivos\n• Sensibilidade a ruídos/luzes\n• Interesses muito específicos\n• Dificuldade com mudanças na rotina\n\n**Estratégias:**\n• Use comunicação visual\n• Mantenha rotinas previsíveis\n• Ofereça pausas sensoriais\n• Valorize os pontos fortes\n\n📚 Cada criança é única!',
      'follow_up': ['inclusao_escolar', 'estrategias_ensino', 'direitos_escola']
    },
    
    'diagnostico': {
      'keywords': ['diagnóstico', 'médico', 'profissional', 'como diagnosticar', 'exames'],
      'response': '🏥 **Diagnóstico do TEA**\n\n**Profissionais:**\n• Neuropediatra\n• Psiquiatra infantil\n• Psicólogo especializado\n• Equipe multidisciplinar\n\n**Processo:**\n• Entrevista com família\n• Observação comportamental\n• Escalas padronizadas (CARS, ADI-R, ADOS)\n• Histórico do desenvolvimento\n\n**Idade:** Pode ser feito a partir dos 18 meses\n\n⏰ **Diagnóstico precoce = intervenção mais eficaz!**',
      'follow_up': ['terapias', 'intervencao_precoce', 'onde_buscar_ajuda']
    },
    
    'terapias': {
      'keywords': ['terapia', 'tratamento', 'aba', 'intervenção', 'ajuda', 'como tratar'],
      'response': '🎯 **Principais Terapias**\n\n**ABA (Análise do Comportamento Aplicada):**\n• Ensina habilidades práticas\n• Reduz comportamentos inadequados\n• Baseada em evidências científicas\n\n**Fonoaudiologia:**\n• Desenvolve comunicação\n• Trabalha linguagem verbal/não-verbal\n\n**Terapia Ocupacional:**\n• Atividades da vida diária\n• Integração sensorial\n\n**Psicoterapia:**\n• Regulação emocional\n• Habilidades sociais\n\n**Outras:** Musicoterapia, equoterapia, natação\n\n✨ **Cada pessoa precisa de um plano individualizado!**',
      'follow_up': ['aba_detalhes', 'fonoaudiologia', 'terapia_ocupacional']
    },
    
    'comportamentos_dificeis': {
      'keywords': ['crise', 'birra', 'agressivo', 'comportamento difícil', 'meltdown', 'autolesão'],
      'response': '🧘‍♀️ **Comportamentos Desafiadores**\n\n**Possíveis Causas:**\n• Sobrecarga sensorial\n• Mudança na rotina\n• Frustração/comunicação\n• Fome, sono, dor\n• Ansiedade\n\n**Como Ajudar:**\n• Mantenha-se calmo\n• Identifique o gatilho\n• Reduza estímulos\n• Use poucas palavras, tom suave\n• Ofereça alternativas\n• Valide os sentimentos\n\n**Prevenção:**\n• Rotinas previsíveis\n• Comunicação visual\n• Pausas regulares\n• Ambiente organizado\n\n💙 **Não é birra - é comunicação!**',
      'follow_up': ['estrategias_comportamento', 'sobrecarga_sensorial', 'rotinas']
    },
    
    'familia_apoio': {
      'keywords': ['família', 'pais', 'mãe', 'pai', 'como ajudar família', 'apoio'],
      'response': '👨‍👩‍👧‍👦 **Apoio à Família**\n\n**Para Pais:**\n• Aceite seu filho como ele é\n• Celebre pequenas conquistas\n• Busque informação confiável\n• Conecte-se com outras famílias\n• Cuide da sua saúde mental\n\n**Estratégias Práticas:**\n• Crie rotinas visuais\n• Use interesses da criança\n• Tenha paciência com o desenvolvimento\n• Documente progressos\n\n**Rede de Apoio:**\n• Grupos de pais\n• Associações de autismo\n• Terapeutas\n• Escola\n\n💪 **Você conhece seu filho melhor que ninguém!**',
      'follow_up': ['grupos_apoio', 'autocuidado_pais', 'irmãos_autismo']
    },
    
    'direitos': {
      'keywords': ['direitos', 'lei', 'benefício', 'gratuito', 'bpc', 'carteirinha'],
      'response': '⚖️ **Direitos da Pessoa com TEA**\n\n**Lei 12.764/2012 (Berenice Piana):**\n• Pessoa com deficiência para todos os efeitos legais\n\n**Principais Direitos:**\n• 🎫 Prioridade em filas e atendimentos\n• 🚌 Transporte público gratuito\n• 💰 BPC - Benefício de 1 salário mínimo\n• 🏥 Atendimento especializado no SUS\n• 🏫 Educação inclusiva\n• 💼 Cotas no mercado de trabalho\n• 🎭 Meia-entrada em eventos\n\n**Documentos:**\n• Carteirinha de identificação\n• Laudo médico\n• CID F84\n\n📋 **Use seus direitos!**',
      'follow_up': ['bpc_como_solicitar', 'carteirinha_autismo', 'direitos_escola']
    },
    
    'inclusao_escolar': {
      'keywords': ['inclusão', 'escola inclusiva', 'professor apoio', 'adaptação escolar'],
      'response': '🏫 **Inclusão Escolar**\n\n**Direitos Garantidos:**\n• Matrícula em escola regular\n• Professor de apoio (se necessário)\n• Adaptações curriculares\n• Ambiente acessível\n\n**Estratégias para Professores:**\n• Comunicação visual (pictogramas)\n• Rotinas estruturadas\n• Pausas sensoriais\n• Atividades baseadas em interesses\n• Parceria com família\n\n**Adaptações:**\n• Tempo extra para atividades\n• Avaliações diferenciadas\n• Espaço para autorregulação\n• Redução de estímulos\n\n🌟 **Inclusão beneficia toda a turma!**',
      'follow_up': ['pei_plano', 'professor_apoio', 'adaptacoes_curriculares']
    },
    
    'desenvolvimento': {
      'keywords': ['desenvolvimento', 'habilidades', 'progresso', 'melhora', 'evolução'],
      'response': '🌱 **Desenvolvimento no TEA**\n\n**Características:**\n• Cada pessoa tem seu ritmo\n• Desenvolvimento pode ser irregular\n• Pontos fortes e desafios únicos\n• Potencial para crescimento sempre existe\n\n**Áreas de Foco:**\n• Comunicação funcional\n• Habilidades sociais\n• Autonomia pessoal\n• Regulação emocional\n• Interesses e talentos\n\n**Dicas:**\n• Use os interesses como ponte\n• Celebre pequenos progressos\n• Mantenha expectativas realistas\n• Foque nas potencialidades\n\n✨ **Pequenos passos são grandes vitórias!**',
      'follow_up': ['marcos_desenvolvimento', 'potencialidades', 'autonomia']
    }
  };

  static const Map<String, String> _quickResponses = {
    'oi': '👋 Oi! Sou especialista em TEA. Como posso ajudar hoje?',
    'obrigado': '😊 Por nada! Sempre aqui para ajudar. Cada pessoa com autismo é especial!',
    'tchau': '👋 Até logo! Lembre-se: você não está sozinho nessa jornada!',
    'ajuda': '💡 Posso ajudar com: sintomas, diagnóstico, terapias, escola, família, direitos e desenvolvimento. Seja específico!'
  };

  static String? findResponse(String message) {
    final msg = message.toLowerCase().trim();
    
    // Respostas rápidas
    for (final entry in _quickResponses.entries) {
      if (msg.contains(entry.key)) {
        return entry.value;
      }
    }
    
    // Busca na base de conhecimento
    for (final entry in _knowledge.entries) {
      final keywords = entry.value['keywords'] as List<String>;
      for (final keyword in keywords) {
        if (msg.contains(keyword.toLowerCase())) {
          return entry.value['response'] as String;
        }
      }
    }
    
    return null;
  }
  
  static List<String> getFollowUpSuggestions(String message) {
    final msg = message.toLowerCase().trim();
    
    for (final entry in _knowledge.entries) {
      final keywords = entry.value['keywords'] as List<String>;
      for (final keyword in keywords) {
        if (msg.contains(keyword.toLowerCase())) {
          return List<String>.from(entry.value['follow_up'] ?? []);
        }
      }
    }
    
    return [];
  }
  
  static String getDefaultResponse() {
    return '🤖 **Posso ajudar com:**\n\n• 🔍 Sintomas e identificação\n• 🏥 Diagnóstico\n• 🎯 Terapias e tratamentos\n• 🏫 Escola e inclusão\n• 👨‍👩‍👧‍👦 Apoio à família\n• ⚖️ Direitos\n• 🌱 Desenvolvimento\n\n💡 **Seja específico:** "Como identificar autismo?" ou "Que terapias funcionam?"\n\n📚 **Veja também o Feed Educativo para mais conteúdo!**';
  }
}