Restore da Base SABRECC - URGENTE
Classificação do chamado: Técnico
1. Banco de dados: ( ) SQL Server ( ) Mysql ( ) Postgres SQL ( X ) Oracle
2. Servidor: ORAFDBTB578A para o RESTORA1TB578H
3. Nome do banco: SABRECC
4. Nome do usuário: sabre(servidor original) - oracle (destino)
5. Local do arquivo de backup a ser restaurado: /u01/app/oracle/oradata

OBS: O restore não deve ser realizado no mesmo servidor, deve ser direcionado para o servidor RESTORA1TB578H. Atualmente a base esta armazenada em uma estrutura ASM, o restore deverá ser realizado para filesystem no caminho informado. Restaurar o banco de dados na data de 20/08/2014 19:00hs.
O servidor RESTORA1TB578H é utilizado somente para restore, caso haja alguma outra base em execução a mesma pode ser excluida.
Ao termino do restore enviar o log para que seja anexado ao processo de auditoria

****
1 - Shutdown  instancia TRAXDB
2 - Deletado arquivos em /oradata
3 - criar dumps /u01/app/oracle/admin/SABREMC
	mkdir adump bdump cdump udump
4 - criar oradata /u01/oradata/SABREMC  
	mkdir archivelog controlfile datafile onlinelog tempfile
3 - Criar instAncia SABRECC (USUARIO ORACLE)
3 - SET NEW NAME //u01/oradata/SABRECC/datafile
4 - Criar lista de fitas necessárias 05/01/2014 14:30hs


***
export ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
export ORACLE_SID=SABRECC
export PATH=$PATH/usr/bin:/u01/app/oracle/product/10.2.0/db_1/bin




***criação dumps
[oracle@RESTORA1TB578H CARGO]$ pwd
/u01/app/oracle/admin/SABRECC

***criado oradata
[oracle@RESTORA1TB578H SABRECC]$ ls
archivelog  controlfile  datafile  onlinelog  tempfile


***init em /u01/app/oracle/product/10.2.0/db_1/dbs
*.archive_lag_target=0
*.audit_file_dest='/u01/app/oracle/admin/SABRECC/adump'
*.background_dump_dest='/u01/app/oracle/admin/SABRECC/bdump'
*.cluster_database=FALSE
*.compatible='10.2.0.3.0'
*.control_file_record_keep_time=15
*.control_files='/u01/oradata/SABRECC/controlfile/control01.dbf'#Restore Controlfile
*.core_dump_dest='/u01/app/oracle/admin/SABRECC/cdump'
*.cursor_sharing='FORCE'
*.db_block_size=8192
*.db_create_file_dest='/u01/oradata'
*.db_domain=''
*.db_file_multiblock_read_count=32
*.db_name='SABRECC'
*.db_recovery_file_dest='/u01/oradata/SABRECC/archivelog'
*.db_recovery_file_dest_size=53687091200
*.db_unique_name='SABRECC'
*.log_archive_format='%t_%s_%r.dbf'
*.log_archive_max_processes=10
*.log_archive_min_succeed_dest=1
*.open_cursors=300
*.optimizer_index_caching=20
*.optimizer_index_cost_adj=30
*.pga_aggregate_target=1073741824
*.processes=250
*.remote_login_passwordfile='exclusive'
*.session_cached_cursors=80
*.sessions=250
*.sga_target=2147483648
*.undo_tablespace='UNDOTBS1'
*.user_dump_dest='/u01/app/oracle/admin/SABRECC/udump'


[oracle@RESTORA1TB578H dbs]$ export ORACLE_SID=SABRECC
[oracle@RESTORA1TB578H dbs]$ sqlplus / as sysdba

SQL*Plus: Release 10.2.0.4.0 - Production on Wed May 7 16:26:17 2014

Copyright (c) 1982, 2007, Oracle.  All Rights Reserved.

Connected to an idle instance.

SQL> startup nomount;
ORACLE instance started.

Total System Global Area 2147483648 bytes
Fixed Size                  2085320 bytes
Variable Size             486542904 bytes
Database Buffers         1644167168 bytes
Redo Buffers               14688256 bytevi
***dados log backup
#INFO# : 20140819-22h04   : Script Started
#INFO# : Script Name      : /opt/ScriptsNBU/rman/DB_FULL_ALL_BKP.sh
#INFO# : Instances to Bkp : --->> PONTODB1 CARGODB1 CLMDB1 TRAXDB1 FISCALDB1 OSBPEL1 SABREMC1 SABRECC1 SABRELM1 ORADB1 SOADB1 TRXT4DB1  <<---
#INFO# : TEST MODE        : off
#INFO# : # ###################### START of Script Parameters ###################### #
#INFO# : RMAN_LOG_FILE    : /opt/ScriptsNBU/rman/Logs/Dly_DB_FULL_ALL_BKP-ORAFDBTB578A.servicos.20140819-22h04.31379.out
#INFO# : NB_ORA_SERV      : ipbtbms1
#INFO# : NB_ORA_FULL      : 1
#INFO# : NB_ORA_INCR      : 0
#INFO# : NB_ORA_CINC      : 0
#INFO# : NB_ORA_CLASS     : TB_AZL_D_OR_D_DIA_22_01
#INFO# : NB_ORA_POLICY    : TB_AZL_D_OR_D_DIA_22_01
#INFO# : NB_ORA_SCHED     :
#INFO# : NB_ORA_PC_SCHED  : FullDia
#INFO# : NB_ORA_CLIENT    : ORAFDBTB578A.servicos
#INFO# : Backup Type   : Full Backup Requested
#INFO# : Backup Level     : 0
#INFO# : # ###################### END   of Script Parameters ###################### #
#
#
#INFO# : 20140819-22h04   : Starting Bkp of  : -------->>>>> PONTODB1 <<<<<--------
#INFO# : Checking if LIBOBK is Linked to Netbackup Library for Oracle.
#INFO# : lrwxrwxrwx 1 ponto oinstall        36 Apr 27 01:19 libobk.so -> /usr/openv/netbackup/bin/libobk.so64
#INFO# : Checking if Database Is Enterprise or Not:     [NotENT-vv]cat: -: Bad file descriptor




***validar nome do control na produção
export NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS'
rman target /
list backup of controlfile

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ --------------------
18162   Full    4.50M      SBT_TAPE    00:00:08     20-AUG-2014 04:21:45
        BP Key: 18162   Status: AVAILABLE  Compressed: YES  Tag: TAG20140820T042137
        Handle: cntrl_18844_1_856066897   Media: TBA072
  Control File Included: Ckp SCN: 750523015    Ckp time: 20-AUG-2014 04:21:37



***restore controlfile
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=SABRECC
rman target /

startup force nomount;

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
restore controlfile to '/u01/oradata/SABRECC/controlfile/control01.dbf' from 'cntrl_22674_1_864815834';
release channel c1;
}

alter database mount;
crosscheck archivelog all;
delete expired archivelog all; 

***acompanhar log da ferramenta
/usr/openv/netbackup/logs/user_ops/dbext/logs

***gerar set newname na produção
select 'SET NEWNAME FOR DATAFILE '||FILE#||' to '|| chr(39) || name || chr(39)||';' from v$datafile; 
select 'SET NEWNAME FOR TEMPFILE '||FILE#||' to '|| chr(39) || name || chr(39)||';' from v$tempfile; 

***restore

#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=SABRECC
rman target / msglog=/home/oracle/restore_tape_SABRECC.log << EOF
run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
SET NEWNAME FOR DATAFILE 1 to '/u01/oradata/SABRECC/datafile/system.380.820550317';
SET NEWNAME FOR DATAFILE 2 to '/u01/oradata/SABRECC/datafile/undotbs1.379.820550317';
SET NEWNAME FOR DATAFILE 3 to '/u01/oradata/SABRECC/datafile/sysaux.378.820550317';
SET NEWNAME FOR DATAFILE 4 to '/u01/oradata/SABRECC/datafile/users.381.820550325';
SET NEWNAME FOR DATAFILE 5 to '/u01/oradata/SABRECC/datafile/undotbs2.429.820550317';
SET NEWNAME FOR DATAFILE 6 to '/u01/oradata/SABRECC/datafile/sabre_data.382.820550317';
SET NEWNAME FOR DATAFILE 7 to '/u01/oradata/SABRECC/datafile/sabre_data.404.830704927';
SET NEWNAME FOR DATAFILE 8 to '/u01/oradata/SABRECC/datafile/sabre_data.506.834675095';
SET NEWNAME FOR TEMPFILE 1 to '/u01/oradata/SABRECC/tempfile/temp.388.836930759';
SET NEWNAME FOR TEMPFILE 2 to '/u01/oradata/SABRECC/tempfile/temp.504.836930827';
SET NEWNAME FOR TEMPFILE 5 to '/u01/oradata/SABRECC/tempfile/temp3.503.836928065';
restore database;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
release CHANNEL c2;
release CHANNEL c3;
release CHANNEL c4;
}
EOF

***catalogar peças de archive
arc_SABRECC_SABRECC1_18845_1_856081466
arc_SABRECC_SABRECC1_18846_1_856088364
arc_SABRECC_SABRECC1_18847_1_856095474 
arc_SABRECC_SABRECC1_18848_1_856102567
arc_SABRECC_SABRECC1_18849_1_856109800
arc_SABRECC_SABRECC1_18850_1_856117025
arc_SABRECC_SABRECC1_18851_1_856121748


CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01)";  

run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18845_1_856081466';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18846_1_856088364';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18847_1_856095474';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18848_1_856102567';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18849_1_856109800';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18850_1_856117025';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_SABRECC_SABRECC1_18851_1_856121748';
}


***recover
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=SABRECC
rman target / msglog=/home/oracle/recover_tape_SABRECC.log << EOF
run {
allocate channel c1 type 'sbt_tape';
SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01';
set until time "to_date('28-11-2014 10:15:00','dd-mm-yyyy hh24:mi:ss')";
recover database;
release channel c1;
}
EOF


***andamento
SELECT sid, serial#, opname, sofar, totalwork,
      round(sofar/totalwork*100,2) "% Complete", time_remaining
FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
  AND opname NOT LIKE 'RMAN: aggregate%'
  AND sofar <> totalwork
  AND totalwork != 0;


***acompanhar log da ferramenta
/usr/openv/netbackup/logs/user_ops/dbext/logs


*** rename logfile
col member format a60
set lines 200
SQL> select * from v$logfile order by 1;

    GROUP# STATUS  TYPE    MEMBER                                                       IS_
---------- ------- ------- ------------------------------------------------------------ ---
         1         ONLINE  +DGDATA02/sabrecc/onlinelog/group_1.386.820551165            NO
         2         ONLINE  +DGDATA02/sabrecc/onlinelog/group_2.383.820551167            NO
         3         ONLINE  +DGDATA02/sabrecc/onlinelog/group_3.384.820551167            NO
         4         ONLINE  +DGDATA02/sabrecc/onlinelog/group_4.387.820551169            NO
         5         ONLINE  +DGDATA02/sabrecc/onlinelog/group_5.430.820551169            NO
         6         ONLINE  +DGDATA02/sabrecc/onlinelog/group_6.431.820551171            NO
         7         ONLINE  +DGDATA02/sabrecc/onlinelog/group_7.432.820551171            NO
         8         ONLINE  +DGDATA02/sabrecc/onlinelog/group_8.433.820551171            NO



***correção
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_1.386.820551165'  to '/u01/oradata/SABRECC/onlinelog/redo01.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_2.383.820551167'  to '/u01/oradata/SABRECC/onlinelog/redo02.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_3.384.820551167'  to '/u01/oradata/SABRECC/onlinelog/redo03.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_4.387.820551169'  to '/u01/oradata/SABRECC/onlinelog/redo04.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_5.430.820551169'  to '/u01/oradata/SABRECC/onlinelog/redo05.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_6.431.820551171'  to '/u01/oradata/SABRECC/onlinelog/redo06.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_7.432.820551171'  to '/u01/oradata/SABRECC/onlinelog/redo07.rdo';
alter database rename file '+DGDATA02/sabrecc/onlinelog/group_8.433.820551171'  to '/u01/oradata/SABRECC/onlinelog/redo08.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_1.283.857757411'  to '/u01/oradata/SABRECC/onlinelog/redo09.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_2.284.857757415'  to '/u01/oradata/SABRECC/onlinelog/redo10.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_3.287.857757421'  to '/u01/oradata/SABRECC/onlinelog/redo11.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_4.288.857757425'  to '/u01/oradata/SABRECC/onlinelog/redo12.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_5.285.857757429'  to '/u01/oradata/SABRECC/onlinelog/redo13.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_6.406.857757435'  to '/u01/oradata/SABRECC/onlinelog/redo14.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_7.407.857757441'  to '/u01/oradata/SABRECC/onlinelog/redo15.rdo';
alter database rename file '+DGDATA01/sabrecc/onlinelog/group_8.408.857757445'  to '/u01/oradata/SABRECC/onlinelog/redo16.rdo';

SQL> select * from v$logfile order by 1;


    GROUP# STATUS  TYPE    MEMBER                                                       IS_
---------- ------- ------- ------------------------------------------------------------ ---
         1         ONLINE  /u01/oradata/SABRECC/onlinelog/redo09.rdo                    NO
         1         ONLINE  /u01/oradata/SABRECC/onlinelog/redo01.rdo                    NO
         2         ONLINE  /u01/oradata/SABRECC/onlinelog/redo10.rdo                    NO
         2         ONLINE  /u01/oradata/SABRECC/onlinelog/redo02.rdo                    NO
         3         ONLINE  /u01/oradata/SABRECC/onlinelog/redo03.rdo                    NO
         3         ONLINE  /u01/oradata/SABRECC/onlinelog/redo11.rdo                    NO
         4         ONLINE  /u01/oradata/SABRECC/onlinelog/redo04.rdo                    NO
         4         ONLINE  /u01/oradata/SABRECC/onlinelog/redo12.rdo                    NO
         5         ONLINE  /u01/oradata/SABRECC/onlinelog/redo13.rdo                    NO
         5         ONLINE  /u01/oradata/SABRECC/onlinelog/redo05.rdo                    NO
         6         ONLINE  /u01/oradata/SABRECC/onlinelog/redo14.rdo                    NO

    GROUP# STATUS  TYPE    MEMBER                                                       IS_
---------- ------- ------- ------------------------------------------------------------ ---
         6         ONLINE  /u01/oradata/SABRECC/onlinelog/redo06.rdo                    NO
         7         ONLINE  /u01/oradata/SABRECC/onlinelog/redo07.rdo                    NO
         7         ONLINE  /u01/oradata/SABRECC/onlinelog/redo15.rdo                    NO
         8         ONLINE  /u01/oradata/SABRECC/onlinelog/redo16.rdo                    NO
         8         ONLINE  /u01/oradata/SABRECC/onlinelog/redo08.rdo                    NO



***validação 
alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';
select * from v$recover_file
select * from v$recovery_progress;

SQL> select * from v$recover_file;
 show p

     FILE# ONLINE  ONLINE_ ERROR                                                                CHANGE# TIME
---------- ------- ------- ----------------------------------------------------------------- ---------- -------------------
         1 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         2 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         3 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         4 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         5 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         6 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         7 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01
         8 ONLINE  ONLINE                                                                     863854342 28-11-2014 10:15:01

8 rows selected.



***erro
RMAN> alter database open resetlogs;

RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of alter db command at 03/05/2014 22:34:36
ORA-00600: internal error code, arguments: [kgeade_is_0], [], [], [], [], [], [], []

ORA-00600: internal error code, arguments: [kgeade_is_0], [], [], [], [], [],
https://support.oracle.com/epmos/faces/SearchDocDisplay?_adf.ctrl-state=130fxi67wv_9&_afrLoop=124084703516221



***erro FALTA DE ESPAÇO NO SERVIDOR DE BACKUP

ORA-19870: error reading backup piece dbbkp_SABREMC_SABREMC1_15127_1_844999136
ORA-19507: failed to retrieve sequential file, handle="dbbkp_SABREMC_SABREMC1_15127_1_844999136", parms=""
ORA-27029: skgfrtrv: sbtrestore returned error
ORA-19511: Error received from media manager layer, error text:
   Failed to process backup file <dbbkp_SABREMC_SABREMC1_15127_1_844999136

***erro FALTA DE ESPAÇO NO DB_RECOVER_FILE_DEST
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of recover command at 05/08/2014 17:32:20
RMAN-06561: available space must be larger than 1129958 kb


***listar backups no servidor
/usr/openv/netbackup/bin/bplist -C ORAFDBTB578A.servicos -t 4 -l -R /



RMAN> list archivelog from time "to_date('28/11/2014 10:50:00', 'dd/mm/yyyy hh24:mi:ss')";


List of Archived Log Copies
Key     Thrd Seq     S Low Time  Name
------- ---- ------- - --------- ----
101121  1    12528   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12528.982.864821875
101124  1    12529   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12529.1654.864821889
101130  1    12530   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12530.414.864828969
101132  1    12531   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12531.2975.864828979
101136  1    12532   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12532.3514.864836079
101142  1    12533   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_1_seq_12533.3261.864836097
101122  2    11697   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11697.578.864821875
101125  2    11698   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11698.1142.864821889
101129  2    11699   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11699.1480.864828965
101134  2    11700   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11700.1949.864828983
101138  2    11701   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11701.2983.864836083
101140  2    11702   A 28-NOV-14 +DGARCH/sabrecc/archivelog/2014_11_28/thread_2_seq_11702.1126.864836097

RMAN> backup archivelog from  time "to_date('28/11/2014 10:00:00', 'dd/mm/yyyy hh24:mi:ss')" format '/work-tmp/sabre/archivesabre.arc' reuse;


RMAN> catalog backuppiece '/u01/oradata/SABRECC/archivelog/SABRECC/archivelog/2014_11_28/archivesabre.arc' ;

using target database control file instead of recovery catalog
cataloged backuppiece
backup piece handle=/u01/oradata/SABRECC/archivelog/SABRECC/archivelog/2014_11_28/archivesabre.arc recid=21973 stamp=864842965

RMAN> restore archivelog from time  "to_date('28/11/2014 10:00:00', 'dd/mm/yyyy hh24:mi:ss')" ;

Starting restore at 28-NOV-14
allocated channel: ORA_SBT_TAPE_1
channel ORA_SBT_TAPE_1: sid=270 devtype=SBT_TAPE
channel ORA_SBT_TAPE_1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)
allocated channel: ORA_SBT_TAPE_2
channel ORA_SBT_TAPE_2: sid=261 devtype=SBT_TAPE
channel ORA_SBT_TAPE_2: Veritas NetBackup for Oracle - Release 7.5 (2013061020)
allocated channel: ORA_SBT_TAPE_3
channel ORA_SBT_TAPE_3: sid=260 devtype=SBT_TAPE
channel ORA_SBT_TAPE_3: Veritas NetBackup for Oracle - Release 7.5 (2013061020)
allocated channel: ORA_SBT_TAPE_4
channel ORA_SBT_TAPE_4: sid=259 devtype=SBT_TAPE
channel ORA_SBT_TAPE_4: Veritas NetBackup for Oracle - Release 7.5 (2013061020)







