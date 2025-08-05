# Chatbot TEA Otimizado 🤖💙

## Características Principais

### 🧠 Base de Conhecimento Especializada
- **10 categorias principais** sobre autismo
- Respostas específicas para **pais e professores**
- Linguagem acessível para **leigos e especialistas**
- Cobertura completa: sintomas, diagnóstico, terapias, escola, família, direitos

### 🚀 Otimizações de Memória
- **Cache inteligente** com limite de 20 respostas
- **Histórico limitado** a 50 mensagens
- **Singleton pattern** para economizar RAM
- **Lazy loading** de respostas
- Ideal para **smartphones básicos**

### 💡 Funcionalidades Inteligentes
- **Sugestões rápidas** para facilitar uso
- **Respostas contextuais** baseadas em palavras-chave
- **Fallback offline** - funciona sem internet
- **Interface otimizada** com scroll automático

## Cenários de Uso

### Para Pais 👨‍👩‍👧‍👦
- "Meu filho não fala, pode ser autismo?"
- "Como lidar com crises?"
- "Que direitos temos?"
- "Como conseguir terapias?"

### Para Professores 🏫
- "Como identificar sinais na escola?"
- "Estratégias para inclusão"
- "Como adaptar atividades?"
- "Comunicação com família"

### Para Iniciantes 🔍
- "O que é autismo?"
- "Primeiros sintomas"
- "Onde buscar ajuda?"
- "É hereditário?"

## Arquitetura Técnica

```
chatbot/
├── autism_knowledge_base.dart    # Base de conhecimento estruturada
├── memory_optimized_cache.dart   # Sistema de cache eficiente
├── chatbot_service.dart         # Serviço principal
├── chat_screen.dart            # Interface do usuário
├── quick_suggestions.dart      # Sugestões rápidas
└── README.md                  # Esta documentação
```

## Consumo de Memória

- **Base de conhecimento**: ~15KB em memória
- **Cache**: Máximo 20 respostas (~5KB)
- **Histórico**: Máximo 50 mensagens (~10KB)
- **Total estimado**: ~30KB de RAM

## Palavras-chave Reconhecidas

### Identificação
- sintomas, sinais, identificar, como saber, primeiros sinais

### Diagnóstico  
- diagnóstico, médico, profissional, exames

### Terapias
- terapia, tratamento, aba, intervenção, ajuda

### Escola
- escola, educação, inclusão, professor, sala de aula

### Família
- família, pais, mãe, pai, como ajudar

### Comportamento
- crise, birra, agressivo, comportamento difícil, meltdown

### Direitos
- direitos, lei, benefício, gratuito, bpc

### Desenvolvimento
- desenvolvimento, habilidades, progresso, melhora

## Melhorias Implementadas

✅ **Respostas mais completas e estruturadas**
✅ **Cache para reduzir latência**  
✅ **Limite de memória para dispositivos básicos**
✅ **Sugestões rápidas para facilitar uso**
✅ **Interface mais amigável e responsiva**
✅ **Informações específicas por público-alvo**
✅ **Fallback offline robusto**
✅ **Scroll automático e UX melhorada**

## Como Usar

1. **Seja específico**: "Meu filho de 3 anos não fala" em vez de "autismo"
2. **Use exemplos práticos**: "Como lidar com birras na escola?"
3. **Aproveite as sugestões**: Toque nos chips de sugestão rápida
4. **Explore tópicos**: Cada resposta sugere temas relacionados

O chatbot foi projetado para ser **eficiente, acessível e útil** tanto para famílias quanto para educadores, funcionando bem mesmo em dispositivos com recursos limitados.