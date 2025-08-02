@echo off
title 🚀 SISTEMA EMAIL FLEX TRADE - VERSIONE SEMPLIFICATA 🚀
color 2
cls

echo.
echo ================================================
echo    🚀 SISTEMA EMAIL FLEX TRADE 🚀
echo ================================================
echo.

:: Vai nella cartella corretta
cd /d "%~dp0"

:: Controlla se Node.js è installato
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERRORE: Node.js non è installato!
    echo    Contatta l'amministratore IT.
    pause
    exit /b 1
)

echo ✅ Node.js trovato!

:: Installa dipendenze se necessario
if not exist "node_modules" (
    echo 📦 Installazione componenti...
    npm install
    if errorlevel 1 (
        echo ❌ ERRORE nell'installazione!
        pause
        exit /b 1
    )
)

:: Uccidi eventuali processi Node.js esistenti
taskkill /F /IM node.exe >nul 2>&1

echo.
echo 🚀 Avvio del server...

:: Avvia il server in background
start /B node server.js

:: Attendi con controlli progressivi
echo ⏳ Controllo avvio del server...

timeout /t 3 >nul
echo    ▶ Primo controllo...

timeout /t 3 >nul
echo    ▶ Secondo controllo...

timeout /t 3 >nul
echo    ▶ Terzo controllo...

:: Verifica finale
curl -s http://localhost:3000/status >nul 2>&1
if errorlevel 1 (
    echo.
    echo ❌ ERRORE: Server non risponde!
    echo    Prova a riavviare il sistema.
    pause
    exit /b 1
)

echo.
echo ✅ SERVER ATTIVO!
echo.
echo 🌐 Apertura dell'editor email...
start http://localhost:3000/editor-template-live.html

echo.
echo ================================================
echo    ✅ SISTEMA AVVIATO CON SUCCESSO!
echo ================================================
echo.
echo 💡 L'editor email è ora aperto nel browser
echo    URL: http://localhost:3000/editor-template-live.html
echo.
echo ⚠️  IMPORTANTE: NON CHIUDERE QUESTA FINESTRA!
echo    Il server deve rimanere attivo per inviare email.
echo.

:: Mantieni la finestra aperta
:loop
timeout /t 60 >nul
echo [%time%] Sistema attivo...
goto loop
