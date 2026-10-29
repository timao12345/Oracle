rem -----------------------------------------------------------------------
rem Filename:  password.sql
rem Purpose:   Simple password encryption package to demonstrate how
rem            values can be encrypted and decrypted using Oracle's
rem            DBMS Obfuscation Toolkit
rem Note:      Connect to SYS AS SYSDBA and run ?/rdbms/admin/catobtk.sql
rem Date:      18-Mar-2003
rem Author:    Frank Naude, Oracle FAQ
rem -----------------------------------------------------------------------


CREATE OR REPLACE PACKAGE PASSWORD AS
   function encrypt(i_password varchar2) return varchar2;
   function decrypt(i_password varchar2) return varchar2;
END PASSWORD;
/
show errors


CREATE OR REPLACE PACKAGE BODY PASSWORD AS

  -- key must be exactly 8 bytes long
  c_encrypt_key varchar2(8) := 'key45678';

  function encrypt (i_password varchar2) return varchar2 is
    v_encrypted_val varchar2(38);
    v_data          varchar2(38);
  begin
     -- Input data must have a length divisible by eight
     v_data := RPAD(i_password,(TRUNC(LENGTH(i_password)/8)+1)*8,CHR(0));

     DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT(
        input_string     => v_data,
        key_string       => c_encrypt_key,
        encrypted_string => v_encrypted_val);
     return v_encrypted_val;
  end encrypt;

  function decrypt (i_password varchar2) return varchar2 is
    v_decrypted_val varchar2(38);
  begin
     DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT(
        input_string     => i_password,
        key_string       => c_encrypt_key,
        decrypted_string => v_decrypted_val);
     return v_decrypted_val;
  end decrypt;


end PASSWORD;
/
show errors

-- Test if it is working...
select password.encrypt('PASSWORD1') from dual;
select password.decrypt(app_password.encrypt('PASSWORD1')) from dual;
select password.encrypt('PSW2') from dual;
select password.decrypt(app_password.encrypt('PSW2')) from dual;


select password.encrypt('JULIETAY#123') from dual;