# 🤖 Integração Gemini AI - TISM Chatbot

## 🚀 Configuração Rápida

### 1. Obter API Key (GRATUITA)
1. Acesse: https://aistudio.google.com/app/apikey
2. Faça login com sua conta Google
3. Clique em "Create API Key"
4. Copie a chave gerada

### 2. Configurar no App
1. Abra o arquivo `.env` na raiz do projeto Flutter
2. Substitua `your_gemini_api_key_here` pela sua chave:
```
GEMINI_API_KEY=AIzaSyC...sua_chave_aqui
```

### 3. Instalar Dependências
```bash
cd frontend-flutter/tism
flutter pub get
```

### 4. Executar o App
```bash
flutter run
```

## ✨ Funcionalidades

### 🧠 IA Híbrida Inteligente
- **Base Local**: 80+ tópicos especializados em TEA (resposta instantânea)
- **Gemini AI**: Respostas personalizadas para perguntas não catalogadas
- **Fallback**: Sistema robusto de recuperação de erros

### 🎯 Modelo Otimizado
- **Gemini 1.5 Flash 8B**: Modelo mais rápido e eficiente do free-tier
- **Configurações Otimizadas**: Temperature 0.7, TopK 40, TopP 0.95
- **Limite de Tokens**: 1024 tokens por resposta (ideal para mobile)

### 🛡️ Segurança e Filtros
- **Safety Settings**: Filtros automáticos de conteúdo inadequado
- **Validação de API**: Verificação automática de chave válida
- **Error Handling**: Tratamento robusto de erros de rede

### ⚡ Performance
- **Cache Inteligente**: Respostas frequentes ficam em cache
- **Priorização**: Base local primeiro, AI como backup
- **Otimização de Memória**: Limpeza automática de cache

## 🔧 Como Funciona

### Fluxo de Resposta
1. **Cache Check**: Verifica se já tem resposta em cache
2. **Base Local**: Busca nos 80+ tópicos especializados
3. **Gemini AI**: Se não encontrar, consulta a IA
4. **Fallback**: Em caso de erro, resposta padrão útil

### Prompt Especializado
O chatbot usa um prompt otimizado que instrui o Gemini a:
- Ser empático e acolhedor
- Usar linguagem clara e acessível
- Focar em evidências científicas
- Sugerir profissionais quando necessário
- Limitar respostas a 300 palavras
- Usar emojis moderadamente

## 💰 Custos (FREE TIER)

### Limites Gratuitos Gemini
- **15 RPM** (requests por minuto)
- **1 milhão de tokens por mês**
- **32k tokens por request**

### Estimativa de Uso
- **1 conversa** ≈ 100-200 tokens
- **Limite mensal** ≈ 5.000-10.000 conversas
- **Custo**: **GRATUITO** 🎉

## 🔒 Segurança

### Proteção da API Key
- ✅ Arquivo `.env` no `.gitignore`
- ✅ Não versionado no Git
- ✅ Carregamento seguro via `flutter_dotenv`
- ✅ Validação automática de chave

### Dados do Usuário
- ✅ Conversas não são armazenadas permanentemente
- ✅ Cache local apenas (não enviado para servidores)
- ✅ Conformidade com LGPD

## 🛠️ Troubleshooting

### Erro: "API key não configurada"
```bash
# Verifique se o arquivo .env existe e tem a chave correta
cat .env
```

### Erro: "Quota exceeded"
- Aguarde 1 minuto (limite de 15 RPM)
- Ou aguarde próximo mês (limite mensal)

### Erro de rede
- Verifique conexão com internet
- O app funciona offline com base local

## 📱 Testando

### Perguntas para Testar
```
"Meu filho tem 3 anos e não fala"
"Como lidar com crises de autismo?"
"Quais terapias funcionam para TEA?"
"Minha filha foi diagnosticada com autismo"
```

### Verificar Funcionamento
1. **Base Local**: Perguntas básicas (resposta instantânea)
2. **Gemini AI**: Perguntas específicas (resposta em 2-3 segundos)
3. **Cache**: Repetir pergunta (resposta instantânea)

## 🎯 Próximos Passos

### Melhorias Futuras
- [ ] Histórico de conversas
- [ ] Personalização por usuário
- [ ] Integração com calendário
- [ ] Notificações inteligentes
- [ ] Modo offline expandido

---

**✨ Pronto! Seu chatbot TISM agora tem IA avançada e funciona 100% offline + online!**