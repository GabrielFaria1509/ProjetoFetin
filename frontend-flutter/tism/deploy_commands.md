# 🚀 TISM PWA - Comandos de Deploy

## 📋 Comandos Essenciais

### 1. Configuração Inicial
```bash
# Habilitar suporte web
flutter config --enable-web

# Verificar configuração
flutter config

# Criar projeto web (se necessário)
flutter create . --platforms web
```

### 2. Build de Desenvolvimento
```bash
# Build debug
flutter build web --debug

# Build com hot reload
flutter run -d chrome --web-port 8080

# Build com source maps
flutter build web --source-maps
```

### 3. Build de Produção
```bash
# Build otimizado completo
flutter build web --release \
  --web-renderer canvaskit \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --dart-define=FLUTTER_WEB_AUTO_DETECT=true \
  --source-maps \
  --tree-shake-icons \
  --dart-define=FLUTTER_WEB_CANVASKIT_URL=https://unpkg.com/canvaskit-wasm@0.33.0/bin/

# Build com análise de bundle
flutter build web --release --analyze-size

# Build com profile
flutter build web --profile
```

### 4. Otimizações Avançadas
```bash
# Build com compressão máxima
flutter build web --release \
  --web-renderer canvaskit \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --tree-shake-icons \
  --split-debug-info=build/debug-info \
  --obfuscate

# Build com lazy loading
flutter build web --release \
  --dart-define=FLUTTER_WEB_USE_DEFERRED_LOADING=true
```

## 🔧 Scripts Automatizados

### Windows (PowerShell)
```powershell
# Script completo de build
function Build-TISM-PWA {
    Write-Host "🚀 Building TISM PWA..." -ForegroundColor Cyan
    
    # Limpar build anterior
    flutter clean
    
    # Obter dependências
    flutter pub get
    
    # Analisar código
    flutter analyze
    
    # Executar testes
    flutter test
    
    # Build otimizado
    flutter build web --release `
        --web-renderer canvaskit `
        --dart-define=FLUTTER_WEB_USE_SKIA=true `
        --tree-shake-icons `
        --source-maps
    
    Write-Host "✅ Build completed!" -ForegroundColor Green
}

# Executar
Build-TISM-PWA
```

### Linux/macOS (Bash)
```bash
#!/bin/bash
build_tism_pwa() {
    echo "🚀 Building TISM PWA..."
    
    # Verificar Flutter
    if ! command -v flutter &> /dev/null; then
        echo "❌ Flutter not found"
        exit 1
    fi
    
    # Build process
    flutter clean
    flutter pub get
    flutter analyze
    flutter test
    
    flutter build web --release \
        --web-renderer canvaskit \
        --dart-define=FLUTTER_WEB_USE_SKIA=true \
        --tree-shake-icons \
        --source-maps
    
    echo "✅ Build completed!"
}

build_tism_pwa
```

## 🌐 Deploy para Diferentes Plataformas

### Firebase Hosting
```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Inicializar projeto
firebase init hosting

# Deploy
firebase deploy --only hosting

# Deploy com preview
firebase hosting:channel:deploy preview
```

### Netlify
```bash
# Instalar Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Deploy
netlify deploy --dir=build/web --prod

# Deploy com preview
netlify deploy --dir=build/web
```

### Vercel
```bash
# Instalar Vercel CLI
npm install -g vercel

# Deploy
vercel --prod build/web

# Deploy com preview
vercel build/web
```

### GitHub Pages
```bash
# Usando gh-pages
npm install -g gh-pages

# Deploy
gh-pages -d build/web

# Ou usando GitHub Actions (ver deploy-pwa.yml)
```

### AWS S3 + CloudFront
```bash
# Instalar AWS CLI
pip install awscli

# Configurar credenciais
aws configure

# Sync para S3
aws s3 sync build/web/ s3://tism-pwa-bucket --delete

# Invalidar CloudFront
aws cloudfront create-invalidation \
    --distribution-id E1234567890 \
    --paths "/*"
```

## 📊 Análise e Monitoramento

### Lighthouse
```bash
# Instalar Lighthouse
npm install -g lighthouse

# Análise completa
lighthouse https://tism.app \
    --output html \
    --output json \
    --output-path ./reports/lighthouse

# Análise PWA específica
lighthouse https://tism.app \
    --only-categories=pwa \
    --chrome-flags="--headless"
```

### Bundle Analyzer
```bash
# Analisar bundle Flutter
flutter build web --analyze-size

# Usar ferramenta externa
npm install -g webpack-bundle-analyzer
webpack-bundle-analyzer build/web/main.dart.js
```

### Performance Monitoring
```bash
# Web Vitals
npm install web-vitals

# Adicionar ao projeto
import {getCLS, getFID, getFCP, getLCP, getTTFB} from 'web-vitals';

getCLS(console.log);
getFID(console.log);
getFCP(console.log);
getLCP(console.log);
getTTFB(console.log);
```

## 🔒 Configurações de Segurança

### Headers de Segurança (Nginx)
```nginx
# Adicionar ao nginx.conf
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';" always;
```

### HTTPS com Let's Encrypt
```bash
# Instalar Certbot
sudo apt install certbot python3-certbot-nginx

# Obter certificado
sudo certbot --nginx -d tism.app -d www.tism.app

# Renovação automática
sudo crontab -e
# Adicionar: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 🧪 Testes

### Testes Locais
```bash
# Servidor local
cd build/web
python -m http.server 8080

# Ou usando Node.js
npx http-server build/web -p 8080

# Teste HTTPS local
npx http-server build/web -p 8080 -S -C cert.pem -K key.pem
```

### Testes Automatizados
```bash
# Testes de unidade
flutter test

# Testes de integração
flutter test integration_test/

# Testes de widget
flutter test test/widget_test.dart
```

## 📱 Testes de Instalação

### Chrome DevTools
1. F12 > Application > Manifest
2. Verificar erros no manifest
3. Application > Service Workers
4. Verificar registro do SW

### PWA Testing
```bash
# PWA Builder
https://www.pwabuilder.com/

# Lighthouse PWA audit
lighthouse https://tism.app --only-categories=pwa

# Manual testing checklist
- [ ] App instala corretamente
- [ ] Funciona offline
- [ ] Service worker registra
- [ ] Manifest válido
- [ ] HTTPS configurado
```

## 🔄 CI/CD Pipeline

### GitHub Actions (Exemplo)
```yaml
name: Deploy PWA
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter build web --release
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

## 📈 Monitoramento Pós-Deploy

### Analytics
```javascript
// Google Analytics 4
gtag('config', 'GA_MEASUREMENT_ID');

// Eventos PWA
gtag('event', 'pwa_install');
gtag('event', 'offline_usage');
```

### Error Tracking
```javascript
// Sentry
import * as Sentry from "@sentry/browser";

Sentry.init({
  dsn: "YOUR_DSN_HERE",
});
```

### Performance Monitoring
```javascript
// Web Vitals
import {getCLS, getFID, getFCP, getLCP, getTTFB} from 'web-vitals';

function sendToAnalytics(metric) {
  gtag('event', metric.name, {
    value: Math.round(metric.value),
    event_category: 'Web Vitals',
  });
}

getCLS(sendToAnalytics);
getFID(sendToAnalytics);
getFCP(sendToAnalytics);
getLCP(sendToAnalytics);
getTTFB(sendToAnalytics);
```