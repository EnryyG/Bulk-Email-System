@echo off
title 📧 FLEX TRADE EMAIL - SUPER SEMPLICE
color 2
cls

echo.
echo ================================================
echo        📧 FLEX TRADE EMAIL SYSTEM
echo ================================================
echo.
echo 🚀 Avvio in corso...
echo.

cd /d "%~dp0"

:: Avvia il server e mostra l'output
echo ⚠️  NON CHIUDERE QUESTA FINESTRA!
echo.
echo Dopo qualche secondo si aprirà automaticamente
echo il browser con l'interfaccia email:
echo http://localhost:3000/editor-template-live.html
echo.
echo ================================================
echo.

node server.js

pause
