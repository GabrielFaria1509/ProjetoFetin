@echo off
echo ========================================
echo    TISM PWA - Deploy Netlify
echo ========================================
echo.

echo [1/3] Building PWA...
flutter build web --release --web-renderer canvaskit

echo [2/3] Preparing files...
cd build\web

echo [3/3] Ready for Netlify!
echo.
echo ========================================
echo    Deploy Instructions:
echo ========================================
echo.
echo 1. Go to: https://app.netlify.com/drop
echo 2. Drag the folder: build\web
echo 3. Wait for deployment
echo 4. Your PWA will be live!
echo.
echo Current folder: %cd%
echo.
pause