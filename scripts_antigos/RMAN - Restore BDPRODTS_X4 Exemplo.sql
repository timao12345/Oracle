
-1- Criar a estrutura de diretorio Básica: /u01/app/oracle/admin/bdprodts


-2- Criar a entrada do banco bdprodexa no arquivo /etc/oratab
	bdprodts:/u01/app/oracle/product/12.1.0.2/dbhome_1:N             # add to restore full database from Exadata


-3- Fazer as alterações necessárias (trocar nomes, valores de sga, pga, etc);

audit_file_dest='/u01/app/oracle/admin/bdprodts/adump'
compatible='12.1.0.2.0'
control_file_record_keep_time=15
control_files='+DATAC1/bdprodts/controlfile/controlfile01','+RECOC1/bdprodts/controlfile/controlfile02'#Restore Controlfile
db_block_size=8192
db_cache_size=2G
db_create_file_dest='+DATAC1'
db_create_online_log_dest_1='+RECOC1'
db_create_online_log_dest_2='+DATAC1'
db_files=7200
db_name='ORA29'
db_recovery_file_dest='+RECOC1'
db_recovery_file_dest_size=50G
db_unique_name='bdprodts'
global_names=FALSE
_disk_sector_size_override='TRUE'
local_listener='(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.16.136.242)(PORT=1521))))'
log_archive_dest_1='LOCATION=+RECOC1 VALID_FOR=(ALL_LOGFILES, ALL_ROLES) DB_UNIQUE_NAME=bdprodts'
log_archive_dest_state_1='ENABLE'
log_archive_format='archive_bdprodts_%t_%s_%r.arc'
nls_comp='BINARY'
nls_date_format='DD-MON-RR'
nls_time_format='HH.MI.SSXFF AM'
nls_time_tz_format='HH.MI.SSXFF AM TZR'
nls_timestamp_format='DD-MON-RR HH.MI.SSXFF AM'
open_cursors=8192
open_links=30
processes=9000
sessions=13536
sga_max_size=16G
sga_target=16G
pga_aggregate_target=16G
undo_retention=27600
session_max_open_files=30


--> criar novamente o SPFILE a partir do PFILE alterado - create spfile from pfile;
--> fazer o shutdown e o startup nomount (utilizando o spfile restaurado e corrigido) - shutdown immediate / startup nomount


-5- restaurar controlfile do backup (verifique no catalogo ou log do backup qual o backuppeace do CONTROLFILE)
restore controlfile from '/u02/datapump/BDPROD_Template02022018/ORA29_5gsq7ab5_1_1_1200.ctrl';
	
--> montar o banco de dados com os controlfiles restaurados - no rman mesmo - alter database mount;


-6- Catalogar o restante dos Backup pieaces necessários para o completo restore do banco de dados
catalog start with '/u02/datapump/BDPROD_Template02022018';	



----[ IMPORTANTE: Criar a estrutura de diretorios ]
+DATAC1/BDPRODTS/datafile
+RECOC1/BDPRODTS/onlinelog
+DATAC1/BDPRODTS/onlinelog



-7- Preparar o banco para o restore ...

IMPORTANTE!
1) Gerar o "alter database rename file" para os REDOLOGs serem criado no local nodo do banco bdprodts:

set head off pages 0 feed off echo off verify off
set lines 600
set pages 300

select 'SQL "alter database rename file '''''|| member ||''''' '||chr(10)|| ' TO ''''' || '+RECOC1/BDPRODTS/onlinelog/' || substr(member,instr(member,'/',-1)+1) || ''''' ";' 
from v$logfile
where member like '+RECO%';

select 'SQL "alter database rename file '''''|| member ||''''' '||chr(10)|| ' TO ''''' || '+DATAC1/BDPRODTS/onlinelog/' || substr(member,instr(member,'/',-1)+1) || ''''' ";' 
from v$logfile
where member like '+FRA%';



--> Rodar o script no RMAN:
 
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_1.448.966158497''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_1.448.966158497'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_2.472.966158509''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_2.472.966158509'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_4.551.966158921''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_4.551.966158921'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_5.516.966158727''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_5.516.966158727'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_3.452.966158553''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_3.452.966158553'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_6.877.966158739''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_6.877.966158739'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_7.515.966158769''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_7.515.966158769'' ";
SQL "alter database rename file ''+RECO/ORA29/ONLINELOG/group_8.574.966158847''
 TO ''+RECOC1/BDPRODTS/onlinelog/group_8.574.966158847'' ";

SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_1.12203.966158503''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_1.12203.966158503'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_4.3662.966158925''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_4.3662.966158925'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_2.14851.966158515''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_2.14851.966158515'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_5.20311.966158733''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_5.20311.966158733'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_3.13042.966158559''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_3.13042.966158559'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_6.10995.966158743''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_6.10995.966158743'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_7.10809.966158775''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_7.10809.966158775'' ";
SQL "alter database rename file ''+FRA/ORA29/ONLINELOG/group_8.9174.966158851''
 TO ''+DATAC1/BDPRODTS/onlinelog/group_8.9174.966158851'' ";


-8- Restaurar o banco de dados
--> Bloco RUN para o restore com RMAN:
RUN {
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
allocate channel ch5 type disk;
allocate channel ch6 type disk;
set newname for database to '+DATAC1/BDPRODTS/datafile/%b';
RESTORE DATABASE;
SWITCH DATAFILE ALL;
RECOVER DATABASE;
}


-9- Abrir o banco de dados restaurado com RESETLOGS
SQL> alter database open resetlogs;

Database altered.

IMPORTANTE: Se der o erro RMAN-06054  --> pode abrir o banco com RESETLOGS



-- ------------------------------------------------------------------
   CONFIGURE CLUSTER DATABASE											>>> TEMPO: 20Minutos <<<
-- ------------------------------------------------------------------ 

--> criar SPFILE no ASM
create pfile='/home/oracle/pfilebdprodts.ora' from spfile;
create spfile='+DATAC1' from pfile='/home/oracle/pfilebdprodts.ora';

-->verifique o nome do SPFILE criado: <como GRID> asmcmd ls -l +DATAC1/BDPRODTS/PARAMETERFILE

echo "SPFILE='+DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451'" > /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initbdprodts1.ora
ssh krtn1db02 "echo \"SPFILE='+DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451'\" > /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initbdprodts2.ora"
ssh krtn1db03 "echo \"SPFILE='+DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451'\" > /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initbdprodts3.ora"
ssh krtn1db04 "echo \"SPFILE='+DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451'\" > /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initbdprodts4.ora"

echo "SPFILE='+DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451'" > /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/initbdprodts.ora

--> Baixara o banco: shutdown immediate
--> Remover o SPFILE do ORACLE_HOME (se houver): !rm /u01/app/oracle/product/12.1.0.2/dbhome_1/dbs/spfilebdprodts.ora
--> Startup


--> Alterar no SPFILE os parametros:

alter system set instance_number=1 scope=spfile sid='bdprodts1';
alter system set instance_number=2 scope=spfile sid='bdprodts2';
alter system set instance_number=3 scope=spfile sid='bdprodts3';
alter system set instance_number=4 scope=spfile sid='bdprodts4';


alter database enable thread 1;
alter database enable thread 2;

--> criar grupos de redo para as threads 3 e 4:
#THREAD 3
ALTER DATABASE ADD LOGFILE THREAD 3 GROUP 9  ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 3 GROUP 10 ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 3 GROUP 11 ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 3 GROUP 12 ('+RECOC1','+DATAC1') SIZE 2048m;

#THREAD 4
ALTER DATABASE ADD LOGFILE THREAD 4 GROUP 13 ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 4 GROUP 14 ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 4 GROUP 15 ('+RECOC1','+DATAC1') SIZE 2048m;
ALTER DATABASE ADD LOGFILE THREAD 4 GROUP 16 ('+RECOC1','+DATAC1') SIZE 2048m;

alter database enable thread 3;
alter database enable thread 4;

alter system set thread=1 scope=spfile sid='bdprodts1';
alter system set thread=2 scope=spfile sid='bdprodts2';
alter system set thread=3 scope=spfile sid='bdprodts3';
alter system set thread=4 scope=spfile sid='bdprodts4';


alter system set undo_tablespace='UNDOTBS1' scope=spfile sid='bdprodts1';
alter system set undo_tablespace='UNDOTBS2' scope=spfile sid='bdprodts2'; 

--> Criar TBS de UNDO para as threads 3 e 4
create undo tablespace UNDOTBS3 DATAFILE '+DATAC1' SIZE 6G;
create undo tablespace UNDOTBS4 DATAFILE '+DATAC1' SIZE 6G;

alter system set undo_tablespace='UNDOTBS3' scope=spfile sid='bdprodts3';
alter system set undo_tablespace='UNDOTBS4' scope=spfile sid='bdprodts4'; 


alter system set local_listener='(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.16.136.242)(PORT=1521))))' scope=both sid='bdprodts1';
alter system set local_listener='(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.16.136.244)(PORT=1521))))' scope=both sid='bdprodts2';
alter system set local_listener='(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.16.136.246)(PORT=1521))))' scope=both sid='bdprodts3';
alter system set local_listener='(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=172.16.136.248)(PORT=1521))))' scope=both sid='bdprodts4';


alter system set remote_listener='' scope=both sid='*';
alter system set remote_listener='krtn4-scan.pitagoras.apollo.br:1521' scope=both sid='*';
alter system register;

alter system set cluster_database=true scope=spfile sid='*';


--> Adicionar o banco no Clusterware (Em qualquer DBNODE com usuario "oracle")

srvctl add database -d bdprodts -o /u01/app/oracle/product/12.1.0.2/dbhome_1 -p +DATAC1/BDPRODTS/PARAMETERFILE/spfile.5361.968605451 -y automatic -a "DATAC1,RECOC1" 

srvctl add instance -d bdprodts -i bdprodts1 -n krtn1db01
srvctl add instance -d bdprodts -i bdprodts2 -n krtn1db02
srvctl add instance -d bdprodts -i bdprodts3 -n krtn1db03
srvctl add instance -d bdprodts -i bdprodts4 -n krtn1db04


--> Criar copia de segurança do SPFILE após aletrações
create pfile='/home/oracle/pfileClusterbdprodts.ora' from spfile;

--> SHUTDOWN NO SINGLE INSTANCE / STARTUP VIA CLUSTER - shutdown immediate / srvctl start database -d bdprodts

-------> FIM!




