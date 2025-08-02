@echo off
title 🆘 EMERGENCY EMAIL SERVER START 🆘
color 4
cls

echo.
echo ================================================
echo    🆘 AVVIO EMERGENZA SERVER EMAIL 🆘
echo ================================================
echo.

cd /d "%~dp0"

echo 🧹 Chiusura processi precedenti...
taskkill /F /IM node.exe >nul 2>&1

echo.
echo 🚀 Avvio manuale del server...
echo    Una finestra si aprirà con il server Node.js

:: Avvia il server in una finestra visibile per debug
start "SERVER EMAIL - NON CHIUDERE" cmd /k "echo Avvio server Node.js... && node server.js"

echo.
echo ⏳ Attesa di 15 secondi per l'avvio...
timeout /t 15 /nobreak

echo.
echo 🌐 Tentativo di apertura del browser...
start http://localhost:3000/editor-template-live.html

echo.
echo ================================================
echo Se il browser non si apre automaticamente:
echo.
echo 1. Apri il browser manualmente
echo 2. Vai su: http://localhost:3000/editor-template-live.html
echo 3. Se non funziona, controlla la finestra del server
echo ================================================
echo.
pause
