@echo off
echo ========================================
echo    TISM PWA Performance Analyzer
echo ========================================
echo.

REM Verificar se Node.js está instalado
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Node.js não encontrado. Instale o Node.js primeiro.
    echo Download: https://nodejs.org/
    pause
    exit /b 1
)

echo [1/5] Verificando dependências...
npm list -g lighthouse >nul 2>&1
if %errorlevel% neq 0 (
    echo Instalando Lighthouse...
    npm install -g lighthouse
)

echo [2/5] Construindo aplicação...
call build_pwa.bat

echo [3/5] Iniciando servidor local...
cd build\web
start /B python -m http.server 8080
timeout /t 3 /nobreak >nul

echo [4/5] Executando análise Lighthouse...
lighthouse http://localhost:8080 ^
    --output html ^
    --output json ^
    --output-path ../../lighthouse-report ^
    --chrome-flags="--headless" ^
    --quiet

echo [5/5] Gerando relatório personalizado...
cd ..\..

echo.
echo ========================================
echo    Análise PWA Concluída
echo ========================================
echo.
echo Relatórios gerados:
echo   - lighthouse-report.html (Visual)
echo   - lighthouse-report.json (Dados)
echo.
echo Métricas importantes:
echo   - Performance: Deve ser 90+
echo   - Accessibility: Deve ser 95+
echo   - Best Practices: Deve ser 95+
echo   - SEO: Deve ser 90+
echo   - PWA: Deve ser 100
echo.

REM Parar servidor
taskkill /F /IM python.exe >nul 2>&1

REM Abrir relatório
if exist lighthouse-report.html (
    echo Abrindo relatório...
    start lighthouse-report.html
)

echo.
echo Dicas para melhorar performance:
echo   1. Otimizar imagens (WebP, compressão)
echo   2. Minimizar JavaScript não usado
echo   3. Implementar lazy loading
echo   4. Configurar cache adequadamente
echo   5. Usar CDN para assets estáticos
echo.
pause