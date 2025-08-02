const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
const { exec } = require('child_process');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(express.static('.'));

// 📧 CONFIGURAZIONE EMAIL FLEX TRADE
// CREDENZIALI EMAIL REALI - CONFIGURATE PER TEST
const EMAIL_CONFIG = {
    host: 'smtp.gmail.com',          // Server SMTP Gmail
    port: 587,                       // Porta SMTP con TLS
    secure: false,                   // TLS attivo
    user: 'swede.exe@gmail.com',     // 👈 EMAIL GMAIL DI TEST
    pass: 'oknt yjde cuno jmkv'              // 👈 PASSWORD APP GMAIL (16 caratteri)
};

// Crea trasportatore email
const transporter = nodemailer.createTransport({
    host: EMAIL_CONFIG.host,
    port: EMAIL_CONFIG.port,
    secure: EMAIL_CONFIG.secure,
    auth: {
        user: EMAIL_CONFIG.user,
        pass: EMAIL_CONFIG.pass
    }
});

// 🏠 Route principale - serve l'editor
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'editor-template-live.html'));
});

// � Route per l'editor BULK
app.get('/bulk', (req, res) => {
    res.sendFile(path.join(__dirname, 'editor-bulk-email.html'));
});

// �📤 Route per inviare email
app.post('/send-email', async (req, res) => {
    try {
        const {
            to,
            from,
            fromName,
            subject,
            html,
            text,
            recipientName
        } = req.body;

        // Validazione base
        if (!to || !subject || (!html && !text)) {
            return res.status(400).json({
                success: false,
                message: 'Dati mancanti: email destinatario, oggetto o contenuto'
            });
        }

        // Configura email con headers ottimizzati per Gmail
        const mailOptions = {
            from: `"${fromName || 'Flex Trade'}" <${EMAIL_CONFIG.user}>`,
            to: to,
            subject: subject,
            replyTo: from || EMAIL_CONFIG.user,
            headers: {
                'X-Mailer': 'Flex Trade Email System v2.0',
                'X-Priority': '3',
                'MIME-Version': '1.0',
                'Content-Type': 'text/html; charset=UTF-8',
                'X-MSMail-Priority': 'Normal',
                'Importance': 'Normal',
                'X-Gmail-Labels': 'Marketing'
            }
        };

        // Aggiungi contenuto HTML o testo
        if (html) {
            mailOptions.html = html;
            // Aggiungi anche una versione testo per compatibilità
            mailOptions.text = `
Bonjour ${recipientName || 'Client'},

Nous sommes heureux de vous annoncer que nous venons de recevoir un nouveau stock de vêtements militaires.

Pour plus d'informations, veuillez consulter votre email au format HTML ou nous contacter directement.

Cordialement,
${fromName || 'L\'équipe FLEX TRADE'}

---
Ce message est optimisé pour l'affichage HTML. Si vous ne voyez pas la mise en forme, veuillez activer l'affichage HTML dans votre client email.
            `.trim();
        } else {
            mailOptions.text = text;
        }

        // Invia email
        const result = await transporter.sendMail(mailOptions);

        console.log(`✅ Email inviata a ${to} - ID: ${result.messageId}`);

        res.json({
            success: true,
            message: `Email inviata con successo a ${to}`,
            messageId: result.messageId
        });

    } catch (error) {
        console.error('❌ Errore invio email:', error);

        res.status(500).json({
            success: false,
            message: 'Errore durante l\'invio dell\'email',
            error: error.message
        });
    }
});

// 🧪 Route di test del sistema
app.get('/test-email', async (req, res) => {
    try {
        await transporter.verify();
        res.json({
            success: true,
            message: 'Sistema email configurato correttamente!',
            config: {
                host: EMAIL_CONFIG.host,
                port: EMAIL_CONFIG.port,
                user: EMAIL_CONFIG.user
            }
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Errore configurazione email',
            error: error.message
        });
    }
});

// 📊 Route di stato del server
app.get('/status', (req, res) => {
    res.json({
        success: true,
        message: 'Server Flex Trade Email attivo',
        uptime: process.uptime(),
        timestamp: new Date().toISOString()
    });
});

// Avvia server
app.listen(PORT, () => {
    console.log(`
🚀 =======================================
   SERVER FLEX TRADE EMAIL ATTIVO!
🚀 =======================================

📱 Editor Email: http://localhost:${PORT}
🧪 Test Sistema: http://localhost:${PORT}/test-email
📊 Stato Server: http://localhost:${PORT}/status

⚙️  CONFIGURAZIONE ATTUALE:
   - Host SMTP: ${EMAIL_CONFIG.host}
   - Porta: ${EMAIL_CONFIG.port}
   - Email: ${EMAIL_CONFIG.user}

🌐 Apertura automatica del browser...

=======================================
`);

    // Apri automaticamente il browser dopo 3 secondi
    setTimeout(() => {
        const { exec } = require('child_process');
        exec('start http://localhost:3000/editor-template-live.html', (error) => {
            if (error) {
                console.log('⚠️  Apri manualmente: http://localhost:3000/editor-template-live.html');
            } else {
                console.log('✅ Browser aperto automaticamente!');
            }
        });
    }, 3000);
});

// Gestione errori globali
process.on('uncaughtException', (error) => {
    console.error('❌ Errore critico:', error);
});

process.on('unhandledRejection', (error) => {
    console.error('❌ Promise rifiutata:', error);
});
