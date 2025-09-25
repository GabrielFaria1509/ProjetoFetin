# 📱 TISM - Flutter App

**Tudo o que você precisa saber sobre o TEA em um clique** 💙

Aplicativo Flutter multiplataforma para a comunidade TEA (Transtorno do Espectro Autista).

---

## 🌟 **Sobre o Projeto**

O **TISM** é um aplicativo inovador desenvolvido especialmente para a **comunidade TEA**. Nossa plataforma oferece:

- 🏠 **Dashboard Intuitivo** com navegação organizada
- 💬 **Fórum Interativo** para compartilhamento de experiências
- 📚 **Central de Conhecimento** com artigos especializados
- 🤖 **Assistente Virtual Tina** com IA especializada em TEA
- 📊 **Diário de Observações** para acompanhamento comportamental
- ⏰ **Rotinas Personalizadas** adaptáveis às necessidades

---

## 🌍 **Suporte Multilíngue**

O app suporta **13 idiomas** com localização completa:

- 🇧🇷 Português (Nativo)
- 🇺🇸 English
- 🇪🇸 Español
- 🇫🇷 Français
- 🇩🇪 Deutsch
- 🇮🇹 Italiano
- 🇯🇵 日本語
- 🇰🇷 한국어
- 🇨🇳 中文
- 🇮🇳 हिन्दी
- 🇸🇦 العربية (RTL)
- 🇷🇺 Русский
- 🇹🇷 Türkçe

---

## 🚀 **Tecnologias**

- **Framework:** Flutter 3.x
- **Linguagem:** Dart
- **Plataformas:** iOS, Android, Web (PWA)
- **Internacionalização:** Flutter Intl (ARB)
- **Estado:** Provider/Riverpod
- **HTTP:** Dio
- **Cache:** Hive/SharedPreferences
- **IA:** Google Gemini API

---

## 📦 **Instalação**

### **Pré-requisitos**
```bash
# Flutter SDK 3.x+
flutter --version

# Dart SDK 3.x+
dart --version
```

### **Configuração**
```bash
# 1. Clone o repositório
git clone https://github.com/GabrielFaria1509/ProjetoFetin.git
cd ProjetoFetin/frontend-flutter/tism

# 2. Instale dependências
flutter pub get

# 3. Configure variáveis de ambiente
cp .env.example .env
# Edite o .env com suas chaves de API

# 4. Gere arquivos de localização
flutter packages pub run build_runner build

# 5. Execute o app
flutter run
```

### **Configuração da API Gemini**
```env
# .env
GEMINI_API_KEY=sua_chave_aqui
```

---

## 🛠️ **Desenvolvimento**

### **Estrutura do Projeto**
```
lib/
├── l10n/                 # Arquivos de localização gerados
├── models/               # Modelos de dados
├── services/             # Serviços (API, cache, etc.)
├── views/                # Telas do aplicativo
│   ├── auth/            # Autenticação
│   ├── dashboard/       # Dashboard principal
│   ├── forum/           # Fórum da comunidade
│   ├── knowledge/       # Central de conhecimento
│   ├── chatbot/         # Assistente Tina
│   ├── diary/           # Diário de observações
│   └── routine/         # Rotinas personalizadas
├── widgets/              # Componentes reutilizáveis
└── main.dart            # Ponto de entrada

languages/               # Arquivos de tradução (ARB)
├── pt.arb              # Português
├── en.arb              # English
└── ...                 # Outros idiomas
```

### **Comandos Úteis**
```bash
# Executar em modo debug
flutter run

# Build para produção
flutter build apk --release
flutter build ios --release

# Gerar PWA
flutter build web --release

# Testar idiomas específicos
flutter run --dart-define=LOCALE=en
flutter run --dart-define=LOCALE=ar  # RTL

# Análise de código
flutter analyze

# Testes
flutter test
```

---

## 🌐 **Internacionalização**

### **Adicionando Novas Strings**
```dart
// 1. Adicionar em languages/pt.arb
"nova_mensagem": "Olá, mundo!",
"@nova_mensagem": {
  "description": "Mensagem de saudação"
}

// 2. Gerar arquivos
flutter packages pub run build_runner build

// 3. Usar no código
Text(AppLocalizations.of(context)!.nova_mensagem)
```

### **Strings com Parâmetros**
```dart
// ARB
"hello_user": "Olá, {name}! 👋",
"@hello_user": {
  "placeholders": {
    "name": {"type": "String"}
  }
}

// Dart
Text(AppLocalizations.of(context)!.hello_user("João"))
```

---

## 🤖 **Assistente Tina**

A **Tina** é nossa assistente virtual especializada em TEA:

### **Características**
- 🧠 **IA Especializada** em autismo e neurodiversidade
- 🌍 **Multilíngue** com respostas contextualizadas
- 😊 **Sistema de Moods** para comunicação expressiva
- 📚 **Base Científica** validada por especialistas

### **Moods Disponíveis**
- `smile`: Cordial, neutro
- `happy`: Celebrações, conquistas
- `grimacing`: Situações delicadas
- `eyebrow`: Dúvidas, questionamentos
- `sweat`: Tristeza, dificuldades
- `wink`: Dicas, cumplicidade

---

## 📱 **PWA (Progressive Web App)**

O TISM também funciona como PWA:

```bash
# Build PWA
flutter build web --release

# Deploy local
flutter run -d chrome --web-port 8080
```

### **Recursos PWA**
- ✅ Instalável no dispositivo
- ✅ Funciona offline (cache)
- ✅ Notificações push
- ✅ Responsivo para todos os tamanhos

---

## 🔧 **Configurações Avançadas**

### **Temas**
- 🌞 **Claro**
- 🌙 **Escuro**
- 🔄 **Sistema** (automático)

### **Acessibilidade**
- ♿ Compatível com leitores de tela
- 🔤 Suporte a fontes grandes
- 🎨 Alto contraste
- ⌨️ Navegação por teclado

---

## 📊 **Performance**

### **Otimizações**
- 🚀 **Lazy Loading** de telas
- 💾 **Cache Inteligente** de dados
- 🖼️ **Compressão de Imagens**
- ⚡ **Build Otimizado** para produção

### **Métricas**
- **Tempo de Inicialização:** < 2s
- **Tamanho do APK:** < 50MB
- **Uso de Memória:** < 100MB
- **FPS:** 60fps consistente

---

## 🤝 **Contribuição**

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

---

## 📄 **Licença**

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

---

<div align="center">
  <p><strong>Desenvolvido com 💙 para a comunidade TEA</strong></p>
  <p><em>"Tecnologia a serviço da inclusão e do bem-estar"</em></p>
</div>