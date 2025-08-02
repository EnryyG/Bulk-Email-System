<?php
// ===================================
// CONFIGURAZIONE EMAIL SERVER BACKEND
// ===================================

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Solo richieste POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Metodo non consentito']);
    exit;
}

// Configurazione SMTP (da modificare con i tuoi dati)
$SMTP_CONFIG = [
    'host' => 'smtp.flextrade.it',  // Server SMTP
    'port' => 587,                  // Porta SMTP
    'username' => 'noreply@flextrade.it',  // Username SMTP
    'password' => 'TUA_PASSWORD_SMTP',     // Password SMTP
    'encryption' => 'tls'           // Crittografia (tls/ssl)
];

// Email autorizzate per l'invio (sicurezza)
$AUTHORIZED_SENDERS = [
    'info@flextrade.it',
    'contact@flextrade.it',
    'commercial@flextrade.it',
    'admin@flextrade.it'
];

try {
    // Leggi i dati JSON
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input) {
        throw new Exception('Dati non validi');
    }
    
    // Validazione campi obbligatori
    $required_fields = ['to', 'from', 'fromName', 'subject', 'html'];
    foreach ($required_fields as $field) {
        if (empty($input[$field])) {
            throw new Exception("Campo '$field' obbligatorio");
        }
    }
    
    // Validazione email mittente autorizzato
    if (!in_array($input['from'], $AUTHORIZED_SENDERS)) {
        throw new Exception('Email mittente non autorizzata');
    }
    
    // Validazione formato email
    if (!filter_var($input['to'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception('Email destinatario non valida');
    }
    
    if (!filter_var($input['from'], FILTER_VALIDATE_EMAIL)) {
        throw new Exception('Email mittente non valida');
    }
    
    // Usa PHPMailer per l'invio (installare: composer require phpmailer/phpmailer)
    require_once 'vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;
    
    $mail = new PHPMailer(true);
    
    // Configurazione server
    $mail->isSMTP();
    $mail->Host = $SMTP_CONFIG['host'];
    $mail->SMTPAuth = true;
    $mail->Username = $SMTP_CONFIG['username'];
    $mail->Password = $SMTP_CONFIG['password'];
    $mail->SMTPSecure = $SMTP_CONFIG['encryption'];
    $mail->Port = $SMTP_CONFIG['port'];
    $mail->CharSet = 'UTF-8';
    
    // Configurazione email
    $mail->setFrom($input['from'], $input['fromName']);
    $mail->addAddress($input['to'], $input['recipientName'] ?? '');
    $mail->addReplyTo($input['from'], $input['fromName']);
    
    // Contenuto
    $mail->isHTML(true);
    $mail->Subject = $input['subject'];
    $mail->Body = $input['html'];
    
    // Aggiungi versione testo semplice (fallback)
    $mail->AltBody = strip_tags(str_replace(['<br>', '<br/>', '<br />'], "\n", $input['html']));
    
    // Invia
    $mail->send();
    
    // Log dell'invio (opzionale)
    $log_entry = [
        'timestamp' => date('Y-m-d H:i:s'),
        'from' => $input['from'],
        'to' => $input['to'],
        'subject' => $input['subject'],
        'status' => 'success'
    ];
    file_put_contents('email_log.txt', json_encode($log_entry) . "\n", FILE_APPEND);
    
    // Risposta di successo
    echo json_encode([
        'success' => true,
        'message' => 'Email inviata con successo',
        'timestamp' => date('Y-m-d H:i:s')
    ]);
    
} catch (Exception $e) {
    // Log dell'errore
    $log_entry = [
        'timestamp' => date('Y-m-d H:i:s'),
        'error' => $e->getMessage(),
        'data' => $input ?? null
    ];
    file_put_contents('email_errors.txt', json_encode($log_entry) . "\n", FILE_APPEND);
    
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Errore durante l\'invio: ' . $e->getMessage()
    ]);
}
?>
