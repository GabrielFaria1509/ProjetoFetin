# Setup Chatbot Autismo - Flutter + Ruby

## Backend Ruby (Rails API)

1. **Instalar dependências:**
```bash
cd backend_ruby
bundle install
```

2. **Configurar variável de ambiente:**
```bash
export HUGGINGFACE_TOKEN="seu_token_aqui"
```

3. **Iniciar servidor:**
```bash
rails server -p 3000
```

## Frontend Flutter

1. **Instalar dependências:**
```bash
cd flutter_app
flutter pub get
```

2. **Executar app:**
```bash
flutter run
```

## Configuração de Produção

### Backend (Heroku/Railway)
- Adicionar `HUGGINGFACE_TOKEN` nas variáveis de ambiente
- Atualizar `baseUrl` no Flutter para URL de produção

### Flutter (Android/iOS)
- Alterar `baseUrl` em `chatbot_service.dart`
- Build: `flutter build apk` ou `flutter build ios`

## Recursos Consumidos

- **Backend**: ~100MB RAM, resposta em 1-3s
- **Flutter**: ~50MB RAM, interface fluida
- **Total**: Roda em qualquer smartphone moderno