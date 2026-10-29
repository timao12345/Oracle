Standby

SQL> SELECT APPLIED_SCN as "SCN APLICADO", APPLIED_TIME as "DATA APLICADA", LATEST_SCN as "PROXIMO SCN SER APLICADO" FROM V$LOGSTDBY_PROGRESS;

SCN APLICADO DATA APLICADA       PROXIMO SCN SER APLICADO
------------ ------------------- ------------------------
     1433958 29/01/2015 16:35:23                  1433961


Primario 

SQL> select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;
Enter value for scn_do_standby: 1433958
old   1: select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual
new   1: select to_char(scn_to_timestamp('1433958'),'DD/MM/YYYY HH24:MI:SS') from dual

TO_CHAR(SCN_TO_TIME
-------------------
29/01/2015 16:35:19



SQL>   2           case STATE
  3             when 'INITIALIZING' then 'Sess�o de logminer criada e inicio do COORDINATOR'
  4             when 'LOADING DICTIONARY' then 'SQL Apply carregando dicion�rio'
           when 'WAITING ON GAP'     then 'SQL Apply aguardando logs do primary'
  5    6             when 'APPLYING'            then 'SQL Apply fazendo o mining e aplicando transa��es'
  7             when 'WAITING FOR DICTIONARY LOGS' then 'SQL Apply aguardando recebimento de archives com os logminers'
           when 'IDLE'   then 'SQL Apply aplicou todas as mudan�as recebidas'
           when 'SQL APPLY NOT ON'  then 'aplica��o parada' end AS StateDesc
     from v$logstdby_state;
  8    9   10
SESSION_ID STATE                       STATEDESC
---------- --------------------------- --------------------------------------------------------------
         1 IDLE                        SQL Apply aplicou todas as mudan?as recebidas


DGMGRL> show configuration

Configuration - LONDON

  Protection Mode: MaxPerformance
  Databases:
    orcl  - Primary database
    stdby - Logical standby database

Fast-Start Failover: DISABLED

Configuration Status:
DISABLED


SQL> show parameter log_archive_dest_3

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
log_archive_dest_3                   string      location=/u01/app/oracle/archi
                                                 ve2_new/stdby, valid_for=(ONLI
                                                 
												 NE_LOGFILE,ALL_ROLES)


												 
SQL> select instance_name from v$instance;

INSTANCE_NAME
----------------
stdby

SQL> ALTER SYSTEM SET log_archive_dest_3='location=/u01/app/oracle/archive2/stdby, valid_for=(ONLINE_LOGFILE,ALL_ROLES)' scope=both;

System altered.


SQL> select instance_name from v$instance;

INSTANCE_NAME
----------------
orcl

DGMGRL> show database stdby standbyarchivelocation
StandbyArchiveLocation = '/u01/app/oracle/archive2_new/stdby'

DGMGRL> edit database stdby set property StandbyArchiveLocation = '/u01/app/oracle/archive2/stdby';
Property "standbyarchivelocation" updated

DGMGRL> show database stdby standbyarchivelocation
StandbyArchiveLocation = '/u01/app/oracle/archive2/stdby'

DGMGRL> disable configuration
Disabled.

DGMGRL> enable configuration
Enabled.



												 
												 
		 