@echo off
title 📤 SISTEMA EMAIL BULK - FLEX TRADE 📤
color 5
cls

echo.
echo ================================================
echo    📤 SISTEMA EMAIL BULK - FLEX TRADE 📤
echo ================================================
echo.
echo ⚡ AVVIO SISTEMA INVIO MULTIPLO...
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
echo    🚀 AVVIO SERVER EMAIL BULK...
echo ================================================
echo.

:: Avvia il server
echo 🚀 Avvio del server Node.js...
start "Server Email Flex Trade" cmd /k "node server.js"

:: Attesa con feedback visivo
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

:: Verifica che il server sia attivo
set /a attempts=0
:test_connection
set /a attempts+=1
echo 🔍 Test connessione %attempts%/15...

powershell -command "try { Invoke-RestMethod -Uri 'http://localhost:3000/status' -TimeoutSec 3 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
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

:: Apri automaticamente l'editor BULK
echo 📤 Apertura dell'editor EMAIL BULK...
start http://localhost:3000/bulk

echo.
echo ================================================
echo    ✅ SISTEMA EMAIL BULK ATTIVO!
echo ================================================
echo.
echo 📧 L'editor per invii multipli è ora aperto nel browser
echo    URL: http://localhost:3000/bulk
echo.
echo 📊 Funzionalità disponibili:
echo    ✅ Importazione CSV con destinatari
echo    ✅ Template personalizzabili con variabili
echo    ✅ Invio automatico con intervalli
echo    ✅ Monitoraggio progress in tempo reale
echo    ✅ Log dettagliati degli invii
echo.
echo ⚠️  IMPORTANTE: 
echo    - NON CHIUDERE QUESTA FINESTRA!
echo    - Il server deve rimanere attivo
echo    - Una finestra del server è aperta in background
echo.

:: Mantieni la finestra aperta con monitoraggio
:monitor_loop
timeout /t 60 /nobreak >nul
echo [%time%] 📤 Sistema email BULK attivo e monitorato...

:: Verifica che il server sia ancora attivo
powershell -command "try { Invoke-RestMethod -Uri 'http://localhost:3000/status' -TimeoutSec 3 | Out-Null; exit 0 } catch { exit 1 }" >nul 2>&1
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
