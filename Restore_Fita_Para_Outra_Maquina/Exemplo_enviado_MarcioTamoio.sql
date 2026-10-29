Colocar set until time no restore tb.


Restore de Teste - Base OSBPEL
Classificação do chamado: Técnico
1. Banco de dados: ( ) SQL Server ( ) Mysql ( ) Postgres SQL ( X ) Oracle
2. Servidor: ORAFDBTB578A para o RESTORA1TB578H
3. Nome do banco: OSBPEL
4. Nome do usuário: osbpel(servidor original) - oracle (destino)
5. Local do arquivo de backup a ser restaurado: /u01/app/oracle/oradata

OBS: O restore não deve ser realizado no mesmo servidor, deve ser direcionado para o servidor RESTORA1TB578H. Atualmente a base esta armazenada 
em uma estrutura ASM, o restore deverá ser realizado para filesystem no caminho informado. Restaurar o banco de dados na data de 17/09/2014 13:30hs.
O servidor RESTORA1TB578H é utilizado somente para restore, caso haja alguma outra base em execução a mesma pode ser excluida.
Ao termino do restore enviar o log do RMAN para que seja anexado ao processo de auditoria


***criação dumps
/u01/app/oracle/admin/OSBPEL
mkdir adump  bdump  cdump  udump

***criação oradata
/u01/oradata/OSBPEL
mkdir  archivelog controlfile datafile onlinelog tempfile

export ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
export PATH=$PATH/usr/bin:/u01/app/oracle/product/10.2.0/db_1/bin


***initOSBPEL.ora
audit_file_dest='/u01/app/oracle/admin/OSBPEL/adump'
audit_trail='DB'
background_dump_dest='/u01/app/oracle/admin/OSBPEL/bdump'
cluster_database=FALSE
compatible='10.2.0.4.0'
control_file_record_keep_time=90
control_files='/u01/oradata/OSBPEL/controlfile/cntrl01.dbf'
core_dump_dest='/u01/app/oracle/admin/OSBPEL/cdump'
db_block_size=8192
db_cache_size=1048576000
db_create_file_dest='/u01/oradata/OSBPEL'
db_domain=''
db_file_multiblock_read_count=16
db_name='OSBPEL'
db_writer_processes=2
java_pool_size=16777216
job_queue_processes=10
large_pool_size=33554432
log_archive_dest_1='LOCATION=/u01/oradata/OSBPEL/archivelog'
log_buffer=20971520
open_cursors=4096
optimizer_index_caching=25
optimizer_index_cost_adj=1
pga_aggregate_target=838860800
processes=1024
remote_login_passwordfile='exclusive'
sga_max_size=0
sga_target=0
shared_pool_size=838860800
undo_management='AUTO'
undo_tablespace='TSUNDO1'
user_dump_dest='/u01/app/oracle/admin/OSBPEL/udump'


***listar fitas
select distinct MEDIA
from v$backup_piece
where START_TIME between to_date('05/01/2014 00:00:01','dd/mm/yyyy hh24:mi:ss')
                     and to_date('06/01/2014 23:59:00','dd/mm/yyyy hh24:mi:ss')


***dados log backup
#INFO# : 20140916-23h08   : Script Started
#INFO# : Script Name      : /opt/ScriptsNBU/rman/DB_FULL_ALL_BKP.sh
#INFO# : Instances to Bkp : --->> PONTODB1 CARGODB1 CLMDB1 TRAXDB1 FISCALDB1 OSBPEL1 SABREMC1 SABRECC1 SABRELM1 ORADB1 SOADB1 TRXT4DB1  <<---
#INFO# : TEST MODE        : off
#INFO# : # ###################### START of Script Parameters ###################### #
#INFO# : RMAN_LOG_FILE    : /opt/ScriptsNBU/rman/Logs/Dly_DB_FULL_ALL_BKP-ORAFDBTB578A.servicos.20140916-23h08.17568.out
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
#INFO# : 20140916-23h08   : Starting Bkp of  : -------->>>>> PONTODB1 <<<<<--------
#INFO# : Checking if LIBOBK is Linked to Netbackup Library for Oracle.
#INFO# : lrwxrwxrwx 1 ponto oinstall        36 Apr 27 01:19 libobk.so -> /usr/openv/netbackup/bin/libobk.so64
#INFO# : Checking if Database Is Enterprise or Not:     [NotENT-vv]cat: -: Bad file descriptor


***script restore
ora10204

****na produção
allocate channel for maintenance device type sbt;
crosscheck backup completed after 'sysdate - 65';

Starting backup at 17/09/2014 04:05:35
channel ch_s: starting compressed full datafile backupset
channel ch_s: specifying datafile(s) in backupset
including current control file in backupset
channel ch_s: starting piece 1 at 17/09/2014 04:05:36
channel ch_s: finished piece 1 at 17/09/2014 04:06:21
piece handle=cntrl_24466_1_858485135 tag=TAG20140917T040535 comment=API Version 2.0,MMS Version 5.0.0.0
channel ch_s: backup set complete, elapsed time: 00:00:46
Finished backup at 17/09/2014 04:06:21


***restore controlfile  30/03 as 07:39
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=ELADBG
rman target /

startup force nomount;

largepool

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
restore controlfile to '/u01/oradata/OSBPEL/controlfile/cntrl01.dbf' from 'cntrl_24466_1_858485135';
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
startup mount;
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=OSBPEL
rman target / msglog=/home/oracle/restore_tape_OSBPEL.log << EOF
run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';

SET NEWNAME FOR DATAFILE 1 to '/u01/oradata/OSBPEL/datafile/system.273.755795505';
SET NEWNAME FOR DATAFILE 2 to '/u01/oradata/OSBPEL/datafile/tsundo1.274.755795505';
SET NEWNAME FOR DATAFILE 3 to '/u01/oradata/OSBPEL/datafile/sysaux.276.755795503';
SET NEWNAME FOR DATAFILE 4 to '/u01/oradata/OSBPEL/datafile/tsundo2.272.755795505';
SET NEWNAME FOR DATAFILE 5 to '/u01/oradata/OSBPEL/datafile/ts_oraosb_dados.275.755795503';
SET NEWNAME FOR DATAFILE 6 to '/u01/oradata/OSBPEL/datafile/orabpel.269.755795505';
SET NEWNAME FOR DATAFILE 7 to '/u01/oradata/OSBPEL/datafile/oraesb_ts.268.755795511';
SET NEWNAME FOR DATAFILE 8 to '/u01/oradata/OSBPEL/datafile/prod_mds.260.755795519';
SET NEWNAME FOR DATAFILE 9 to '/u01/oradata/OSBPEL/datafile/prod_soainfra.270.755795505';
SET NEWNAME FOR DATAFILE 10 to '/u01/oradata/OSBPEL/datafile/prod_ias_orasdpm.271.755795505';
SET NEWNAME FOR TEMPFILE 1 to '/u01/oradata/OSBPEL/tempfile/tstemp.262.755795767';
SET NEWNAME FOR TEMPFILE 2 to '/u01/oradata/OSBPEL/tempfile//prod_ias_temp.263.755795769';

set until time "to_date('17-09-2014 13:30:00','dd-mm-yyyy hh24:mi:ss')";
restore database;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
release CHANNEL c2;
release CHANNEL c3;
release CHANNEL c4;
}
EOF
nohup ./restore_tape_TRAXDB.sh &



***catalogar peças de archive
arc_OSBPEL_OSBPEL1_24467_1_858500389
arc_OSBPEL_OSBPEL1_24468_1_858507460
arc_OSBPEL_OSBPEL1_24469_1_858514636
arc_OSBPEL_OSBPEL1_24470_1_858521788

run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_OSBPEL_OSBPEL1_24467_1_858500389';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_OSBPEL_OSBPEL1_24468_1_858507460';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_OSBPEL_OSBPEL1_24469_1_858514636';
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'arc_OSBPEL_OSBPEL1_24470_1_858521788';
}



***recover
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=OSBPEL 
rman target / msglog=/home/oracle/recover_tape_OSBPEL.log << EOF
run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01';
set until time "to_date('17-09-2014 13:30:00','dd-mm-yyyy hh24:mi:ss')";
recover database;
release channel c1;
}
EOF

***exemplo backup/list archive na ORIGEM
erro
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of recover command at 04/08/2014 19:39:45
RMAN-06054: media recovery requesting unknown log: thread 1 seq 2544 lowscn 2697731088

RMAN>

Recovery Manager complete.


list backup of archivelog sequence=2544 thread 1;

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
restore archivelog from logseq=2544 until logseq=2548 thread 1;
restore archivelog from logseq=2574 until logseq=2580 thread 2;
release channel c1;
}


***backup archives faltantes
run
{
allocate channel c1 device type disk format '/home/trax/%d_DB_%I_%p_%s.bkp' maxpiecesize 2G;
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG  FROM SEQUENCE 2544 UNTIL SEQUENCE 2548   THREAD 1 ;
BACKUP AS COMPRESSED BACKUPSET ARCHIVELOG  FROM SEQUENCE 2574 UNTIL SEQUENCE 2580   THREAD 2 ;
release channel c1;
}


***catalog
CATALOG BACKUPPIECE '/u01/oradata/traxdb/TRAXDB_DB_1924526956_1_25870.bkp';
CATALOG BACKUPPIECE '/u01/oradata/traxdb/TRAXDB_DB_1924526956_1_25871.bkp';
CATALOG BACKUPPIECE '/u01/oradata/traxdb/TRAXDB_DB_1924526956_1_25872.bkp';
CATALOG BACKUPPIECE '/u01/oradata/traxdb/TRAXDB_DB_1924526956_1_25873.bkp';

***RECOVER PARTE2
run{
set until time "to_date('30-03-2014 07:39:00','dd-mm-yyyy hh24:mi:ss')";
recover database;
}


***acompanhar log da ferramenta
/usr/openv/netbackup/logs/user_ops/dbext/logs

SELECT sid, serial#, opname, sofar, totalwork,
      round(sofar/totalwork*100,2) "% Complete", time_remaining
FROM v$session_longops
WHERE opname LIKE 'RMAN:%'
  AND opname NOT LIKE 'RMAN: aggregate%'
  AND sofar <> totalwork
  AND totalwork != 0;


***correção
set lines 200
col member format a50
select * from v$logfile;

    GROUP# STATUS  TYPE    MEMBER                                             IS_
---------- ------- ------- -------------------------------------------------- ---
         1         ONLINE  +DGDATA01/osbpel/onlinelog/group_1.256.755795759   NO
         2         ONLINE  +DGDATA01/osbpel/onlinelog/group_2.257.755795759   NO
         3         ONLINE  +DGDATA01/osbpel/onlinelog/group_3.264.755795761   NO
         4         ONLINE  +DGDATA01/osbpel/onlinelog/group_4.265.755795761   NO
         5         ONLINE  +DGDATA01/osbpel/onlinelog/group_5.259.755795763   NO
         6         ONLINE  +DGDATA01/osbpel/onlinelog/group_6.266.755795763   NO
         7         ONLINE  +DGDATA01/osbpel/onlinelog/group_7.258.755795765   NO
         8         ONLINE  +DGDATA01/osbpel/onlinelog/group_8.261.755795765   NO
         1         ONLINE  +DGDATA02/osbpel/onlinelog/group_1.479.857758519   NO
         2         ONLINE  +DGDATA02/osbpel/onlinelog/group_2.480.857758523   NO
         3         ONLINE  +DGDATA02/osbpel/onlinelog/group_3.457.857758531   NO
         4         ONLINE  +DGDATA02/osbpel/onlinelog/group_4.456.857758531   NO
         5         ONLINE  +DGDATA02/osbpel/onlinelog/group_5.455.857758531   NO
         6         ONLINE  +DGDATA02/osbpel/onlinelog/group_6.454.857758533   NO
         7         ONLINE  +DGDATA02/osbpel/onlinelog/group_7.435.857758533   NO
         8         ONLINE  +DGDATA02/osbpel/onlinelog/group_8.434.857758535   NO


8 rows selected.

alter database rename file '+DGDATA01/traxdb/onlinelog/group_1.303.759861217'  to '/u01/oradata/traxdb/onlinelog/redo1.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo2.rdo'  to '/u01/oradata/traxdb/onlinelog/redo2.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo3.rdo'  to '/u01/oradata/traxdb/onlinelog/redo3.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo4.rdo'  to '/u01/oradata/traxdb/onlinelog/redo4.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo5.rdo'  to '/u01/oradata/traxdb/onlinelog/redo5.rdo';
alter database rename file '+DGDATA01/traxdb/onlinelog/group_6.301.759861471'  to '/u01/oradata/traxdb/onlinelog/redo6.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo7.rdo'  to '/u01/oradata/traxdb/onlinelog/redo7.rdo';
alter database rename file '/u01/oradata/cargodb/onlinelog/redo8.rdo'  to '/u01/oradata/traxdb/onlinelog/redo8.rdo';


***alter database open resetlogs;








