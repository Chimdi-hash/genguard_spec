@echo off
echo.
echo ========================================
echo  GenGuard Spec - Local Development Server
echo ========================================
echo.
echo Starting HTTP server on http://localhost:8000
echo.
echo Press Ctrl+C to stop the server
echo.
python -m http.server 8000
pause
