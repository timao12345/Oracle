-- criar a nova tablespace nova.
CREATE TEMPORARY TABLESPACE PSAPTEMP1 TEMPFILE '+DATAC3' SIZE 2767M AUTOEXTEND ON NEXT 100M;

-- Alterar para a tablespace nova
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE PSAPTEMP;

-- Switch all existing users to new temp tablespace.
BEGIN
  FOR cur_user IN (SELECT username FROM dba_users WHERE temporary_tablespace = 'PSAPTEMP') LOOP
    EXECUTE IMMEDIATE 'ALTER USER ' || cur_user.username || ' TEMPORARY TABLESPACE PSAPTEMP';
  END LOOP;
END;
/

DROP TABLESPACE  PDBTEMP INCLUDING CONTENTS AND DATAFILES;

-- incluid datafiles suficiente.

alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;
alter tablespace temp add tempfile '+DATAC1' size 32767m;