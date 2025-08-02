# 📧 Guida Setup EmailJS per Flex Trade

## 🚀 Setup Rapido (5 minuti)

### 1. Crea Account EmailJS

1. Vai su **https://www.emailjs.com**
2. Clicca **"Sign Up"** e crea un account gratuito
3. Conferma la tua email

### 2. Configura Servizio Email

1. Nel dashboard EmailJS, vai su **"Email Services"**
2. Clicca **"Add New Service"**
3. Scegli il tuo provider email:
   - **Gmail** (consigliato)
   - **Outlook**
   - **Yahoo**
   - Altri provider

4. **Per Gmail:**
   - Seleziona "Gmail"
   - Autorizza EmailJS ad accedere al tuo account Gmail
   - Completa l'autorizzazione OAuth

5. Copia il **Service ID** (es: `service_1a2b3c4`)

### 3. Crea Template Email

1. Vai su **"Email Templates"**
2. Clicca **"Create New Template"**
3. Usa questo template:

```html
Subject: {{subject}}

To: {{to_email}}
From: {{from_name}} <{{from_email}}>

{{{html_content}}}

---
Inviato tramite Flex Trade Email System
```

4. Salva e copia il **Template ID** (es: `template_xyz123`)

### 4. Ottieni Public Key

1. Vai su **"Account"** → **"General"**
2. Trova la **"Public Key"** (es: `user_abc123def456`)
3. Copia questa chiave

### 5. Configura il Sistema

1. Apri `editor-template-live.html`
2. Inserisci i tuoi dati:
   - **Service ID**: `service_1a2b3c4`
   - **Template ID**: `template_xyz123`
   - **Public Key**: `user_abc123def456`
3. Clicca **"Attiva Sistema Email"**

## ✅ Test del Sistema

1. Compila tutti i campi del form
2. Inserisci la tua email come destinatario (per test)
3. Clicca **"Invia Email (LIVE)"**
4. Controlla la tua casella email!

## 🔧 Risoluzione Problemi

### Email non arriva?
- Controlla la cartella SPAM
- Verifica che i Service ID e Template ID siano corretti
- Assicurati che il servizio Gmail sia autorizzato

### Errore di autenticazione?
- Ri-autorizza il servizio Gmail in EmailJS
- Controlla che la Public Key sia corretta

### Template non funziona?
- Assicurati che il template contenga `{{{html_content}}}`
- Verifica che tutti i placeholder siano presenti

## 📊 Limiti Account Gratuito

- **200 email/mese** (sufficiente per test e uso moderato)
- Per volumi maggiori, considera l'upgrade a piano a pagamento

## 🛡️ Sicurezza

- EmailJS è sicuro per uso aziendale
- Le email vengono inviate dai server di EmailJS
- I tuoi dati rimangono privati

## 💡 Suggerimenti

1. **Test prima dell'uso**: Invia sempre un'email di test
2. **Backup delle credenziali**: Salva Service ID, Template ID e Public Key
3. **Monitoraggio**: Controlla le statistiche in EmailJS per vedere le email inviate

---

## 🆘 Supporto

Se hai problemi:
1. Controlla la console del browser (F12) per errori
2. Verifica la configurazione in EmailJS
3. Testa con un template semplice prima

**Il sistema è ora pronto per l'uso in produzione!** 🎉
