@echo off
echo 🌐 Building TISM for Web...

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

REM Build para web com a chave API
flutter build web --dart-define=GEMINI_API_KEY=%GEMINI_API_KEY% --release --no-wasm-dry-run

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Build concluído com sucesso!
    echo 📁 Arquivos em: build\web\
    echo.
    echo Para testar localmente:
    echo flutter run -d chrome --dart-define=GEMINI_API_KEY=%GEMINI_API_KEY%
) else (
    echo.
    echo ❌ Erro no build!
)

pause