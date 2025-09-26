@echo off
echo Building Flutter Web without WASM warnings...
flutter build web --no-wasm-dry-run --web-renderer html
echo Build completed!