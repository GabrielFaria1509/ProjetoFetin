class AutismKnowledgeBase {
  static final Map<String, String> _responseCache = <String, String>{};
  static const int _maxCacheSize = 20;
  
  static const Map<String, Map<String, dynamic>> _knowledge = {
    'definicao': {
      'keywords': ['o que é', 'que é', 'definição', 'conceito', 'autismo', 'tea', 'o que é autismo', 'o que é tea', 'defina autismo', 'explique autismo'],
      'response': '**TEA (Transtorno do Espectro Autista)**\n\nÉ uma condição neurológica que afeta:\n• Comunicação verbal e não-verbal\n• Interação social e relacionamentos\n• Comportamentos com padrões repetitivos\n\nNão é doença - é uma forma diferente de processar o mundo.',
      'follow_up': ['sintomas', 'diagnostico', 'causas']
    },
    
    'sintomas_precoces': {
      'keywords': ['sintomas', 'sinais', 'identificar', 'como saber', 'primeiros sinais', 'bebê', 'criança pequena', 'sintoma', 'sinal', 'como identificar', 'quais sintomas', 'que sintomas', 'tem sintomas', 'apresenta sintomas'],
      'response': '**Sinais Precoces do TEA (0-3 anos)**\n\n**Comunicação:**\n• Contato visual limitado - evita olhar nos olhos\n• Não responde ao nome quando chamado\n• Atraso na fala - não fala palavras aos 12 meses\n• Não aponta para mostrar interesse\n• Perda de habilidades já adquiridas\n\n**Interação Social:**\n• Sorriso social ausente aos 6 meses\n• Preferência por brincar sozinho\n• Não imita gestos simples\n• Dificuldade com demonstrações de afeto\n\n**Comportamentos:**\n• Movimentos repetitivos (balançar, bater palmas)\n• Fixação em objetos específicos\n• Resistência a mudanças na rotina\n• Sensibilidades sensoriais extremas\n\n**Marcos de Desenvolvimento:**\n• 6 meses: sorriso social\n• 12 meses: apontar e gestos\n• 18 meses: 6 palavras mínimo\n• 24 meses: combinar 2 palavras\n\n**Importante:** Cada criança tem seu ritmo, mas múltiplos sinais indicam necessidade de avaliação profissional.',
      'follow_up': ['diagnostico', 'profissionais', 'quando_procurar']
    },
    
    'sintomas_escolares': {
      'keywords': ['escola', 'sintomas escola', 'professor', 'sala de aula', 'escolar', 'na escola', 'sintomas na escola', 'sinais na escola', 'comportamento escola'],
      'response': '**Sinais na Escola**\n\n**Para Professores:**\n• Dificuldade em seguir instruções complexas\n• Evita atividades em grupo\n• Comportamentos repetitivos\n• Sensibilidade a ruídos/luzes\n• Interesses muito específicos\n• Dificuldade com mudanças na rotina\n\n**Estratégias:**\n• Use comunicação visual\n• Mantenha rotinas previsíveis\n• Ofereça pausas sensoriais\n• Valorize os pontos fortes\n\nCada criança é única!',
      'follow_up': ['inclusao_escolar', 'estrategias_ensino', 'direitos_escola']
    },
    
    'sintomas_mais_velhos': {
      'keywords': ['filho mais velho', 'criança mais velha', 'sintomas mais velho', 'mais velho', 'idade escolar', '6 anos', '7 anos', '8 anos', '9 anos', '10 anos', 'sintomas filho mais velho', 'criança grande', 'filho grande', 'adolescente', 'pré-adolescente'],
      'response': '**Sintomas em Crianças Mais Velhas (6+ anos)**\n\n**Comunicação:**\n• Linguagem literal, não entende ironias\n• Dificuldade em conversas recíprocas\n• Repete frases ou palavras\n• Voz monótona ou diferente\n\n**Social:**\n• Dificuldade para fazer amigos\n• Não entende regras sociais\n• Prefere brincar sozinho\n• Não compartilha interesses\n\n**Comportamento:**\n• Rotinas rígidas\n• Interesses obsessivos\n• Movimentos repetitivos\n• Resistência a mudanças\n\n**Na Escola:**\n• Dificuldade de concentração\n• Problemas com trabalhos em grupo\n• Sensibilidade sensorial\n\nProcure avaliação profissional!',
      'follow_up': ['diagnostico', 'escola', 'terapias']
    },
    
    'diagnostico': {
      'keywords': ['diagnóstico', 'médico', 'profissional', 'como diagnosticar', 'exames'],
      'response': '**Diagnóstico do TEA - Processo Completo**\n\n**Profissionais Qualificados:**\n• Neuropediatra - especialista em desenvolvimento neurológico\n• Psiquiatra infantil - foco em saúde mental da criança\n• Psicólogo especializado - formação em TEA\n• Equipe multidisciplinar - fono, TO, psicopedagogo\n\n**Processo Diagnóstico:**\n• Anamnese detalhada - histórico familiar e desenvolvimento\n• Observação clínica - comportamento em diferentes situações\n• Escalas padronizadas: CARS, ADI-R, ADOS\n• Avaliação do desenvolvimento - marcos motores e cognitivos\n• Exames complementares quando necessário\n\n**Linha do Tempo:**\n• 18 meses: idade mínima para diagnóstico confiável\n• 2-3 anos: período ideal para identificação\n• Qualquer idade: nunca é tarde para buscar avaliação\n\n**O que Levar na Consulta:**\n• Caderneta de vacinação\n• Relatórios escolares\n• Vídeos do comportamento da criança\n• Lista de preocupações observadas\n\n**Por que o diagnóstico precoce é crucial:**\n• Permite intervenções mais eficazes\n• Melhora prognóstico de desenvolvimento\n• Facilita adaptações escolares\n• Orienta a família adequadamente',
      'follow_up': ['terapias', 'intervencao_precoce', 'onde_buscar_ajuda']
    },
    
    'terapias': {
      'keywords': ['terapia', 'tratamento', 'aba', 'intervenção', 'ajuda', 'como tratar'],
      'response': '**Terapias Baseadas em Evidências para TEA**\n\n**ABA (Análise do Comportamento Aplicada):**\n• Método científico com reforço positivo\n• Quebra habilidades complexas em passos pequenos\n• Melhora comunicação, comportamento social, autonomia\n• Intensidade: 20-40 horas semanais para melhores resultados\n• Idade ideal: quanto mais cedo, melhor (2-6 anos)\n\n**Fonoaudiologia:**\n• Desenvolvimento da fala e linguagem\n• Comunicação alternativa: PECS, gestos, dispositivos\n• Uso social da linguagem e conversação\n• Problemas alimentares e seletividade\n\n**Terapia Ocupacional:**\n• Integração sensorial - processamento de estímulos\n• Atividades diárias: vestir, comer, higiene\n• Coordenação motora fina e grossa\n• Técnicas para autorregulação emocional\n\n**Psicoterapia:**\n• Terapia Cognitivo-Comportamental para ansiedade\n• Desenvolvimento de habilidades sociais\n• Regulação emocional - reconhecer sentimentos\n• Apoio e orientação familiar\n\n**Terapias Complementares:**\n• Musicoterapia - desenvolvimento social e emocional\n• Equoterapia - equilíbrio, coordenação e autoestima\n• Natação - exercício físico e relaxamento\n• Arteterapia - expressão criativa\n\n**Plano Individualizado:**\nCada pessoa com TEA é única. Considere:\n• Nível de funcionamento\n• Idade e interesses\n• Necessidades específicas\n• Recursos familiares\n\nCombine diferentes terapias para melhores resultados.',
      'follow_up': ['aba_detalhes', 'fonoaudiologia', 'terapia_ocupacional']
    },
    
    'comportamentos_dificeis': {
      'keywords': ['crise', 'birra', 'agressivo', 'comportamento difícil', 'meltdown', 'autolesão'],
      'response': '**Comportamentos Desafiadores**\n\n**Possíveis Causas:**\n• Sobrecarga sensorial\n• Mudança na rotina\n• Frustração/comunicação\n• Fome, sono, dor\n• Ansiedade\n\n**Como Ajudar:**\n• Mantenha-se calmo\n• Identifique o gatilho\n• Reduza estímulos\n• Use poucas palavras, tom suave\n• Ofereça alternativas\n• Valide os sentimentos\n\n**Prevenção:**\n• Rotinas previsíveis\n• Comunicação visual\n• Pausas regulares\n• Ambiente organizado\n\nNão é birra - é comunicação!',
      'follow_up': ['estrategias_comportamento', 'sobrecarga_sensorial', 'rotinas']
    },
    
    'familia_apoio': {
      'keywords': ['família', 'pais', 'mãe', 'pai', 'como ajudar família', 'apoio'],
      'response': '**Apoio à Família**\n\n**Para Pais:**\n• Aceite seu filho como ele é\n• Celebre pequenas conquistas\n• Busque informação confiável\n• Conecte-se com outras famílias\n• Cuide da sua saúde mental\n\n**Estratégias Práticas:**\n• Crie rotinas visuais\n• Use interesses da criança\n• Tenha paciência com o desenvolvimento\n• Documente progressos\n\n**Rede de Apoio:**\n• Grupos de pais\n• Associações de autismo\n• Terapeutas\n• Escola\n\nVocê conhece seu filho melhor que ninguém!',
      'follow_up': ['grupos_apoio', 'autocuidado_pais', 'irmãos_autismo']
    },
    
    'direitos': {
      'keywords': ['direitos', 'lei', 'benefício', 'gratuito', 'bpc', 'carteirinha'],
      'response': '**Direitos da Pessoa com TEA**\n\n**Lei 12.764/2012 (Berenice Piana):**\nPessoa com deficiência para todos os efeitos legais\n\n**Principais Direitos:**\n• Prioridade em filas e atendimentos\n• Transporte público gratuito\n• BPC - Benefício de 1 salário mínimo\n• Atendimento especializado no SUS\n• Educação inclusiva\n• Cotas no mercado de trabalho\n• Meia-entrada em eventos\n\n**Documentos:**\n• Carteirinha de identificação\n• Laudo médico\n• CID F84\n\nUse seus direitos!',
      'follow_up': ['bpc_como_solicitar', 'carteirinha_autismo', 'direitos_escola']
    },
    
    'inclusao_escolar': {
      'keywords': ['inclusão', 'escola inclusiva', 'professor apoio', 'adaptação escolar'],
      'response': '**Inclusão Escolar**\n\n**Direitos Garantidos:**\n• Matrícula em escola regular\n• Professor de apoio (se necessário)\n• Adaptações curriculares\n• Ambiente acessível\n\n**Estratégias para Professores:**\n• Comunicação visual (pictogramas)\n• Rotinas estruturadas\n• Pausas sensoriais\n• Atividades baseadas em interesses\n• Parceria com família\n\n**Adaptações:**\n• Tempo extra para atividades\n• Avaliações diferenciadas\n• Espaço para autorregulação\n• Redução de estímulos\n\nInclusão beneficia toda a turma!',
      'follow_up': ['pei_plano', 'professor_apoio', 'adaptacoes_curriculares']
    },
    
    'comunicacao': {
      'keywords': ['comunicação', 'fala', 'linguagem', 'não fala', 'verbal', 'pecs'],
      'response': '**Comunicação no TEA**\n\n**Formas de Comunicação:**\n• Verbal: palavras, frases\n• Não-verbal: gestos, expressões\n• Visual: figuras, pictogramas\n• Tecnológica: tablets, apps\n\n**Estratégias:**\n• PECS (troca de figuras)\n• Libras ou gestos\n• Comunicação aumentativa\n• Rotinas visuais\n• Histórias sociais\n\n**Dicas Práticas:**\n• Dê tempo para resposta\n• Use linguagem simples\n• Seja paciente e consistente\n\nToda comunicação é válida!',
      'follow_up': ['pecs', 'apps_comunicacao', 'fonoaudiologia']
    },
    
    'sensorial': {
      'keywords': ['sensorial', 'hipersensibilidade', 'hiposensibilidade', 'ruído', 'textura', 'luz'],
      'response': '**Questões Sensoriais**\n\n**Hipersensibilidade (muito sensível):**\n• Evita ruídos, luzes fortes\n• Não gosta de certas texturas\n• Incomoda-se com multidões\n• Rejeita alguns alimentos\n\n**Hiposensibilidade (pouco sensível):**\n• Busca estímulos intensos\n• Não sente dor/temperatura\n• Precisa de mais input sensorial\n\n**Estratégias:**\n• Identifique os gatilhos\n• Crie espaços calmos\n• Use fones de ouvido\n• Ofereça alternativas táteis\n• Gradual exposição\n\nTerapia ocupacional ajuda muito!',
      'follow_up': ['terapia_ocupacional', 'dieta_sensorial', 'ambiente_sensorial']
    },
    
    'alimentacao': {
      'keywords': ['alimentação', 'comida', 'seletividade', 'não come', 'textura alimento'],
      'response': '**Alimentação no TEA**\n\n**Seletividade Alimentar:**\n• Comum em 70% das crianças\n• Preferências por textura/cor\n• Resistência a novos alimentos\n• Rituais na hora da refeição\n\n**Estratégias:**\n• Introdução gradual\n• Misture alimentos aceitos\n• Deixe explorar sem pressão\n• Modelo (coma junto)\n• Ambiente calmo\n• Horários regulares\n\n**Quando Buscar Ajuda:**\n• Perda de peso\n• Deficiências nutricionais\n• Menos de 20 alimentos aceitos\n\nPaciência e persistência!',
      'follow_up': ['nutricionista', 'suplementos', 'receitas_sensoriais']
    },
    
    'sono': {
      'keywords': ['sono', 'dormir', 'insônia', 'não dorme', 'acordar noite'],
      'response': '**Sono no TEA**\n\n**Problemas Comuns:**\n• Dificuldade para adormecer\n• Despertares noturnos\n• Sono fragmentado\n• Resistência à hora de dormir\n\n**Higiene do Sono:**\n• Rotina consistente\n• Ambiente escuro e silencioso\n• Temperatura agradável\n• Evite telas 1h antes\n• Atividade física durante o dia\n\n**Estratégias:**\n• História visual da rotina\n• Música relaxante\n• Massagem suave\n• Objetos de transição\n• Melatonina (com orientação médica)\n\nSono de qualidade melhora tudo!',
      'follow_up': ['rotina_sono', 'melatonina', 'ambiente_dormir']
    },
    
    'tecnologia': {
      'keywords': ['app', 'tecnologia', 'tablet', 'aplicativo', 'digital'],
      'response': '**Tecnologia e TEA**\n\n**Benefícios:**\n• Comunicação aumentativa\n• Aprendizado visual\n• Organização de rotinas\n• Habilidades sociais\n• Autorregulação\n\n**Apps Úteis:**\n• Comunicação: Proloquo2Go, PECS\n• Rotinas: Choiceworks, First Then\n• Habilidades Sociais: Social Stories\n• Relaxamento: Calm, Headspace\n• Educação: Khan Academy Kids\n\n**Dicas de Uso:**\n• Tempo limitado\n• Conteúdo apropriado\n• Supervisão adulta\n• Equilíbrio com atividades offline\n\nFerramenta, não substituto da interação!',
      'follow_up': ['apps_comunicacao', 'tempo_tela', 'jogos_educativos']
    },
    
    'casos_praticos': {
      'keywords': ['meu filho', 'minha filha', 'criança', 'o que fazer', 'estou preocupado', 'não sei o que fazer', 'preciso de ajuda'],
      'response': '**Situações Práticas**\n\n**Se você suspeita de TEA:**\n• Observe sem julgar\n• Anote comportamentos específicos\n• Procure pediatra ou neuropediatra\n• Não compare com outras crianças\n\n**Primeiros Passos:**\n1. Consulta médica especializada\n2. Avaliação multidisciplinar\n3. Início de terapias (se indicado)\n4. Apoio à família\n\n**Lembre-se:**\n• Cada criança é única\n• Diagnóstico precoce ajuda\n• Você não está sozinho\n• Há muito apoio disponível\n\nO amor e aceitação são fundamentais!',
      'follow_up': ['diagnostico', 'primeiros_passos', 'apoio_familia']
    },
    
    'emergencia': {
      'keywords': ['crise agora', 'emergência', 'não para de chorar', 'agressivo agora', 'socorro', 'urgente ajuda'],
      'response': '**Situação de Crise - Ação Imediata**\n\n**AGORA:**\n• Mantenha-se calmo\n• Reduza estímulos (luz, som)\n• Fale baixo e devagar\n• Não force contato físico\n• Ofereça espaço seguro\n\n**NÃO FAÇA:**\n• Não grite ou se desespere\n• Não force a parar\n• Não dê ordens complexas\n• Não toque sem permissão\n\n**DEPOIS DA CRISE:**\n• Ofereça conforto\n• Hidrate a criança\n• Analise possíveis gatilhos\n• Documente o ocorrido\n\n**Se houver risco físico, procure ajuda médica imediata!**\n\nCrises passam. Você consegue!',
      'follow_up': ['comportamentos_dificeis', 'estrategias_crise', 'apoio_emergencial']
    },
    
    'recursos_gratuitos': {
      'keywords': ['gratuito', 'sem dinheiro', 'não tenho condições', 'sus', 'público', 'barato'],
      'response': '**Recursos Gratuitos Disponíveis**\n\n**SUS - Sistema Único de Saúde:**\n• Consultas especializadas\n• Terapias (ABA, fono, TO)\n• Medicamentos\n• Acompanhamento multidisciplinar\n\n**APAE - Associação de Pais e Amigos:**\n• Atendimento especializado\n• Terapias\n• Orientação familiar\n• Atividades educativas\n\n**Universidades:**\n• Clínicas-escola\n• Atendimento supervisionado\n• Pesquisas e estudos\n\n**ONGs e Associações:**\n• Grupos de apoio\n• Orientação gratuita\n• Eventos educativos\n• Rede de contatos\n\nProcure a Secretaria de Saúde da sua cidade!',
      'follow_up': ['sus_como_acessar', 'apae_local', 'associacoes']
    }
  };

  static const Map<String, String> _quickResponses = {
    'oi': 'Oi! Sou especialista em TEA. Como posso ajudar hoje?',
    'olá': 'Olá! Estou aqui para esclarecer suas dúvidas sobre autismo.',
    'bom dia': 'Bom dia! Pronto para ajudar com informações sobre TEA.',
    'boa tarde': 'Boa tarde! Como posso auxiliar sobre autismo hoje?',
    'boa noite': 'Boa noite! Estou disponível para suas perguntas sobre TEA.',
    'obrigado': 'Por nada! Sempre aqui para ajudar. Cada pessoa com autismo é especial!',
    'obrigada': 'Fico feliz em ajudar! Juntos construimos mais inclusão.',
    'tchau': 'Até logo! Lembre-se: você não está sozinho nessa jornada!',
    'até mais': 'Até mais! Estarei sempre aqui quando precisar.',
    'ajuda': 'Posso ajudar com: sintomas, diagnóstico, terapias, escola, família, direitos e desenvolvimento. Seja específico!',
    'não sei': 'Sem problemas! Me conte o que está acontecendo ou qual sua preocupação. Vamos descobrir juntos!',
    'estou perdido': 'Não se preocupe! É normal se sentir assim. Vamos começar pelo básico. O que você gostaria de saber?',
    'urgente': 'Se for emergência médica, procure ajuda imediata! Para dúvidas sobre TEA, estou aqui para ajudar.',
    'crise': 'Em situações de crise: mantenha calma, reduza estímulos, use voz suave. Precisa de mais orientações?',
    'sintomas': '**Sintomas do TEA por Faixa Etária:**\n\n• 0-3 anos: Pouco contato visual, não responde ao nome, atraso na fala\n• 3-6 anos: Dificuldades sociais, comportamentos repetitivos, resistência a mudanças\n• 6+ anos: Linguagem literal, interesses obsessivos, dificuldades de amizade\n• Adolescentes: Ansiedade social, dificuldades acadêmicas, isolamento\n\n**Importante:** Sintomas variam muito entre indivíduos. Alguns podem ser mais sutis.\n\nSobre qual idade você gostaria de saber mais detalhes?',
    'sinais': '**Principais Sinais do TEA (Tríade Clássica):**\n\n**1. Comunicação:**\n• Atraso ou ausência da fala\n• Dificuldade para iniciar/manter conversas\n• Uso repetitivo da linguagem (ecolalia)\n\n**2. Interação Social:**\n• Dificuldade em fazer amigos\n• Não compartilha interesses\n• Problemas com contato visual\n\n**3. Comportamentos Repetitivos:**\n• Movimentos estereotipados\n• Insistência em rotinas\n• Interesses restritos e intensos\n\n**Plus:** Sensibilidades sensoriais (hiper/hiposensibilidade)\n\nQuer detalhes sobre algum sinal específico?'
  };

  static String? findResponse(String message) {
    final msg = message.toLowerCase().trim();
    
    if (_responseCache.containsKey(msg)) {
      return _responseCache[msg];
    }
    
    for (final entry in _quickResponses.entries) {
      if (msg.contains(entry.key)) {
        _cacheResponse(msg, entry.value);
        return entry.value;
      }
    }
    
    String? bestMatch;
    int bestScore = 0;
    
    for (final entry in _knowledge.entries) {
      final keywords = entry.value['keywords'] as List<String>;
      int score = 0;
      
      for (final keyword in keywords) {
        final keywordLower = keyword.toLowerCase();
        if (msg.contains(keywordLower)) {
          if (msg == keywordLower) {
            score += 10;
          } else if (msg.startsWith(keywordLower) || msg.endsWith(keywordLower)) {
            score += 5;
          } else {
            score += 2;
          }
          score += keywordLower.split(' ').length;
        }
      }
      
      if (score > bestScore) {
        bestScore = score;
        bestMatch = entry.value['response'] as String;
      }
    }
    
    if (bestMatch != null) {
      _cacheResponse(msg, bestMatch);
    }
    
    return bestMatch;
  }
  
  static void _cacheResponse(String message, String response) {
    if (_responseCache.length >= _maxCacheSize) {
      final firstKey = _responseCache.keys.first;
      _responseCache.remove(firstKey);
    }
    _responseCache[message] = response;
  }
  
  static List<String> getFollowUpSuggestions(String message) {
    final msg = message.toLowerCase().trim();
    
    String? bestTopic;
    int maxMatches = 0;
    
    for (final entry in _knowledge.entries) {
      final keywords = entry.value['keywords'] as List<String>;
      int matches = 0;
      
      for (final keyword in keywords) {
        if (msg.contains(keyword.toLowerCase())) {
          matches++;
        }
      }
      
      if (matches > maxMatches) {
        maxMatches = matches;
        bestTopic = entry.key;
      }
    }
    
    if (bestTopic != null) {
      return List<String>.from(_knowledge[bestTopic]!['follow_up'] ?? []);
    }
    
    return ['Como identificar autismo?', 'Que terapias funcionam?', 'Direitos da pessoa com TEA'];
  }
  
  static String getDefaultResponse() {
    return '**Olá! Estou aqui para apoiar você nessa jornada.**\n\n**Posso ajudar com:**\n• Identificar sinais do TEA\n• Orientar sobre diagnóstico\n• Sugerir terapias eficazes\n• Apoiar a inclusão escolar\n• Esclarecer direitos\n• Oferecer suporte emocional\n\n**Seja específico:**\n• "Meu filho tem 3 anos e não fala"\n• "Como lidar com birras?"\n• "Preciso de ajuda gratuita"\n\nVocê não está sozinho(a). Vamos conversar?';
  }
  
  static void clearCache() {
    _responseCache.clear();
  }
  
  static List<String> getSmartSuggestions() {
    return [
      'Sinais de autismo por idade',
      'Meu filho não fala',
      'Como lidar com crises',
      'Terapias que funcionam',
      'Direitos na escola',
      'Ajuda gratuita disponível',
      'Problemas de sono',
      'Seletividade alimentar'
    ];
  }
  
  static void optimizeMemory() {
    if (_responseCache.length > _maxCacheSize ~/ 2) {
      final keysToRemove = _responseCache.keys.take(_responseCache.length ~/ 2).toList();
      for (final key in keysToRemove) {
        _responseCache.remove(key);
      }
    }
  }
}