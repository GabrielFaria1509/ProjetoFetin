# 🔒 Segurança Web - TISM

## ⚠️ IMPORTANTE: Exposição de Chaves API na Web

### 🚨 Problema de Segurança

Quando você faz build para web, **QUALQUER chave API no código fica EXPOSTA** e pode ser vista por qualquer usuário que inspecionar o código fonte da página.

### 🛡️ Soluções Recomendadas

#### **Opção 1: Backend Proxy (RECOMENDADO)**
```
Cliente Web → Seu Backend → Google Gemini API
```

**Vantagens:**
- ✅ Chave API fica segura no servidor
- ✅ Controle total sobre rate limiting
- ✅ Logs e monitoramento centralizados
- ✅ Pode implementar autenticação de usuários

#### **Opção 2: Desabilitar Chatbot na Web**
```dart
// No chatbot_service.dart
if (kIsWeb) {
  return '{"message": "Chatbot disponível apenas no app mobile por questões de segurança.", "mood": "smile"}';
}
```

#### **Opção 3: Chave com Restrições (LIMITADO)**
- Criar chave API específica para web
- Restringir por domínio no Google Cloud Console
- Definir cotas baixas
- **AINDA ASSIM a chave fica exposta**

### 🔧 Implementação do Backend Proxy

#### **Exemplo com Node.js/Express:**
```javascript
// server.js
const express = require('express');
const { GoogleGenerativeAI } = require('@google/generative-ai');

const app = express();
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

app.post('/api/chat', async (req, res) => {
  try {
    const { message } = req.body;
    
    // Validações de segurança
    if (!message || message.length > 1000) {
      return res.status(400).json({ error: 'Mensagem inválida' });
    }
    
    const model = genAI.getGenerativeModel({ model: 'gemini-2.0-flash-exp' });
    const result = await model.generateContent(message);
    
    res.json({ response: result.response.text() });
  } catch (error) {
    res.status(500).json({ error: 'Erro interno' });
  }
});
```

#### **Atualizar Flutter para usar o proxy:**
```dart
// No chatbot_service.dart
static Future<String> sendMessage(String message, [BuildContext? context]) async {
  if (kIsWeb) {
    // Usar backend proxy para web
    final response = await http.post(
      Uri.parse('https://seu-backend.com/api/chat'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response'];
    } else {
      return '{"message": "Erro de conexão com o servidor.", "mood": "sweat"}';
    }
  }
  
  // Mobile continua usando API direta
  // ... código existente
}
```

### 🚀 Deploy Seguro

#### **Para Render (Backend):**
1. Criar novo serviço Node.js no Render
2. Definir `GEMINI_API_KEY` nas variáveis de ambiente
3. Fazer deploy do proxy

#### **Para Netlify/Vercel (Frontend):**
1. Build sem chaves API: `flutter build web`
2. Deploy normal
3. Configurar para usar o backend proxy

### 📊 Comparação de Segurança

| Método | Segurança | Complexidade | Custo |
|--------|-----------|--------------|-------|
| **Backend Proxy** | 🟢 Alta | 🟡 Média | 💰 Baixo |
| **Chave Restrita** | 🟡 Baixa | 🟢 Baixa | 💰 Baixo |
| **Desabilitar Web** | 🟢 Alta | 🟢 Baixa | 💰 Zero |

### 🎯 Recomendação Final

**Para produção:** Use backend proxy
**Para desenvolvimento:** Pode usar chave direta com aviso
**Para demo:** Desabilite o chatbot na web

### 🔍 Como Verificar Exposição

1. Faça build: `flutter build web`
2. Abra `build/web/main.dart.js`
3. Procure por sua chave API
4. Se encontrar = **EXPOSTA** ⚠️