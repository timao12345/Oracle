set head off
set pages 0
set long 9999999
set linesize 156
column DDL format a156

accept USERNAME prompt 'nome do usu�rio:'
/

spool c:\tmp\create_&USERNAME
SELECT DBMS_METADATA.GET_DDL('USER', '&USERNAME') || '/' DDL
FROM dual;
spool off;

spool c:\tmp\grantroles_&USERNAME
SELECT DBMS_METADATA.GET_GRANTED_DDL('ROLE_GRANT', '&USERNAME') || '/' DDL
FROM dual;
spool off;

spool c:\tmp\grantsys_&USERNAME;
SELECT DBMS_METADATA.GET_GRANTED_DDL('SYSTEM_GRANT', '&USERNAME') || '/' DDL
FROM dual;
spool off;

spool c:\tmp\grantobj_&USERNAME
SELECT DBMS_METADATA.GET_GRANTED_DDL('OBJECT_GRANT', '&USERNAME') || '/' DDL
FROM dual;
spool off;

