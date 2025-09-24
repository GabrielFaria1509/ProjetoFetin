@echo off
echo ========================================
echo    TISM PWA Build Script
echo ========================================
echo.

REM Verificar se Flutter está instalado
flutter --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: Flutter não encontrado. Instale o Flutter primeiro.
    pause
    exit /b 1
)

echo [1/8] Habilitando suporte web...
flutter config --enable-web

echo [2/8] Limpando build anterior...
flutter clean

echo [3/8] Obtendo dependências...
flutter pub get

echo [4/8] Analisando código...
flutter analyze

echo [5/8] Executando testes...
flutter test

echo [6/8] Construindo PWA otimizada...
flutter build web --release ^
    --web-renderer canvaskit ^
    --dart-define=FLUTTER_WEB_USE_SKIA=true ^
    --dart-define=FLUTTER_WEB_AUTO_DETECT=true ^
    --source-maps ^
    --tree-shake-icons

echo [7/8] Otimizando assets...
REM Comprimir imagens se necessário
REM Minificar CSS/JS adicional

echo [8/8] Gerando relatório de build...
echo Build concluído em: %date% %time% > build\web\build-info.txt
echo Versão: 1.0.0 >> build\web\build-info.txt

echo.
echo ========================================
echo    Build PWA concluído com sucesso!
echo ========================================
echo.
echo Arquivos gerados em: build\web\
echo.
echo Para testar localmente:
echo   cd build\web
echo   python -m http.server 8000
echo   Abra: http://localhost:8000
echo.
echo Para deploy:
echo   - Copie o conteúdo de build\web\ para seu servidor
echo   - Configure HTTPS
echo   - Configure headers de cache
echo.
pause