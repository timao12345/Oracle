Criando usuário

create user atu_syspergamum identified by pergamum;
GRANT CREATE SESSION TO atu_syspergamum;
GRANT EXP_FULL_DATABASE TO atu_syspergamum;
GRANT IMP_FULL_DATABASE TO atu_syspergamum;
GRANT EXECUTE ON SYS.DBMS_DEFER_IMPORT_INTERNAL TO atu_syspergamum;
GRANT EXECUTE ON SYS.DBMS_EXPORT_EXTENSION TO  atu_syspergamum ;                


--------------------------------------------------------------------------------------------

Criando Diretorios no RACNOVO

create or replace directory PERGAMUM as '+DATA_DM01/';
GRANT read, write ON DIRECTORY PERGAMUM TO atu_syspergamum;

Log
create directory logs as '/d01dmp/d01dmp/expdp/';
GRANT read, write ON DIRECTORY logs TO atu_syspergamum;


--------------------------------------------------------------------------------------------

Criando dblinks no RACNOVO

create database link dbl_atu_orahmgme connect to atu_syspergamum identified by pergamum using 'ORAHMGME';
create database link dbl_atu_oradsvme connect to atu_syspergamum identified by pergamum using 'ORADSVME';

--------------------------------------------------------------------------------------------

Criando diretorios no ORAHMGME
create or replace directory pergamum_to_orahmgme as '+STG_REFRESH/imp/atu_orahmgme';
GRANT read, write ON DIRECTORY pergamum_to_orahmgme TO atu_syspergamum;

create or replace directory logs as '/d01dmp/export/';
GRANT read, write ON DIRECTORY logs TO atu_syspergamum;

--------------------------------------------------------------------------------------------

Criando diretorios no ORADSVME
create or replace directory pergamum_to_oradsvme as '+STG_REFRESH/imp/atu_oradsvme';
GRANT read, write ON DIRECTORY pergamum_to_oradsvme TO atu_syspergamum;

create or replace directory logs as '/d01dmp/export/';
GRANT read, write ON DIRECTORY logs TO atu_syspergamum;


--------------------------------------------------------------------------------------------
Export 
nohup expdp \"/as sysdba\"  job_name=EXP_PERGAMUM logfile=LOGS:SYSPERGAMUM directory=PERGAMUM dumpfile=SYSPERGAMUM_%U parallel=12 SCHEMAS=SYSPERGAMUM status=60  COMPRESSION=ALL &
"
tail -f /d01dmp/d01dmp/expdp/SYSPERGAMUM.log

--------------------------------------------------------------------------------------------

ORAHMGME

set head off
set pages 1000
select 'exec dbms_file_transfer.put_file ('' PERGAMUM'','''||SUBSTR(column_value,12,100)||''',''PERGAMUM_TO_ORAHMGME'','''||SUBSTR(column_value,12,100)||''',''DBL_ATU_ORAHMGME'');' 
from table(LIST_FILES_DATA_DM01) where column_value like '+data_dm01/SYSPERGAMUM_%' 
order by 1;

ORADSVME

set head off
set pages 1000
select 'exec dbms_file_transfer.put_file ('' PERGAMUM'','''||SUBSTR(column_value,12,100)||''',''PERGAMUM_TO_ORADSVME'','''||SUBSTR(column_value,12,100)||''',''DBL_ATU_ORADSVME'');' 
from table(LIST_FILES_DATA_DM01) where column_value like '+data_dm01/SYSPERGAMUM_%' 
order by 1;

exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_01.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_01.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_02.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_02.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_03.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_03.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_04.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_04.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_05.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_05.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_06.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_06.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_07.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_07.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_08.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_08.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_09.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_09.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_10.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_10.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_11.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_11.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_12.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_12.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_13.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_13.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_14.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_14.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_15.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_15.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_16.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_16.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_17.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_17.dmp','DBL_ATU_ORAHMGME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_18.dmp','PERGAMUM_TO_ORAHMGME','SYSPERGAMUM_18.dmp','DBL_ATU_ORAHMGME');

18 rows selected.

exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_01.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_01.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_02.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_02.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_03.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_03.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_04.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_04.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_05.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_05.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_06.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_06.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_07.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_07.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_08.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_08.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_09.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_09.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_10.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_10.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_11.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_11.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_12.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_12.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_13.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_13.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_14.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_14.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_15.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_15.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_16.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_16.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_17.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_17.dmp','DBL_ATU_ORADSVME');
exec dbms_file_transfer.put_file (' PERGAMUM','SYSPERGAMUM_18.dmp','PERGAMUM_TO_ORADSVME','SYSPERGAMUM_18.dmp','DBL_ATU_ORADSVME');

18 rows selected.

CONN atu_syspergamum/pergamum;


1:21:16 sys@orahmgme > set lines 500
21:21:38 sys@orahmgme > set pages 50000
21:21:44 sys@orahmgme > spool on
21:21:50 sys@orahmgme > spool /tmp/constraint.sql

21:23:47 sys@orahmgme > spool /tmp/indexes.sql

21:23:47 sys@orahmgme > spool /tmp/tables.sql

21:23:47 sys@orahmgme > spool /tmp/resto.sql


SELECT 'ALTER TABLE '||OWNER||'.'||TABLE_NAME||' DROP CONSTRAINT '||CONSTRAINT_NAME||';' FROM DBA_CONSTRAINTS where OWNER = 'SYSPERGAMUM';


SELECT 'DROP '||OBJECT_TYPE||' '||OWNER||'.'||OBJECT_NAME||';' FROM DBA_OBJECTS WHERE OWNER='SYSPERGAMUM' AND OBJECT_TYPE='TABLE';

SELECT 'DROP '||OBJECT_TYPE||' '||OWNER||'.'||OBJECT_NAME||';' FROM DBA_OBJECTS WHERE OWNER='SYSPERGAMUM'; 





--------------------------------------------------------------------------------------------
Import

ORAHMGME
nohup impdp \"/as sysdba\"  job_name=IMP_ORAHMGME logfile=LOGS:ORAHMGME directory=PERGAMUM_TO_ORAHMGME dumpfile=SYSPERGAMUM_%U parallel=12 SCHEMAS=SYSPERGAMUM status=60 &
"
ORADSVME
nohup impdp \"/as sysdba\"  job_name=IMP_ORADSVME logfile=LOGS:ORADSVME directory=PERGAMUM_TO_ORADSVME dumpfile=SYSPERGAMUM_%U parallel=12 SCHEMAS=SYSPERGAMUM status=60 &

--------------------------------------------------------------------------------------------


nohup expdp \"/as sysdba\"  job_name=EXP_ORAHMGME logfile=LOGS:EXP_ORAHMGME31072015 directory=EXP_REFRESH dumpfile=SYSPERGAMUM_%U parallel=12 SCHEMAS=SYSPERGAMUM status=60 &


Purge reciclebin
Dropar todos os objetos
Ver tablespace iguais e temps
profile
roles


impdp atach nome do job
kill job












sqlplus usuario/senha >bdms.out
set echo on
set timing on
exec dbms_file_transfer.put_file ('pergamum_to_orahmgme','ORAHMGME_01.dmp','DIRECTORY_DESTINO','NOME_DO_DUMP_NO_DESTINO','NOME_DO_DB_LINK');

