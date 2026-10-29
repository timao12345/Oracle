---- Select empresas, p testar no email
select rowid, A.Nroempresa, A.Servidorsmtp, A.Nroportasmtp, A.Indautenticasmtp, A.Emailsmtp,
      A.Nomeusuariosmtp, a.nomecontasmtp, A.Senhacontasmtp, A.Indcmdautenticacao, a.Caminhocertificado,
      a.Senhacertificado, a.Indusacertificado, a.Tipocertificado
 From consinco.Ge_Empresa a; 


---- Teste de envio de email consinco
declare
obj_param_smtp consinco.c5_tp_param_smtp;
begin
  obj_param_smtp := consinco.c5_tp_param_smtp(410);
  consinco.sp_envia_email(obj_param => obj_param_smtp,psDestinatario => 'rafael.alcantara@dbmaster.com.br',psAssunto=> 'Teste',psMensagem=> 'Teste',psindusahtml=> 'N');
end;

-- verifica os certificados disponiveis
openssl s_client -showcerts -connect smtp.gmail.com:587 -starttls smtp


CREATE OR REPLACE PROCEDURE send_mail (p_to        IN VARCHAR2,
                                       p_from      IN VARCHAR2,
                                       p_message   IN VARCHAR2,
                                       p_smtp_host IN VARCHAR2,
                                       p_smtp_port IN NUMBER DEFAULT 25)
AS
  l_mail_conn   UTL_SMTP.connection;
BEGIN
  l_mail_conn := UTL_SMTP.open_connection(p_smtp_host, p_smtp_port);
  UTL_SMTP.helo(l_mail_conn, p_smtp_host);
  UTL_SMTP.mail(l_mail_conn, p_from);
  UTL_SMTP.rcpt(l_mail_conn, p_to);
  UTL_SMTP.data(l_mail_conn, p_message || UTL_TCP.crlf || UTL_TCP.crlf);
  UTL_SMTP.quit(l_mail_conn);
END;
/

BEGIN
  UTL_MAIL.SEND
      (SENDER => 'jose.silva@caixavidaeprevidencia.com.br',
      RECIPIENTS => 'lucas.souza@caixavidaeprevidencia.com.br', 
      SUBJECT =>  'HEALTH-Check EXACC',    
      MESSAGE => 'Testando envio de e-mail',        
      MIME_TYPE => 'text/plain; charset=iso-8859-1'         
      );    
END;

BEGIN
UTL_MAIL.SEND           
     (SENDER => 'lucas.souza@caixavidaeprevidencia.com.br', -- remetente da mensagem  
     RECIPIENTS => 'lucas.souza@caixavidaeprevidencia.com.br',  -- destinatário da mensagem   
     CC => null,  -- destinatário copiado na mensagem            
     BCC => null,  -- destinatário com cópia oculta da  mensagem      
     SUBJECT =>  'HEALTH-Check EXACC', -- assunto da mensagem     
     MESSAGE => 'Testando envio de e-mail', -- mensagem do e-mail         
     MIME_TYPE => 'text/plain; charset=iso-8859-1' -- mime type + character set do texto da mensagem           
     );    
END;

BEGIN
  UTL_MAIL.send_attach_varchar2 (
    sender       => 'me@domain.com',
    recipients   => 'person1@domain.com,person2@domain.com',
    cc           => 'person3@domain.com',
    bcc          => 'myboss@domain.com',
    subject      => 'UTL_MAIL Test',
    message      => 'If you get this message it worked!',
    attachment   => 'The is the contents of the attachment.',
    att_filename => 'my_attachment.txt'    
  );
END;
/