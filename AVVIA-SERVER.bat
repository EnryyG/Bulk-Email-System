@echo off
title 🚀 SISTEMA EMAIL FLEX TRADE 🚀
color 2
cls

echo.
echo ================================================
echo    🚀 SISTEMA EMAIL FLEX TRADE 🚀
echo ================================================
echo.
echo ⚡ AVVIO AUTOMATICO IN CORSO...
echo.

:: Vai nella cartella corretta
cd /d "%~dp0"

:: Controlla se Node.js è installato
echo 🔍 Controllo Node.js...
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERRORE: Node.js non è installato!
    echo    Contatta l'amministratore IT.
    pause
    exit /b 1
)
echo ✅ Node.js trovato!

:: Uccidi eventuali processi Node.js esistenti
echo 🧹 Pulizia processi precedenti...
taskkill /F /IM node.exe >nul 2>&1

:: Installa dipendenze se necessario
if not exist "node_modules" (
    echo 📦 Installazione componenti...
    npm install >nul 2>&1
    if errorlevel 1 (
        echo ❌ ERRORE nell'installazione dipendenze!
        pause
        exit /b 1
    )
)

echo.
echo ================================================
echo    🚀 AVVIO SERVER IN CORSO...
echo ================================================
echo.

:: Avvia il server in modo più robusto
echo 🚀 Avvio del server Node.js...
start "Server Email Flex Trade" cmd /k "node server.js"

:: Attesa progressiva con feedback visivo
echo ⏳ Attendo che il server si avvii...
echo    ▶ Controllo 1/5...
timeout /t 2 /nobreak >nul

echo    ▶ Controllo 2/5...
timeout /t 2 /nobreak >nul

echo    ▶ Controllo 3/5...
timeout /t 2 /nobreak >nul

echo    ▶ Controllo 4/5...
timeout /t 2 /nobreak >nul

echo    ▶ Controllo 5/5...
timeout /t 2 /nobreak >nul

:: Verifica multipla che il server sia attivo
set /a attempts=0
:test_connection
set /a attempts+=1
echo 🔍 Test connessione %attempts%/15...

curl -s -f http://localhost:3000/status >nul 2>&1
if not errorlevel 1 goto server_is_ready

if %attempts% LSS 15 (
    timeout /t 2 /nobreak >nul
    goto test_connection
)

echo.
echo ❌ ERRORE: Il server non risponde dopo 30 secondi!
echo.
echo 💡 Possibili soluzioni:
echo    1. Chiudi tutte le finestre del terminale
echo    2. Riavvia questo file
echo    3. Controlla se un antivirus blocca Node.js
echo    4. Contatta l'amministratore IT
echo.
pause
exit /b 1

:server_is_ready
echo.
echo ✅ SERVER ATTIVO E FUNZIONANTE!
echo.

:server_is_ready
echo.
echo ✅ SERVER ATTIVO E FUNZIONANTE!
echo.

:: Apri automaticamente il browser
echo 🌐 Apertura dell'editor email...
start http://localhost:3000/editor-template-final.html

echo.
echo ================================================
echo    ✅ SISTEMA EMAIL ATTIVO!
echo ================================================
echo.
echo 💻 L'editor email è ora aperto nel browser
echo    URL: http://localhost:3000/editor-template-final.html
echo.
echo � Per inviare email:
echo    1. Compila i campi nell'editor
echo    2. Clicca "📤 Invia Email"
echo    3. Fatto!
echo.
echo ⚠️  IMPORTANTE: 
echo    - NON CHIUDERE QUESTA FINESTRA!
echo    - Il server deve rimanere attivo
echo    - Una finestra del server è aperta in background
echo.

:: Mantieni la finestra aperta con status
:monitor_loop
timeout /t 60 /nobreak >nul
echo [%time%] 🔄 Sistema email attivo e monitorato...

:: Verifica che il server sia ancora attivo
curl -s -f http://localhost:3000/status >nul 2>&1
if errorlevel 1 (
    echo.
    echo ⚠️  ATTENZIONE: Server disconnesso!
    echo    Riavvio automatico in corso...
    goto restart_server
)
goto monitor_loop

:restart_server
echo 🔄 Riavvio del server...
taskkill /F /IM node.exe >nul 2>&1
start "Server Email Flex Trade" cmd /k "node server.js"
timeout /t 10 /nobreak >nul
goto monitor_loop
