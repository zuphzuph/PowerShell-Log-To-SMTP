stop-service "Full Service Name."
Copy-Item "Path to Debugger File." -Destination "Save Debug File To."
Clear-Content "Clear Log File."
start-service "Full Service Name."

$Username = "domain/acct";
$Password = "cred";
$path = "Path of Log to Send_$(get-date -f MM-dd).txt";

function Send-ToEmail([string]$email, [string]$attachmentpath){

    $message = new-object Net.Mail.MailMessage;
    $message.From = "alias@domain.com";
    $message.To.Add($email);
    $message.Subject = "Describe Sent Log";
    $message.Body = "";
    $attachment = New-Object Net.Mail.Attachment($attachmentpath);
    $message.Attachments.Add($attachment);
    $smtp = new-object Net.Mail.SmtpClient("stmp.mail.com");
    $smtp.EnableSSL = $true;
    $smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { return $true }
    $smtp.send($message);
    write-host "Mail Sent" ; 
    $attachment.Dispose();
 }
Send-ToEmail  -email "destination@domain.com" -attachmentpath $path;
