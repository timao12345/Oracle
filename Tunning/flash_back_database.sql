SQL> select instance_name, status, host_name from v$instance;

INSTANCE_NAME    STATUS       HOST_NAME
---------------- ------------ ----------------------------------------------------------------
celpahom         OPEN         CLPBHSTBCS01

SQL> SELECT DBID, NAME, OPEN_MODE, FLASHBACK_ON FROM V$DATABASE;

      DBID NAME      OPEN_MODE  FLASHBACK_ON
---------- --------- ---------- ------------------
2575108357 CELPAHOM  READ WRITE NO


SQL> archive log list;
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            +EUF
Oldest online log sequence     1365
Next log sequence to archive   1372
Current log sequence           1372


NOME            STATUS       TOTAL_GB   LIVRE_GB   USADO_GB
--------------- ---------- ---------- ---------- ----------
DATA            CONNECTED       11538        613      10925
EUF             CONNECTED         961        308        653

CLPBHSTBCS01 
CLPBHSTBCS01

. oraenv
celpahom
sqlplus "/as sysdba"
shutdown immediate;

Comandos:
 
. oraenv
celpahom
 
sqlplus "/as sysdba" 
spool /home/oracle/sca/patch_celpa/job_queue_processes_antes.log
show parameter job_queue_processes
alter system set job_queue_processes=0;
alter system set job_queue_processes=24;
spool off

. oraenv
celpahom
sqlplus "/as sysdba" 
spool /home/oracle/sca/patch_celpa/obj_invalidos.log
set lines 999
select owner, object_type, object_name from dba_objects where status='INVALID';
spool off


celpahom
lsnrctl stop LISTENER


sqlplus  "/as sysdba" 
set verify off
set lines 999
set pages 0
spool '/home/oracle/sca/patch_celpa/kill.sql'
select 'alter system kill session '''||SID||','||SERIAL#||''' immediate;' from v$session where username is not null;
spool off

verificar se criou o arquivo em /home/oracle/sca/patch_celpa/
 
sqlplus  "/as sysdba"
@/home/oracle/sca/patch_celpa/kill.sql



create pfile='/tmp/init.bkp.ora' from spfile;

alter system set db_recovery_file_dest='+EUF';
alter system set db_recovery_file_dest_size=50G;


SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG; --NESTE CASO NÃO PRECISA, JA ESTA
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=2880 SCOPE=BOTH;
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;

SQL> SELECT DBID, NAME, OPEN_MODE, FLASHBACK_ON FROM V$DATABASE;


SQL> SELECT DBID, NAME, OPEN_MODE, FLASHBACK_ON FROM V$DATABASE;

      DBID NAME      OPEN_MODE  FLASHBACK_ON
---------- --------- ---------- ------------------
2575108357 CELPAHOM  READ WRITE YES



NOME            STATUS       TOTAL_GB   LIVRE_GB   USADO_GB
--------------- ---------- ---------- ---------- ----------
DATA            CONNECTED       11538        613      10925
EUF             CONNECTED         961        308        653


SQL> create restore point before_path guarantee flashback database;

Restore point created.

  1* SELECT NAME, SCN, TIME, DATABASE_INCARNATION#, GUARANTEE_FLASHBACK_DATABASE,STORAGE_SIZE FROM V$RESTORE_POINT
SQL> /

NAME                                                                                                                                              SCN TIME                                                                        DATABASE_INCARNATION# GUA         STORAGE_SIZE
-------------------------------------------------------------------------------------------------------------------------------- -------------------- --------------------------------------------------------------------------- --------------------- --- --------------------
BEFORE_PATH                                                                                                                            11203997878251 21-NOV-14 08.13.29.000000000 PM                                                                 2 YES             15941632




SELECT NAME, SCN, TIME, DATABASE_INCARNATION#, GUARANTEE_FLASHBACK_DATABASE, STORAGE_SIZE FROM V$RESTORE_POINT WHERE GUARANTEE_FLASHBACK_DATABASE='YES';

	  

	  cd /home/oracle/sca/patch_celpa/
Ok
tar -xvf pat_celpa_41013a_banco.tar 
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41013a_banco.log
@dba_exec_rede.sql
spool off

Ok
tar -xvf pat_celpa_41020a_banco.tar
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41020a_banco.log
@dba_exec_rede.sql
spool off

Ok
tar -xvf pat_celpa_41027a_banco.tar
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41027a_banco.log
@dba_exec_rede.sql
spool off

Ok
tar -xvf pat_celpa_41103a_banco.tar
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41103a_banco.log
@dba_exec_rede.sql
spool off

Ok
tar -xvf pat_celpa_41110a_banco.tar
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41110a_banco.log
@dba_exec_rede.sql
Spool off

spool /home/oracle/sca/patch_celpa/pat_celpa_41117a_sys_banco.log
sqlplus / as sysdba
@dba_exec_sys.sql
spool off
Spoo of

Duas vezes
@dba_exec_sys.sql
spool off



tar -xvf pat_celpa_41117a_banco.tar
sqlplus / as sysdba
alter session set current_schema=REDEDES;
spool /home/oracle/sca/patch_celpa/pat_celpa_41117a_rede_banco.log
@dba_exec_rede.sql
spool off

spool /home/oracle/sca/patch_celpa/pat_celpa_41117a_sys_banco.log
sqlplus / as sysdba
@dba_exec_sys.sql
spool off



select
oldest_flashback_scn,
oldest_flashback_time,
retention_target,
estimated_flashback_size
from v$flashback_database_log;

select oldest_flashback_scn, oldest_flashback_time from v$flashback_database_log;