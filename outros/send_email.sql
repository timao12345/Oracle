CREATE OR REPLACE PROCEDURE "SYS"."SEND_EMAIL" (FileName IN VARCHAR2, AttachmentName IN VARCHAR2)
AS

   FileHandle     BFILE;
   Buffer         RAW(32767);
   Amount         INTEGER;
   Offset         INTEGER := 1;

   -- Added this variable
   EncodedBuffer  RAW(32767);

BEGIN

   FileHandle := BFILENAME('FILE_LOC', FileName);
   Amount := DBMS_LOB.GETLENGTH(FileHandle);

   DBMS_OUTPUT.PUT_LINE('Attachment Size: ' || Amount || ' bytes');

   DBMS_LOB.FILEOPEN(FileHandle, DBMS_LOB.FILE_READONLY);
   DBMS_LOB.READ(FileHandle, Amount, Offset, Buffer);
   DBMS_LOB.FILECLOSE(FileHandle);

   -- Added the following two lines
   EncodedBuffer := UTL_ENCODE.BASE64_ENCODE(Buffer);
   DBMS_OUTPUT.PUT_LINE('Encoded Size: ' || UTL_RAW.LENGTH(EncodedBuffer));

   UTL_MAIL.SEND_ATTACH_RAW(sender =>     'monitoracao_oracle@caixavidaeprevidencia.com.br',
                           recipients =>  'lucas.souza@caixavidaeprevidencia.com.br,jose.silva@caixavidaeprevidencia.com.br,raphael.rodrigues@caixavidaeprevidencia.com.br,vinicius.ferreira@caixavidaeprevidencia.com.br',
                           cc        =>   '',
                           subject =>     'Status Oracle ExaCC',
                           message =>     ' Este e-mail foi enviado pelo servidor de banco de dados Oracle ',
                           attachment =>   Buffer,
                           att_inline =>   FALSE,
                           att_filename => AttachmentName);

END;