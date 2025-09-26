#!/bin/bash

# TISM PWA - Deploy Netlify (macOS)
# Script otimizado para build e deploy do PWA

set -e  # Parar em caso de erro

echo "========================================="
echo "    🚀 TISM PWA - Deploy Netlify"
echo "========================================="
echo

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log colorido
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar se Flutter está instalado
if ! command -v flutter &> /dev/null; then
    log_error "Flutter não encontrado. Instale o Flutter primeiro."
    exit 1
fi

# Verificar se estamos no diretório correto
if [ ! -f "pubspec.yaml" ]; then
    log_error "Execute este script no diretório raiz do projeto Flutter"
    exit 1
fi

log_info "Verificando versão do Flutter..."
flutter --version

echo
log_info "[1/8] Habilitando suporte web..."
flutter config --enable-web

log_info "[2/8] Limpando build anterior..."
flutter clean

log_info "[3/8] Obtendo dependências..."
flutter pub get

log_info "[4/8] Analisando código..."
if ! flutter analyze; then
    log_warning "Análise encontrou problemas, mas continuando..."
fi

log_info "[5/8] Executando testes..."
if ! flutter test; then
    log_warning "Alguns testes falharam, mas continuando..."
fi

log_info "[6/8] Construindo PWA otimizada..."
flutter build web --release \
    --web-renderer canvaskit \
    --dart-define=FLUTTER_WEB_USE_SKIA=true \
    --dart-define=FLUTTER_WEB_AUTO_DETECT=true \
    --source-maps \
    --tree-shake-icons

log_info "[7/8] Otimizando para PWA..."

# Verificar se o build foi criado
if [ ! -d "build/web" ]; then
    log_error "Build falhou - diretório build/web não encontrado"
    exit 1
fi

# Adicionar informações de build
echo "Build: $(date)" > build/web/build-info.txt
echo "Versão: 1.0.0" >> build/web/build-info.txt
echo "Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')" >> build/web/build-info.txt

# Verificar arquivos PWA essenciais
log_info "Verificando arquivos PWA..."
PWA_FILES=("manifest.json" "sw.js" "index.html")
for file in "${PWA_FILES[@]}"; do
    if [ -f "build/web/$file" ]; then
        log_success "✓ $file encontrado"
    else
        log_error "✗ $file não encontrado"
        exit 1
    fi
done

log_info "[8/8] Preparando para deploy..."

# Verificar se Netlify CLI está instalado
if command -v netlify &> /dev/null; then
    echo
    log_info "Netlify CLI encontrado! Deseja fazer deploy automaticamente? (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        log_info "Fazendo login no Netlify..."
        netlify login
        
        log_info "Fazendo deploy..."
        netlify deploy --dir=build/web --prod
        
        log_success "Deploy concluído com sucesso!"
        exit 0
    fi
fi

echo
log_success "========================================="
log_success "    ✅ Build PWA concluído com sucesso!"
log_success "========================================="
echo
log_info "📁 Arquivos gerados em: build/web/"
echo
log_info "🌐 Para deploy manual no Netlify:"
log_info "1. Acesse: https://app.netlify.com/drop"
log_info "2. Arraste a pasta: build/web"
log_info "3. Aguarde o deploy"
log_info "4. Seu PWA estará online!"
echo
log_info "🔧 Para testar localmente:"
log_info "   cd build/web"
log_info "   python3 -m http.server 8000"
log_info "   Abra: http://localhost:8000"
echo
log_info "📊 Para instalar Netlify CLI:"
log_info "   npm install -g netlify-cli"
echo

# Abrir pasta do build no Finder (opcional)
log_info "Deseja abrir a pasta build/web no Finder? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    open build/web
fi

log_success "Script concluído! 🎉"