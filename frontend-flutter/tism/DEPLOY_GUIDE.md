# 🚀 Guia Rápido - Deploy PWA no Netlify

## ⚡ Deploy Automático (Recomendado)

### 1. Executar Script
```bash
./deploy_netlify.sh
```

O script vai:
- ✅ Fazer build otimizado do PWA
- ✅ Verificar arquivos essenciais
- ✅ Oferecer deploy automático via Netlify CLI

### 2. Deploy via Netlify CLI
Se você tem o Netlify CLI instalado:
```bash
# Instalar (se necessário)
npm install -g netlify-cli

# Login
netlify login

# Deploy
netlify deploy --dir=build/web --prod
```

## 📁 Deploy Manual

### 1. Build do Projeto
```bash
flutter build web --release --web-renderer canvaskit --tree-shake-icons
```

### 2. Deploy no Netlify
1. Acesse: https://app.netlify.com/drop
2. Arraste a pasta `build/web`
3. Aguarde o deploy
4. Seu PWA estará online!

## 🔧 Configurações Importantes

### Arquivos de Configuração
- ✅ `netlify.toml` - Configuração principal
- ✅ `web/_headers` - Headers HTTP
- ✅ `web/_redirects` - Redirects SPA
- ✅ `web/manifest.json` - Manifest PWA
- ✅ `web/sw.js` - Service Worker

### Headers Configurados
- **Cache**: Otimizado para PWA
- **Segurança**: Headers de proteção
- **Performance**: Compressão e cache

### Funcionalidades PWA
- ✅ Instalação nativa
- ✅ Modo offline
- ✅ Cache inteligente
- ✅ Service Worker
- ✅ Manifest completo
- ✅ Ícones otimizados

## 🧪 Testar PWA

### Local
```bash
cd build/web
python3 -m http.server 8000
# Abrir: http://localhost:8000
```

### Lighthouse
```bash
npm install -g lighthouse
lighthouse https://seu-site.netlify.app --view
```

### Checklist PWA
- [ ] App instala corretamente
- [ ] Funciona offline
- [ ] Service Worker ativo
- [ ] Manifest válido
- [ ] Score Lighthouse 90+

## 🌐 Domínio Personalizado

### No Netlify
1. Site Settings > Domain management
2. Add custom domain
3. Configure DNS
4. SSL automático

### Atualizar Redirects
Edite `web/_redirects`:
```
http://seu-dominio.com/*    https://seu-dominio.com/:splat    301!
```

## 📊 Monitoramento

### Analytics
- Google Analytics 4 configurado
- Eventos PWA rastreados
- Métricas de performance

### Logs
- Netlify Functions logs
- Service Worker logs no DevTools
- Network requests no DevTools

## 🔒 Segurança

### Headers Configurados
- X-Frame-Options
- X-Content-Type-Options
- X-XSS-Protection
- Referrer-Policy
- Strict-Transport-Security

### HTTPS
- SSL automático no Netlify
- Redirects HTTP → HTTPS
- Service Worker requer HTTPS

## 🚨 Troubleshooting

### Build Falha
```bash
flutter clean
flutter pub get
flutter build web --release
```

### PWA Não Instala
- Verificar HTTPS
- Verificar manifest.json
- Verificar service worker
- Testar no Chrome DevTools

### Cache Problemas
```bash
# Limpar cache do navegador
# Ou atualizar versão no sw.js
```

### Deploy Falha
- Verificar netlify.toml
- Verificar tamanho dos arquivos
- Verificar logs do Netlify

## 📞 Suporte

- **Netlify Docs**: https://docs.netlify.com/
- **Flutter Web**: https://flutter.dev/web
- **PWA Guide**: https://web.dev/progressive-web-apps/

---

**Desenvolvido com 💙 pela equipe TISM**