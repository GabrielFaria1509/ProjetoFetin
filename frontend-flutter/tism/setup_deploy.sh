#!/bin/bash

# TISM PWA - Setup completo para deploy
# Instala dependências e configura ambiente

set -e

echo "========================================="
echo "    🔧 TISM PWA - Setup Deploy"
echo "========================================="
echo

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar se Node.js está instalado
if ! command -v node &> /dev/null; then
    log_warning "Node.js não encontrado. Instalando via Homebrew..."
    if ! command -v brew &> /dev/null; then
        log_info "Instalando Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install node
fi

# Verificar se npm está disponível
if ! command -v npm &> /dev/null; then
    log_error "npm não encontrado após instalação do Node.js"
    exit 1
fi

log_info "Versões instaladas:"
node --version
npm --version

# Instalar Netlify CLI
log_info "Instalando Netlify CLI..."
npm install -g netlify-cli

# Verificar instalação
if command -v netlify &> /dev/null; then
    log_success "Netlify CLI instalado com sucesso!"
    netlify --version
else
    log_warning "Netlify CLI não foi instalado corretamente"
fi

# Instalar Lighthouse (opcional)
log_info "Deseja instalar Lighthouse para testes de PWA? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    npm install -g lighthouse
    log_success "Lighthouse instalado!"
fi

# Verificar Flutter
if command -v flutter &> /dev/null; then
    log_success "Flutter encontrado!"
    flutter --version
    
    # Habilitar web
    flutter config --enable-web
    log_success "Suporte web habilitado!"
else
    log_warning "Flutter não encontrado. Instale o Flutter primeiro:"
    log_info "https://flutter.dev/docs/get-started/install/macos"
fi

echo
log_success "========================================="
log_success "    ✅ Setup concluído!"
log_success "========================================="
echo
log_info "Próximos passos:"
log_info "1. Execute: ./deploy_netlify.sh"
log_info "2. Ou faça login: netlify login"
log_info "3. E deploy: netlify deploy --dir=build/web --prod"
echo
log_info "Para testar PWA:"
log_info "lighthouse https://seu-site.netlify.app --view"
echo

# Tornar script de deploy executável
chmod +x deploy_netlify.sh
log_success "Script de deploy está pronto para uso!"