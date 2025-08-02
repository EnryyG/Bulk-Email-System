// 📧 CONFIGURAZIONE EMAIL FLEX TRADE
// Inserisci qui le tue credenziali email reali

module.exports = {
    // Configurazione SMTP
    host: 'smtp.gmail.com',
    port: 587,
    secure: false, // true per porta 465, false per altre porte
    
    // Credenziali Gmail
    user: 'TUA-EMAIL@gmail.com',        // 👈 INSERISCI LA TUA EMAIL GMAIL
    pass: 'tua-password-app-16-caratteri', // 👈 INSERISCI LA PASSWORD APP
    
    // Email di default per invii
    defaultFrom: 'Flex Trade <TUA-EMAIL@gmail.com>',
    
    // Configurazioni aggiuntive
    rateLimits: {
        maxEmails: 100,    // Max email al giorno
        interval: 24 * 60 * 60 * 1000 // 24 ore in millisecondi
    }
};

/*
🔧 GUIDA CONFIGURAZIONE GMAIL:

1. Vai su https://myaccount.google.com
2. Clicca su "Sicurezza" nel menu laterale
3. Attiva "Verifica in due passaggi" se non è già attiva
4. Vai su "Password per le app"
5. Seleziona "App: Mail" e "Dispositivo: Windows"
6. Copia la password di 16 caratteri generata
7. Incollala nel campo 'pass' sopra

⚠️ IMPORTANTE:
- NON usare la password normale di Gmail
- Usa SOLO la "Password per le app" di 16 caratteri
- Mantieni questo file privato e sicuro

✅ QUANDO CONFIGURATO:
- Il sistema invierà email reali
- I segretari potranno usarlo senza problemi
- Tutto funzionerà automaticamente
*/
