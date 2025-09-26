@echo off
echo 🌐 Executando TISM Web em modo desenvolvimento...

REM Verificar se a chave API foi definida
if "%GEMINI_API_KEY%"=="" (
    echo ❌ ERRO: Variável GEMINI_API_KEY não definida!
    echo.
    echo Para definir a chave API:
    echo set GEMINI_API_KEY=sua_chave_aqui
    echo.
    echo Ou edite este arquivo e substitua YOUR_API_KEY_HERE pela sua chave
    pause
    exit /b 1
)

echo ✅ Chave API encontrada: %GEMINI_API_KEY:~0,10%...
echo 🚀 Iniciando servidor de desenvolvimento...

REM Executar em modo debug com a chave API
flutter run -d chrome --dart-define=GEMINI_API_KEY=%GEMINI_API_KEY% --web-port=8080

pause