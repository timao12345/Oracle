set serveroutput on

declare
  rKey raw(24);
  plaintext varchar2(200);
  compare_string varchar2(200);
  plaintext_raw raw(256);
  compare_raw raw(256);
  ciphertext raw(256);
  rIV raw(8);
  vtype number;
  function pkcs5(datain raw) return raw as
     l number;
     padblock raw(8);
     begin
       l:=8-mod(utl_raw.length(datain),8);
       padblock :=
          case l
            when 1 then hextoraw(01)
            when 2 then hextoraw(0202)
            when 3 then hextoraw(030303)
            when 4 then hextoraw(04040404)
            when 5 then hextoraw(0505050505)
            when 6 then hextoraw(060606060606)
            when 7 then hextoraw(07070707070707)
            when 8 then hextoraw(0808080808080808)
          end;
       return datain||padblock;
     end pkcs5;
  begin
    rKey := hextoraw('0123456789ABCDEFAAAABBBBCCCCDDDD0000111122223333');
    plaintext := 'This is a very big secret we need to hide.';
    dbms_output.put_line(plaintext);
    plaintext_raw := UTL_I18N.STRING_TO_RAW( data => plaintext,
                                             dst_charset => 'AL32UTF8');
    plaintext_raw := pkcs5(plaintext_raw);
    rIV := hextoraw('0000000000000000');
    -- Encrypt using 3DES in CBC mode with 3 keys.
    dbms_obfuscation_toolkit.DES3Encrypt(which => 1,
                                         key => rKey,
                                         input  => plaintext_raw,
                                         encrypted_data => ciphertext,
                                         IV => rIV);
    vtype := dbms_crypto.DES3_CBC_PKCS5;
    -- Note we have the default IV with DBMS_CRYPTO.
    compare_raw := dbms_crypto.decrypt(typ => vtype,
                                       SRC => ciphertext,
                                       key => rKey);
    compare_string := utl_i18n.raw_to_char(data => compare_raw,
                                           src_charset => 'AL32UTF8');
    dbms_output.put_line(compare_string);
    rKey := hextoraw('1111222233334444AAAABBBBCCCCDDDD');
    -- Now do the same with 3DES in 2 key mode with a shorter key.
    dbms_obfuscation_toolkit.DES3Encrypt(key => rKey,
                                         input  => plaintext_raw,
                                         encrypted_data => ciphertext);
    vtype := DBMS_CRYPTO.ENCRYPT_3DES_2KEY +
    DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
    -- Now use the default IV from DBMS_OBFUSCATION_TOOLKIT.
    rIV := hextoraw('0123456789ABCDEF');
    compare_raw := dbms_crypto.decrypt(typ => vtype,
                                      SRC => ciphertext,
                                      key => rKey,
                                      IV  => rIV);
    compare_string := utl_i18n.raw_to_char(data => compare_raw,
                                           src_charset => 'AL32UTF8');
    dbms_output.put_line(compare_string);        
  end;
/