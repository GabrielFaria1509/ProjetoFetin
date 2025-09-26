# 🌐 Deploy Web - TISM

## Configuração de Variáveis de Ambiente para Web

### 🔧 Desenvolvimento Local

1. **Definir variável de ambiente:**
```bash
# Windows
set GEMINI_API_KEY=sua_chave_aqui

# Linux/Mac
export GEMINI_API_KEY=sua_chave_aqui
```

2. **Executar com script:**
```bash
# Windows
run_web.bat

# Ou manualmente
flutter run -d chrome --dart-define=GEMINI_API_KEY=sua_chave_aqui
```

### 🚀 Build para Produção

1. **Build com script:**
```bash
# Windows
build_web.bat

# Ou manualmente
flutter build web --dart-define=GEMINI_API_KEY=sua_chave_aqui --release
```

### ☁️ Deploy em Serviços de Hospedagem

#### **Netlify**
1. No painel do Netlify, vá em **Site Settings > Environment Variables**
2. Adicione: `GEMINI_API_KEY` = `sua_chave_aqui`
3. Configure o build command:
```bash
flutter build web --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY --release
```

#### **Vercel**
1. No painel do Vercel, vá em **Settings > Environment Variables**
2. Adicione: `GEMINI_API_KEY` = `sua_chave_aqui`
3. Configure o build command no `vercel.json`:
```json
{
  "builds": [
    {
      "src": "pubspec.yaml",
      "use": "@vercel/static-build",
      "config": {
        "buildCommand": "flutter build web --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY --release"
      }
    }
  ]
}
```

#### **Firebase Hosting**
1. Configure no `firebase.json`:
```json
{
  "hosting": {
    "public": "build/web",
    "predeploy": [
      "flutter build web --dart-define=GEMINI_API_KEY=$GEMINI_API_KEY --release"
    ]
  }
}
```

2. Defina a variável antes do deploy:
```bash
export GEMINI_API_KEY=sua_chave_aqui
firebase deploy
```

### 🔒 Segurança

⚠️ **IMPORTANTE:** 
- As variáveis definidas com `--dart-define` são compiladas no código
- Para máxima segurança, use um proxy/backend para chamadas da API
- Considere implementar rate limiting e validação no servidor

### 🧪 Teste Local

```bash
# Testar build de produção localmente
flutter build web --dart-define=GEMINI_API_KEY=sua_chave_aqui
cd build/web
python -m http.server 8000
# Acesse: http://localhost:8000
```

### 📝 Troubleshooting

**Problema:** Chatbot não funciona na web
**Solução:** Verificar se a variável foi definida corretamente no build

**Problema:** Erro de CORS
**Solução:** O Google Gemini API permite CORS, mas verifique se não há proxy bloqueando

**Problema:** Chave API não encontrada
**Solução:** Usar o botão de teste no chatbot para diagnosticar o problema