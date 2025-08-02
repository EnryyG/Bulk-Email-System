@echo off
title 📧 Email Flex Trade - SEMPLICE
color 2
cls

echo.
echo ================================================
echo    📧 FLEX TRADE - SISTEMA EMAIL
echo ================================================
echo.

cd /d "%~dp0"

echo 🚀 Avvio sistema email...
echo.
echo ⚠️  IMPORTANTE: NON CHIUDERE QUESTA FINESTRA
echo    Il sistema rimarrà attivo finché questa
echo    finestra è aperta.
echo.
echo ================================================
echo.

:: Avvia con npm che gestisce tutto automaticamente
npm start

echo.
echo ❌ Sistema arrestato!
pause
