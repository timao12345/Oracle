-- desabilitar ou habilitar modo archivelog
--Habilitar
Shutdown
Startup mount
alter database archivelog;
alterdatabase open;

-- Desabilitar
Shutdown
Startup mount
Alter database noarchivelog; 
alter database open;

-- Procedimento para liberar a área de archive quando estourar o espaço em disco

[IMPORTANTE: CASO NÃO HAJA ESPAÇO PARA MOVIMENTAR OS ARCHIVES PARA OUTRO DISCO, 
DELETAR TODOS OS ARCHIVES EM DISCO E SOLICITAR AO TIME DE BACKUP UM BACKUP FULL]

rman target /
delete archivelog all;

DELETE ARCHIVELOG UNTIL time "SYSDATE - interval '48' hour" BACKED UP 1 TIMES to DEVICE TYPE sbt;

[CASO CONTRÁRIO, EXECUTAR O PROCEDIMENTO ABAIXO]

-- 1º Alterar a área de archives default do banco para outro disco e gerar um novo archive

alter system set log_archive_dest_1='LOCATION=/app/oracle/BIP/archive';

-- Irá gerar um archive das transações que estão armazenadas no redo current, liberando espaço de redo para o banco transacionar e efetuar o backup
alter system switch logfile; 

-- OU MOVER ALGUNS ARCHIVES PARA OUTRO DISCO

-- 3º Logar no RMAN e catalogar os archives que foram movidos
rman target /
catalog start with '/u01/app/oracle/backup';

-- 4º Checar a informação sobre os archives que estão no controlfile estão no disco
crosscheck archivelog all

-- Verifica os archives que já foram pra fita
set lines 2000
set pages 1000
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
SELECT DEST_ID,THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED,
case BACKUP_COUNT when 0 then 'Sem backup'
                  when 1 then '1 Backup feito'
                  when 2 then '2 Backup feito'
                  when 3 then '3 Backup feito'
                  ELSE 'Mais de 3 backups feitos' end as BACKUP_COUNT
FROM V$ARCHIVED_LOG WHERE first_time > SYSDATE -30 and DEST_ID=1 ORDER  BY first_time ASC;

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
SELECT DEST_ID,THREAD#, SEQUENCE#, NAME,FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED, BACKUP_COUNT
FROM GV$ARCHIVED_LOG
WHERE first_time > SYSDATE -10 and DEST_ID=1 and thread#=1
ORDER  BY 3 ASC;
--AND DELETED='NO'
--and APPLIED='YES'

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
SELECT DEST_ID,THREAD#, SEQUENCE#, NAME,FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED, BACKUP_COUNT
FROM GV$ARCHIVED_LOG
WHERE first_time > SYSDATE -10 and DEST_ID=2
ORDER  BY 3 ASC;

run {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL c4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
RESTORE ARCHIVELOG FROM TIME = "to_date('15/05/2026 12:00:00','DD/MM/YYYY HH24:MI:SS')"
UNTIL TIME = "to_date('18/05/2026 12:00:00','DD/MM/YYYY HH24:MI:SS')";
}

set archivelog destination to '/acfs_backup/orarcu_bkp';


run
{
set DBID=3325602173
ALLOCATE CHANNEL d1 DEVICE TYPE SBT_TAPE PARMS 'SBT_LIBRARY=/u02/app/oracle/product/19.0.0.0/dbhome_1/lib/libobk.so';
SET ARCHIVELOG DESTINATION TO '/u03/*';
restore archivelog logseq=100100;
RELEASE CHANNEL d1;
}


run
{
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
set DBID=3325602173
restore controlfile to '/u03' from autobackup;
release channel ch1;
}

run {
    allocate channel c1 type disk;
    set archivelog destination to '/replicacao/sync/MIDDLE/archives/';
    restore archivelog logseq=42445 thread 2;
}

run {
 allocate channel c1 type 'sbt_tape';
 SET ARCHIVELOG DESTINATION TO '/U02/netbackup';
 restore archivelog from logseq=100100 until logseq=100101;
release channel c1;
}

run {
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
SET ARCHIVELOG DESTINATION TO '/u02/netbackup';
RESTORE ARCHIVELOG FROM SEQUENCE 100218;
release channel ch1;
}



run
{allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
restore controlfile to '/u02/netbackup' from 'ctrl_dORAKPV_ua932k096_s1005897_p1_t1177157926';
release channel ch1;
}



run{
set DBID=3325602173
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'ENV=(TDPO_OPTFILE=/usr/openv/netbackup/bin/libobk.so64)' ;
restore controlfile to '/u03/' from 'ctrl_dORAKPV_ure32rtjj_s1007470_p1_t1177417331';
release channel ch1;
}

LD_LIBRARY_PATH=$ORACLE_HOME/lib
export ORACLE_BASE LD_LIBRARY_PATH


-- ///////// -- funcional
set DBID=3325602173
run {
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV, NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
restore controlfile to '/u03/control_file_01.bak' from 'ctrl_dORAKPVHM_ufj3am7dr_s11763_p1_t1185619387';
release channel ch1;
}

set DBID=3325602173
run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet,NB_ORA_SERV=lnxprd085,NB_ORA_POLICY=ORA_EXA_CS_KIPREV';
restore controlfile to '/u03/control01.dbf' from 'ctrl_dORAKPV_u7332uhsb_s1008867_p1_t1177503627';
release channel c1;
}

run
{
set DBID=3325602173
ALLOCATE CHANNEL d1 DEVICE TYPE SBT_TAPE PARMS 'SBT_LIBRARY=/u02/app/oracle/product/19.0.0.0/dbhome_1/lib/libobk.so';
restore controlfile to '/u03/control01.dbf' from 'ctrl_dORAKPV_u7332uhsb_s1008867_p1_t1177503627';
RELEASE CHANNEL d1;
}

-- ///////// --


run
{
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/tmp/%F';
set DBID=3325602173;
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
RESTORE CONTROLFILE FROM AUTOBACKUP maxdays 1;
release channel ch1;
}



run
{
allocate channel ch1 type 'sbt_tape' parms 'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=vmlnxhom015.rootbrasil.intranet)';
set DBID=3325602173
restore controlfile to '/u03/' from 'ctrl_dORAKPV_ua932k096_s1005897_p1_t1177157926';
release channel ch1;
}






RUN {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' PARMS'ENV=(NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085,NB_ORA_CLIENT=exacc01db01vmc01)';
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';

 BACKUP CURRENT CONTROLFILE;
 release channel c1;
}


set DBID=3325602173
run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_SERV=lnxprd085, NB_ORA_CLIENT=vmlnxhom015.rootbrasil.intranet';
restore controlfile to '/tmp/cntrl.bak' from 'ctrl_dORAKPV_ure32rtjj_s1007470_p1_t1177417331';
release channel c1;
}

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_SERV=lnxprd085, NB_ORA_CLIENT=vmlnxhom015.rootbrasil.intranet';
restore spfile to '/tmp/';
release channel c1;
}

run {
set controlfile autobackup format for device type DISK to '/tmp/%F';
ALLOCATE CHANNEL T1 DEVICE TYPE 'SBT_TAPE';
restore controlfile from autobackup MAXSEQ 5 MAXDAYS 1;
}

--Verifica local dos archives
select thread#, sequence#, dest_id, first_time, name from gv$archived_log where name is not null;

SYS@TRAX_ODS> archive log list
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            USE_DB_RECOVERY_FILE_DEST
Oldest online log sequence     120458
Next log sequence to archive   120461
Current log sequence           120461

show parameter DB_RECOVERY_FILE_DEST

--Verificar o disk group
SELECT NAME DISKGROUP, TOTAL_MB, FREE_MB, (TOTAL_MB-FREE_MB)/TOTAL_MB*100 PCT_UTILIZADO FROM V$ASM_DISKGROUP;

-- Após liberar espaço na área de archive o banco já irá transacionar normalmente, 
-- portanto devemos solicitar de imediato ao time de backup para realizar o backup dos archives .
 
 
-- Após o backup finalizar, validar se os archives realmente foram pra fita 

SELECT THREAD#, SEQUENCE#, ARCHIVED, DELETED, BACKUP_COUNT,name FROM GV$ARCHIVED_LOG where first_time > SYSDATE -15 and SEQUENCE#=7783; -- Verifica os archives que já foram pra fita

-- Caso os archives que estão em disco já tenham ido para a fita, executar o comando abaixo para deletar todos archives que já foram pra fita.

-- Deleta os archives que já foram para fita pelo menos uma vez  
delete archivelog all backed up 1 times to device type sbt; 

Last 12 hours:

delete force archivelog until time  'sysdate -1';

Last 6 hours:

delete force archivelog until time  'sysdate -1/4';

Last 1 hour

delete force archivelog until time  'sysdate -1/24';

Last 3 days:

delete force archivelog until time  'sysdate -3';

DELETE NOPROMPT ARCHIVELOG until time  'sysdate -1';

[IMPORTANTE: NÃO ESQUECER DE VOLTAR O PARÃMETRO LOG_ARCHIVE_DEST PARA A ÁREA DEFAULT]

alter system set log_archive_dest_1='LOCATION=+RECOC2';


LOCATION=+RECOC2 VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=ORAKPVHM
__________________________________________________________________________________________________________________

-- Caso o banco utilize a recovery area, basta apenas alterar o tamanho do parâmetro desde que haja disco suficiente.

alter system set db_recovery_file_dest_size=300G;


select  VIEW_NAME from DBA_VIEWS WHERE VIEW_NAME LIKE '%LOG%'

delete archivelog all backed up 1 times to device type sbt; 


set lines 2000
set pages 1000
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
SELECT THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED,
case BACKUP_COUNT when 0 then 'Sem backup'
                when 1 then '1 Backup feito'
                when 2 then '2 Backup feito'
                when 3 then '3 Backup feito'
                ELSE 'Mais de 3 backups feitos' end as BACKUP_COUNT
FROM V$ARCHIVED_LOG WHERE first_time > SYSDATE -1 and DEST_ID=1 ORDER  BY first_time ASC;


SELECT DEST_ID,name,THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED,BACKUP_COUNT
FROM V$ARCHIVED_LOG 
WHERE first_time > SYSDATE -1
and DEST_ID=1;
--AND DELETED='NO'
and APPLIED='YES'
ORDER  BY first_time ASC;
GROUP BY 	TO_CHAR(last_analyzed, 'YYYY-Mon-DD')

-- Conta quantidade de archive gerado por dia.
SELECT tO_CHAR(first_time, 'YYYY-Mon-DD') first_time, count(*) QTD 
FROM V$ARCHIVED_LOG 
WHERE first_time > SYSDATE -7 and DEST_ID=1
GROUP BY tO_CHAR(first_time, 'YYYY-Mon-DD')
order by 1 DESC;


delete archivelog from sequence 26201 until sequence 27076;

delete archivelog from sequence

SELECT THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED,BACKUP_COUNT
FROM V$ARCHIVED_LOG
WHERE BACKUP_COUNT > 10 and DEST_ID=1;

SELECT THREAD#, SEQUENCE#, FIRST_TIME, NEXT_TIME, ARCHIVED, DELETED, APPLIED,BACKUP_COUNT
FROM GV$ARCHIVED_LOG
WHERE SEQUENCE#= 108543;


select applied,deleted,decode(rectype,11,'YES','NO') reclaimable,count(*),min(sequence#),max(sequence#) 
from v$archived_log 
left outer join sys.x$kccagf using(recid) 
where is_recovery_dest_file='YES' and name is not null 
group by applied,deleted,decode(rectype,11,'YES','NO') order by 5 
/ 
 
column deleted format a7 
column reclaimable format a11 
set linesize 120 
select applied,deleted,backup_count 
,decode(rectype,11,'YES','NO') reclaimable,count(*) 
,to_char(min(completion_time),'dd-mon hh24:mi') first_time 
,to_char(max(completion_time),'dd-mon hh24:mi') last_time 
,min(sequence#) first_seq,max(sequence#) last_seq 
from v$archived_log left outer join sys.x$kccagf using(recid) 
where is_recovery_dest_file='YES' 
group by applied,deleted,backup_count,decode(rectype,11,'YES','NO') order by min(sequence#) 
/

-- deleta archives.
run{
allocate channel c1 device type disk;
delete archivelog until time 'sysdate - 30';
crosscheck archivelog all;
}

-- deleta archives do DR / Standby ja aplicados
run{
crosscheck archivelog all;
delete noprompt archivelog all completed before 'sysdate-4' ;
}


-- caso archives derem erro no momento do crosscheck em archives que ja foram excluidos abaixa uma workaround
crosscheck archivelog all;
delete expired archivelog all;
 

run {
allocate channel d1 device type sbt;
crosscheck archivelog all;
delete expired archivelog all;
release channel d1;
}

 --Deleta sem fazer a confirmação
run {
allocate channel d1 device type disk;
crosscheck archivelog all;
delete noprompt expired archivelog all;
release channel d1;
}
 

-- Archives agrupados pela quantidade de backup.

-- rodar caso crosscheck nao funcione
run {
allocate channel d1 device type disk;
crosscheck archivelog all;
release channel d1;
}

run {
allocate channel d1 device type disk;
crosscheck backup;
delete expired backup all;
release channel d1;
}

run{
resync catalog;
crosscheck archivelog all;
crosscheck copy;
crosscheck backup;
delete noprompt obsolete;
delete noprompt expired copy;
delete noprompt expired archivelog all;
delete noprompt expired backup;}


run{
allocate channel ch1 device type disk;
crosscheck backup;
crosscheck archivelog all;
delete noprompt expired archivelog all;
delete noprompt expired backup;
delete noprompt obsolete;
release channel ch1;
}


run{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';
crosscheck backup;
}

run{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_EXA_CS_KIPREV,NB_ORA_SERV=lnxprd085.rootbrasil.intranet,NB_ORA_CLIENT=exacc01db01vmc01.rootbrasil.intranet)';
crosscheck copy;
release channel c1;
}

exacc01-7jrgw-scan.rootbrasil.intranet

run{
allocate channel ch1 device type disk;
allocate channel ch2 device type disk;
allocate channel ch3 device type disk;
allocate channel ch4 device type disk;
allocate channel ch5 device type disk;
allocate channel ch6 device type disk;
allocate channel ch7 device type disk;
allocate channel ch8 device type disk;
allocate channel ch9 device type disk;
allocate channel ch10 device type disk;
crosscheck backup;
crosscheck archivelog all;
}

crosscheck backup;
crosscheck archivelog all;
crosscheck backuppiece;
crosscheck backupset;
crosscheck copy;
delete expired archivelog all;
delete obsolete;

run{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD+,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exasapprd1)';
crosscheck archivelog all;
delete expired archivelog all;
delete obsolete;
}



CONFIGURE ARCHIVELOG DELETION POLICY TO APPLIED ON ALL STANDBY BACKED UP 1 TIMES TO 'SBT_TAPE';


delete archivelog until time 'sysdate - 4';

LIST BACKUP OF ARCHIVELOG  until time 'sysdate - 4';