set serveroutput on size 1000000
set feed off ver off pages 0 lines 2000 trims on
DECLARE
cursor c1 is
select file#, name, unrecoverable_change#, 
       to_char(unrecoverable_time, 'DD-MON-RR HH24:MI:SS') unrecoverable_time
from v$datafile
where unrecoverable_time is not null;

cursor c2 is
select tablespace_name, logging ,status
from dba_tablespaces
where logging='NOLOGGING'
and contents <> 'TEMPORARY';

BEGIN
dbms_output.put_line('Checking for datafiles with unrecoverable activities');
FOR r1 in c1 loop
  dbms_output.put_line('FOUND ... File Name: '|| r1.name||' - '||'Unrecoverable Time: '|| r1.unrecoverable_time);
END LOOP;

dbms_output.put_line('Checking for tablespace(s) that are not being logged');
FOR r2 in c2 LOOP
  dbms_output.put_line('FOUND ... Tablespace Name: '|| r2.tablespace_name||' - '||'Logging: '|| r2.logging);
END LOOP;

END;
/

