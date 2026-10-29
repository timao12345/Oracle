---- Gerar backup manualmente se necess�rio. (pode ser executado com a base em modo MOUNT para migra��o)
---- Ativar backup do control automatico, e parallel (se for enterprise)
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 4;

set encryption on identified by "Ruop2390#!" only;

---- Gerar backup manual
spool log to /opt/oracle/dcs/commonstore/backup-hirota-rman/fullbackup.log
run {
	  set controlfile autobackup format for device type disk to '/dump/sinter-bkp/backup-sinter-%F.rman' ;
      BACKUP device type disk format '/dump/sinter-bkp/backup-sinter-t%T-b%up%pc%c.rman' FULL DATABASE ;
      show all ;
      report schema ;
      report unrecoverable ;
      report need backup ;
    }
spool log off;


--- Realizando start da instancia (com o FORCE se n�o tiver ainda spfile/pfile e for restaurar o spfile/pfile do bkp), e conectando no rman
export ORACLE_SID=restore
rman nocatalog target /
startup nomount force;


--- Gerar c�pia do init para utilizar no ambiente destino
create pfile='/xxx/pfileXXX.ora' from spfile;
mkdir -p /u01/app/oracle/admin/restore/adump
---- OU, posso restaurar o spfile/pfile do backup do control (pois o spfile vai junto)
restore spfile to pfile '$ORACLE_HOME/dbs/initnewrestore.ora' from '/backup_rman/restore/c-2622018584-20191111-00';
restore spfile from '/backup_rman/restore/c-2622018584-20191111-00';
---- Validar se precisa fazer algum ajuste de conf.: criar diret�rio ADUMP, sga/pga/db_unique_name/listener/controlfile etc.



---- ### - Criar arquivo de Senha para o Banco de Dados
---- ### (executar no servidor que será PRODUCÃO/STANDBY, com o usuario oracle)
orapwd file=$ORACLE_HOME/dbs/orapwXXdbXX password=XXsenhaXX
orapwd file=$ORACLE_HOME/dbs/orapworadev password=


----- Baixar e subir a base novamente com o backup do spfile/pfile que foi restaurado
shutdown immediate;
startup nomount;



----- Restaurando controlfile do backup
restore controlfile from '/backup_rman/trdb/backup-trdb-c-17348252-20191021-00.rman';
### OU, se for do backup automatico
SET CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/u02/oracle/backup/mega/%F';
RESTORE CONTROLFILE FROM AUTOBACKUP;

---- colocar a base em modo MOUNT
---- validar caminho dos datafiles, se existe,(ASM ele cria sozinho, s� validar se tem o param. configurado: *.db_create_file_dest='+DATA')
alter database mount;
select file#,name from v$datafile;


-----  Limpar backups catalogados/expirados/n�o reconhecidos
crosscheck backup;
delete noprompt EXPIRED backup;


----- Catalogar arquivos de backup, com a base em MOUNT
catalog start with '/backup_rman/restore/dwdb_';
yes



-- Com banco em mount desatviar o flashback database pode gerar o erro ORA-38760: This database instance failed to turn on flashback database
-- ao tentar fazer recover
alter database flashback off;

---- Inicia o restore (SE ATENTAR AO UTILIZAR OS CHANNELS, SOMENTE ENTERPRISE, retirar se n�o for)
####------ Se quiser log, utilizar o SPOOL
spool log to /backup_rman/bkpDBN09/trdb/restore_fullbackup.log

####------ Utilizado em caso de manter o mesmo padr�o de diret�rios da origem
####------ (Se for filesystem criar os diret�rios antes, se for ASM ele cria automatico)
run{
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
allocate channel ch5 type disk;
allocate channel ch6 type disk;
allocate channel ch7 type disk;
allocate channel ch8 type disk;
recover database;
}

run {
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
allocate channel ch5 type disk;
allocate channel ch6 type disk;
allocate channel ch7 type disk;
allocate channel ch8 type disk;
backup archivelog from time "to_date('2026-02-04 21:00','yyyy-mm-dd hh24:mi')" UNTIL TIME "to_date('2026-02-05 04:00','yyyy-mm-dd hh24:mi')" FORMAT '/backup_acfs_sap/ECC/restore/ARCH_%d_%u_%s_%T.arc';
}

recover database UNTIL TIME ="to_date('05/02/2026 04:00:00','DD/MM/YYYY HH24:MI:SS')";

BACKUP CURRENT CONTROLFILE FOR STANDBY FORMAT '/acfs_backup/orarcu_bkp/orarcu_prd.bkp';

####------ Iniciar o restore do banco (nesse caso foi utilizado o setnewname for database devido a mudan�a de nome da base para 'restore',
####------ para n�o sobrescrever os arquivos no caminho default dela, OBS: Foi configurado o DB_UNIQUE_NAME e j� estava configurado
####------ o db_create_file_dest para ASM )
run{
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
SET NEWNAME FOR TEMPFILE to '+DATA';
set newname for database to 'restore';
restore database;
switch datafile all;
switch tempfile all;
recover database;
}

run{
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
allocate channel ch5 type disk;
allocate channel ch6 type disk;
allocate channel ch7 type disk;
allocate channel ch8 type disk;
allocate channel ch9 type disk;
allocate channel ch10 type disk;
allocate channel ch11 type disk;
allocate channel ch12 type disk;
allocate channel ch13 type disk;
allocate channel ch14 type disk;
allocate channel ch15 type disk;
allocate channel ch16 type disk;
allocate channel ch17 type disk;
allocate channel ch18 type disk;
restore database;
switch datafile all;
recover database;
}

run
{
allocate channel c1 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c2 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c3 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c4 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c5 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c6 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c7 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c8 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c9 type disk format  '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
allocate channel c10 type disk format '/backup_acfs/ECQ/restore/restore_ECQ_%U.rman';
recover database;
}

run
{
allocate channel c1 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c2 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c3 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c4 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c5 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c6 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c7 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c8 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c9 type disk format   '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c10 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c11 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c12 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c13 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c14 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c15 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c16 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c17 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c18 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c19 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c30 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c31 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c32 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c33 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c34 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c35 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c36 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c37 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c38 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c39 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
allocate channel c40 type disk format  '/u02/restore/restore_ECCSTBY_%U.rman';
recover database;
}

##################################################################################################
##################################################################################################
###
###  Select para montar rename de datafiles para restore rman, se necess�rio:   ---- N� / novo caminho
###
set lines 1000 pages 10000
select 'set newname for datafile '|| h.FILE# ||' to '''|| replace(f.NAME,'+DATAC1','+DATAC3') ||''' ; '
from V$DATAFILE_HEADER h, V$DATAFILE f
where h.FILE# = f.FILE# (+) 
order by h.file# ;

### Montar Lista de Renomea��o de DATAFILES (somente quando necessario), OP��O 2
select 'set newname for datafile '|| to_char (f.FILE#, '990') ||
        ' to "/xxx/oracle/oradata/'|| lower (d.NAME) ||'/'||
        substr (f.NAME, instr (f.NAME, '/', -1, 1) + 1) ||'" ; '
from V$DATABASE d,
      V$DATAFILE f
order by f.TS#, f.NAME ;

EX:
spool log to '/u01/app/oracle/restore_tstrm.log';
run{
set newname for datafile 1 to  '+DATAC1/APEXSTBY/DATAFILE/system01.dbf' ;
set newname for datafile 2 to  '+DATAC1/APEXSTBY/DATAFILE/tbs_work_sust_01.dbf' ;
set newname for datafile 3 to  '+DATAC1/APEXSTBY/DATAFILE/sysaux01.dbf' ;
set newname for datafile 4 to  '+DATAC1/APEXSTBY/DATAFILE/undotbs01.dbf' ;
set newname for datafile 5 to  '+DATAC1/APEXSTBY/DATAFILE/tbs_apex_01.dbf' ;
set newname for datafile 7 to  '+DATAC1/APEXSTBY/DATAFILE/users01.dbf' ;
set newname for datafile 8 to  '+DATAC1/APEXSTBY/DATAFILE/tbs_apex_02.dbf' ;
set newname for datafile 9 to  '+DATAC1/APEXSTBY/DATAFILE/tbs_apex_03.dbf' ;
set newname for datafile 10 to '+DATAC1/APEXSTBY/DATAFILE/tbs_apex_04.dbf' ;
set newname for datafile 11 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_sust_02.dbf' ;
set newname for datafile 12 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_sust_03.dbf' ;
set newname for datafile 13 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_sust_04.dbf' ;
set newname for datafile 14 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_kpv_01.dbf' ;
set newname for datafile 15 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_kpv_02.dbf' ;
set newname for datafile 16 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_kpv_03.dbf' ;
set newname for datafile 17 to '+DATAC1/APEXSTBY/DATAFILE/tbs_work_kpv_04.dbf' ;
set newname for datafile 18 to '+DATAC1/APEXSTBY/DATAFILE/apex_1522795682915512.dbf' ;
set newname for datafile 19 to '+DATAC1/APEXSTBY/DATAFILE/undotbs2.1614.1225816389' ;
restore database;
switch datafile all;
recover database;
}

spool off;

spool log to '/opt/oracle/dcs/commonstore/backup-consinco-rman/restore.log';

run{
set newname for datafile 1 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-system_fno-1' ;
set newname for datafile 2 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-sysaux_fno-2' ;
set newname for datafile 3 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-psapundo_fno-3' ;
set newname for datafile 4 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-psapsr3db_fno-4' ;
set newname for datafile 5 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-psapsr3db_fno-5' ;
set newname for datafile 6 to '+DATAC2/PDS/DATAFILE/data_d-pds_ts-psapsr3db_fno-6' ;

restore database;
switch datafile all;
recover database;
}

spool log off;n

recover database UNTIL TIME ="to_date('05/05/2026 03:00:00','DD/MM/YYYY HH24:MI:SS')";

disk

----- apos finalizar o restore, criar diretorios se necessario para os arquivos que serao criados ao abrir a base (TEMP/REDO)
####------ Validar todos caminhos
select N
  from (select name N from v$controlfile
         union all
        select member N from v$logfile
         union all
        select name N from v$datafile
         union all
        select name N from v$tempfile)
  order by N ;

-- Monta Comandos para Renomear DataFiles (sqplus), SE NECESS�RIO
--
--   Necessario quando os Diretorios da base de Origem forem Diferentes
--   Os datafiles sao feitos acima pelo NEWNAMEs, porem os REDOs e TEMPs dependendo da forma feita não, entao fazer aqui. (segundo e terceiro select)
--
-- Rename datafiles
select ' alter database rename file '''|| f.NAME ||''' to ''XXX'|| f.NAME ||''' ; ' as DATAFILE
from V$DATAFILE f
order by f.NAME ;

select ' alter database rename file '''|| f.NAME ||''' to ''XXX'|| f.NAME ||''' ; '
from V$DATAFILE f
order by f.NAME ;


SELECT FILE#, NAME, STATUS, CHECKPOINT_CHANGE#, TS#
FROM V$DATAFILE
ORDER BY FILE#;


-- Rename logfiles
select ' alter database rename file '''|| f.MEMBER ||''' to ''XXX'|| f.MEMBER ||''' ; '  as LOGFILE
from V$LOGFILE f
order by f.MEMBER ;

select ' alter database rename file '''|| f.MEMBER ||''' to '''|| replace(f.MEMBER,'+DATAEC1/','+DATAEC4/') ||''' ; '
from  V$LOGFILE f
order by f.MEMBER ;

alter database rename file '+DATAC1/ECC/ONLINELOG/group_1.1831.1212362277'  to '+DATAC3/ECQ/ONLINELOG/group_1.1831.1212362277' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_10.1968.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_10.1968.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_11.1967.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_11.1967.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_12.1966.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_12.1966.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_13.1965.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_13.1965.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_14.1964.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_14.1964.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_15.1839.1212362295' to '+DATAC3/ECQ/ONLINELOG/group_15.1839.1212362295' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_16.1963.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_16.1963.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_17.1962.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_17.1962.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_18.1961.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_18.1961.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_19.1960.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_19.1960.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_2.1858.1212362279'  to '+DATAC3/ECQ/ONLINELOG/group_2.1858.1212362279' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_20.1959.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_20.1959.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_21.1958.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_21.1958.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_22.1957.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_22.1957.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_23.1956.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_23.1956.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_24.1955.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_24.1955.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_25.1954.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_25.1954.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_26.1952.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_26.1952.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_27.1953.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_27.1953.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_28.1951.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_28.1951.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_29.1950.1212362175' to '+DATAC3/ECQ/ONLINELOG/group_29.1950.1212362175' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_3.1832.1212362281'  to '+DATAC3/ECQ/ONLINELOG/group_3.1832.1212362281' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_4.1833.1212362283'  to '+DATAC3/ECQ/ONLINELOG/group_4.1833.1212362283' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_40.1840.1212362319' to '+DATAC3/ECQ/ONLINELOG/group_40.1840.1212362319' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_41.1841.1212362321' to '+DATAC3/ECQ/ONLINELOG/group_41.1841.1212362321' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_42.1859.1212362323' to '+DATAC3/ECQ/ONLINELOG/group_42.1859.1212362323' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_43.1842.1212362325' to '+DATAC3/ECQ/ONLINELOG/group_43.1842.1212362325' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_44.1843.1212362329' to '+DATAC3/ECQ/ONLINELOG/group_44.1843.1212362329' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_45.1844.1212362331' to '+DATAC3/ECQ/ONLINELOG/group_45.1844.1212362331' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_46.1845.1212362333' to '+DATAC3/ECQ/ONLINELOG/group_46.1845.1212362333' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_47.1847.1212362335' to '+DATAC3/ECQ/ONLINELOG/group_47.1847.1212362335' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_48.1848.1212362337' to '+DATAC3/ECQ/ONLINELOG/group_48.1848.1212362337' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_49.1849.1212362339' to '+DATAC3/ECQ/ONLINELOG/group_49.1849.1212362339' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_5.1834.1212362285'  to '+DATAC3/ECQ/ONLINELOG/group_5.1834.1212362285' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_50.1850.1212362341' to '+DATAC3/ECQ/ONLINELOG/group_50.1850.1212362341' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_51.1851.1212362343' to '+DATAC3/ECQ/ONLINELOG/group_51.1851.1212362343' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_6.1835.1212362287'  to '+DATAC3/ECQ/ONLINELOG/group_6.1835.1212362287' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_7.1836.1212362289'  to '+DATAC3/ECQ/ONLINELOG/group_7.1836.1212362289' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_8.1837.1212362291'  to '+DATAC3/ECQ/ONLINELOG/group_8.1837.1212362291' ;
alter database rename file '+DATAC1/ECC/ONLINELOG/group_9.1838.1212362293'  to '+DATAC3/ECQ/ONLINELOG/group_9.1838.1212362293' ;

alter database rename file '+RECOC1/ECC/ONLINELOG/redo30_stby.log' to '+RECOC3/ECC/ONLINELOG/redo30_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo31_stby.log' to '+RECOC3/ECC/ONLINELOG/redo31_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo32_stby.log' to '+RECOC3/ECC/ONLINELOG/redo32_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo33_stby.log' to '+RECOC3/ECC/ONLINELOG/redo33_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo34_stby.log' to '+RECOC3/ECC/ONLINELOG/redo34_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo35_stby.log' to '+RECOC3/ECC/ONLINELOG/redo35_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo36_stby.log' to '+RECOC3/ECC/ONLINELOG/redo36_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo37_stby.log' to '+RECOC3/ECC/ONLINELOG/redo37_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo38_stby.log' to '+RECOC3/ECC/ONLINELOG/redo38_stby.log' ;
alter database rename file '+RECOC1/ECC/ONLINELOG/redo39_stby.log' to '+RECOC3/ECC/ONLINELOG/redo39_stby.log' ;


-- Rename tempfiles
select ' alter database rename file '''|| f.NAME ||''' to ''XXX'|| f.NAME ||''' ; '
from V$TEMPFILE f
order by f.NAME ;

select ' alter database rename file '''|| f.NAME ||''' to '''|| replace(f.NAME,'+DATAC1/','+DATAC03/') ||''' ; '
from  V$TEMPFILE f
order by f.NAME ;

 alter database rename file '+DATAC1/DBRMAN/TEMPFILE/temp.265.1181241281' to '+DATAC4/DBRMANTST/DATAFILE/temp.265.1181241281' ;

####------ Conferir o Parametro UNDO_TABLESPACE
select name from v$tablespace where NAME like '%UNDO%' ;

PSAPUNDO
PSAPUNDO0

show parameter undo_tablespace ;

---- Faz o recover CANCEL
recover database using backup controlfile until cancel;

---- Em casos bem espec�ficos, pode ter o Change Tracking ativado, se estiver ativado, desativar antes do open resetlogs
select status,filename from V$BLOCK_CHANGE_TRACKING;
alter database disable block change tracking ;


---- Tirar a base do modo archivelog se for o caso, e abrir com o resetlogs
alter database noarchivelog;
alter database open resetlogs upgrade;
shutdown immediate;
startup;

----- Ajustar spfile nas bases (se estiver usando PFILE e for um restore para produ��o)
####------ se for ASM
create spfile='+DATA' from pfile;
mkalias  +DATA/dwdb/PARAMETERFILE/spfile.522.1022146963 spfileportaldb.ora  (no asmcmd, cria um atalho no +DATA/spfileportaldb.ora)
mv initindb.ora initindb.ora.bkp
vi initindb.ora
SPFILE='+DATA/dwdb/PARAMETERFILE/spfiledwdb.ora'
####------ se for FILESYSTEM
create spfile from pfile;

Alter database enable thread 2;
---- Remover thread2 e undo2 pois não são mais utlizados (se a origem for RAC e o destino single)
Alter database disable thread 2;
drop tablespace UNDOTBS2 including contents and datafiles;
-- também atenção se for RAC deve ser ativado o cluster_database=true, e o db_unique_name deve ser diferente do nome da instância

alter system set cluster_database=TRUE scope=spfile sid='*';
Alter database enable thread 2;
ALTER SYSTEM SET thread=1 SCOPE=SPFILE SID='ORAKPVHM1';
ALTER SYSTEM SET thread=2 SCOPE=SPFILE SID='ORAKPVHM2';

ALTER SYSTEM SET undo_tablespace=UNDOTBS1 SCOPE=SPFILE SID='ORAKPVHM1';
ALTER SYSTEM SET undo_tablespace=UNDOTBS2 SCOPE=SPFILE SID='ORAKPVHM2';

--- Criar servi�os do GRID para a instancia/database se utilizar (utilizado em GRID single, validar se o destino for RAC)
srvctl add database -d portaldb -oraclehome $ORACLE_HOME
srvctl stop database -d portaldb
srvctl start database -d portaldb
/u01/app/grid/product/12.1.0/grid/bin/crsctl status resource -t



---- Atualizar PSU no database (validar variavel do SID exportada)
---- Datapatch Funciona do Oracle 12 em diante, nesse caso possuia um PSU mais recente no destino
shutdown immediate;
startup upgrade

cd $ORACLE_HOME/OPatch
./datapatch -verbose

sqlplus / as sysdba
shutdown
startup

--Verificando Patch aplicado no database
select  patch_id,status,description,ACTION_TIME
from dba_registry_sqlpatch;


--- Validar servi�os da base
show parameter service_names


---- Validar se usa directories, dblink(tns?), wallet, jobs (vai ficar ativo?)


---- Validar tablespace Tempor�ria atual, e se necess�rio recriar
SELECT property_name, property_value FROM database_properties WHERE property_name='DEFAULT_TEMP_TABLESPACE';
SELECT tablespace_name, file_name, bytes/1024/1024 MB, status FROM dba_temp_files;
create temporary tablespace TEMP tempfile '+DATAC2' size 32767M autoextend on next 100M maxsize 32767M;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP;
DROP TABLESPACE TEMP_NEW INCLUDING CONTENTS AND DATAFILES;

alter tablespace temp add tempfile 

---- Ver objetos invalidos, ver se precisa rodar o utlrp
@?/rdbms/admin/utlrp.sql




--- Validar se ficou algum REDO de 'lixo', n�o utilizado pelo database
select group# from v$logfile where group# not in (select group# from v$log);
select 'ALTER DATABASE DROP LOGFILE GROUP ' || group# || ';' from v$logfile where group# not in (select group# from v$log);

---- Ajustar REDOS se necess�rio aumentar, ou remover undo2 (se a origem for RAC e o destino single)
set tab off time on underline = linesize 123 newpage none pagesize 40000 feedback on colsep |;
col GRP format 99999;
col PCT format 999;
col MB_USED format 999999;
col MB_TOTAL format 999999;
col FN format a50;
col TBS format a15;
col NAME format A35;
select g.group# GRP, f.member FN, g.bytes/1024/1024 MB_TOTAL
from v$log g, v$logfile f
where g.group#(+) = f.group#
order by grp, fn;

--- ADICIONAR (CRIAR) ARQUIVO DE REDO MULTIPLEXADO
alter database add logfile group 01 ('+DATAC1') size 200M;
alter database add logfile group 02 ('+DATAC1') size 200M;
alter database add logfile group 03 ('+DATAC1') size 200M;
alter database add logfile group 04 ('+DATAC1') size 200M;
alter database add logfile group 05 ('+DATAC1') size 200M;
alter database add logfile group 06 ('+DATAC1') size 200M;
alter database add logfile group 07 ('+DATAC1') size 200M;
alter database add logfile group 08 ('+DATAC1') size 200M;
alter database add logfile group 09 ('+DATAC1') size 200M;
alter database add logfile group 10 ('+DATAC1') size 200M;

---------------------Informa��es adicionais que podem auxiliar





####################------------- To see status of all restored datafiles can be done with this SQL
set linesize 200;
set pagesize 100;
col inst_id for 9999999 heading 'Instance #'
col file_nr for 9999999 heading 'File #'
col file_name for A85 heading 'File name'
col checkpoint_change_nr for 99999999999999 heading 'Checkpoint #'
col checkpoint_change_time for A20 heading 'Checkpoint time'
col last_change_nr for 99999999999999 heading 'Last change #'
SELECT
      fe.inst_id,
      fe.fenum file_nr,
      fn.fnnam file_name,
      TO_NUMBER (fe.fecps) checkpoint_change_nr,
      fe.fecpt checkpoint_change_time,
      fe.fests last_change_nr,
      DECODE (
              fe.fetsn,
              0, DECODE (BITAND (fe.festa, 2), 0, 'SYSOFF', 'SYSTEM'),
              DECODE (BITAND (fe.festa, 18),
                      0, 'OFFLINE',
                      2, 'ONLINE',
                      'RECOVER')
      ) status
FROM x$kccfe fe,
     x$kccfn fn
WHERE    (   (fe.fepax != 65535 AND fe.fepax != 0 )
          OR (fe.fepax = 65535 OR fe.fepax = 0)
         )
     AND fn.fnfno = fe.fenum
     AND fe.fefnh = fn.fnnum
     AND fe.fedup != 0
     AND fn.fntyp = 4
     AND fn.fnnam IS NOT NULL
     AND BITAND (fn.fnflg, 4) != 4
ORDER BY fe.fenum;

#################-----   The output might looks like:
Instance #   File # File name                     Checkpoint# Checkpoint time      Last change #  STATUS
---------- -------- ----------------------------- ----------- -------------------- -------------- ------
         2        1 /u01/system.312.711642293         891734 02/25/2010 10:24:21   891734         SYSTEM
         2        2 /u01/undotbs1.311.711642299       891734 02/25/2010 10:24:21   891734         ONLINE
         2        3 /u01/sysaux.310.711642299         891734 02/25/2010 10:24:21   891734         ONLINE
         2        4 /u01/undotbs2.307.711642303       891734 02/25/2010 10:24:21   891734         ONLINE
         2        5 /u01/undotbs3.306.711642305       891734 02/25/2010 10:24:21   891734         ONLINE
         2        6 /u01/users.315.711642305          891734 02/25/2010 10:24:21   891734         ONLINE

--- Verificar checkpoint dos datafiles restaurados/feito recover, se estiverem incosistentes
select 'F#|CheckPoint:Difference_|_CheckPointTime|Fzy|File______'
       from dual union all
select S from (
  select to_char (h.FILE#, 'FM000') ||'|'||
         rpad (to_char (h.CHECKPOINT_CHANGE#, 'FM999999999G99990') ||':'||
         to_char ((h.CHECKPOINT_CHANGE# -
           max (h.CHECKPOINT_CHANGE#) over ()), 'FM99999999G999G990'), 26, ' ')||'|'||
         to_char (h.CHECKPOINT_TIME, 'DDMonYYY/HH24:MI:SS') ||'|'||
         rpad (h.FUZZY, 3, ' ') ||'|'||
         h.NAME
         S
    from V$DATAFILE_HEADER h
   order by h.CHECKPOINT_TIME desc, h.NAME
) ;

---- note down output of backup peice its required to restore on target from this piece
RMAN> list backup of spfile;

---- note down output of backup peice its required to restore on target from this piece
RMAN> list backup of controlfile;

----- limitar o recover at� um certo per�odo de tempo ou SEQUENCE
  list backup of archivelog all;
    1    11      1176060    06-OCT-16 1176075    06-OCT-16 <-- 11

SET UNTIL SEQUENCE 12; <--- 11+1

18> # Do a SET UNTIL to prevent recovery of the online logs
19> SET UNTIL SEQUENCE 12;
20> # restore the database and switch the datafile names
21> RESTORE DATABASE;
22> SWITCH DATAFILE ALL;
23> # recover the database
24>  RECOVER DATABASE;


RMAN> run {# change the date and time to suit
SET UNTIL TIME "to_date('01 SEP 2020 12:04:00','DD MON YYYY hh24:mi:ss')";
recover database;
}

RECOVER DATABASE until time "TO_DATE('14-07-2008 16:30:00','DD-MM-YYYY HH24:MI:SS')";

      RUN
      {
      set until time "to_date('2014-12-31:13:00:00', 'yyyy-mm-dd:hh24:mi:ss' )";
      RESTORE DATABASE;
      RECOVER DATABASE;
      }


----- restore/catalog de archives do backup
RMAN> RUN{
allocate channel ch1 type disk;
restore archivelog from sequence 8 until sequence 10 thread 1 validate;
}

RMAN> restore archivelog all;

list backup of archivelog from sequence xxxx;
restore archivelog from sequence <some_start_number>;

RMAN> list backup of archivelog all;
run
{SET UNTIL SEQUENCE 820 THREAD 1;
recover database;
}


CATALOG START WITH '/u01/oracle/archive/dbpie/';

---- erro encontrado no processo de restore, de FAILOVER, � normal acontecer, ele n�o achou em um arquivo e foi procurar em outro a info, acontece normal.
/u03/oracle/backup/orcl/db_ORCL_t974187236_s34776_p1
channel ORA_DISK_1: errors found reading piece handle=/u03/oracle/backup/orcl/db_ORCL_t974187236_s34776_p1
channel ORA_DISK_1: failover to piece handle=/oracle/consinco/bkp/db_ORCL_t974187236_s34776_p1 tag=TAG20180423T012943
channel ORA_DISK_1: restored backup piece 1
channel ORA_DISK_1: restore complete, elapsed time: 00:22:05

---- Se o Recover falhar por causa de espa�o na fast recover
ORA-19870: error while restoring backup piece /u02/storageCLI/restoreFiles/ORCLDB_t928098476_s3309_p1
ORA-19809: limit exceeded for recovery files
ORA-19804: cannot reclaim 810791936 bytes disk space from 322122547200 limit

Verificar onde esta o caminho do fast e olhar se tem espa�o

*.db_recovery_file_dest='/u02/app/oracle/fast_recovery_area'
*.db_recovery_file_dest_size=300G

Aumentar o tamanho no db_recovery_file_dest_size




run
{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c11 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c16 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c17 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c18 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c19 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
ALLOCATE CHANNEL c20 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs/backup_hom/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ORAKPVHOM CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs/backup_hom/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_ORAKPVHOM;
BACKUP FORMAT '/backup_acfs/backup_hom/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE
spfile format '/backup_acfs/backup_hom/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_KPV;
}

run
{
ALLOCATE CHANNEL chan1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_KPV_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
BACKUP  CURRENT CONTROLFILE;
}


#!/bin/bash

datainicial=`date +%s`

NLS_DATE_FORMAT=DD/MM/YYYY_HH24:MI:SS;  export NLS_DATE_FORMAT

rman target /  @/backup_acfs/backup_hom/backup_full_HOM_19072025.rman

# Calculo do tempo de execução..
datafinal=`date +%s`
soma=`expr $datafinal - $datainicial`
resultado=`expr 10800 + $soma`
tempo=`date -d @$resultado +%H:%M:%S`
echo ""
echo "------------------------------------------------------------------------"
echo " Tempo de Execução Backup KIPREV : $tempo "
echo "------------------------------------------------------------------------"


#!/bin/bash

datainicial=`date +%s`
NLS_DATE_FORMAT=DD/MM/YYYY_HH24:MI:SS;  export NLS_DATE_FORMAT

rman target / @/acfs01/bkp_gia/bkp_gia.rman

# Calculo do tempo de execução..
datafinal=`date +%s`
soma=$((datafinal - datainicial))
horas=$((soma / 3600))
minutos=$(( (soma % 3600) / 60 ))
segundos=$((soma % 60))

echo ""
echo "------------------------------------------------------------------------"
echo " Tempo de Execução Backup KIPREV : ${horas}h:${minutos}m:${segundos}s "
echo "------------------------------------------------------------------------"


---

RUN {
  COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1716.1213455743' TO '+DATAC2/ECC/DATAFILE/';
  SWITCH DATAFILE 1367 TO COPY;
}

COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1716.1213455743' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-695';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1737.1213457371'  TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-660';

RUN {
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1746.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-661';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1724.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-662';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1740.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-663';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1753.1213457373' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-664';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1756.1213457375' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-665';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1743.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-666';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1742.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-667';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1735.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-668';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1738.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-669';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1739.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-670';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1745.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-671';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1748.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-672';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1754.1213457373' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-673';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1731.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-674';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1728.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-675';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1723.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-676';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1726.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-677';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1747.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-678';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1734.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-679';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1722.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-680';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1729.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-681';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1752.1213457373' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-682';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1733.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-683';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1736.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-684';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1725.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-685';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1727.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-686';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1730.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-687';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1732.1213457369' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-688';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1741.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-689';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1751.1213457373' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-690';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1744.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-691';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1750.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-692';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750.1749.1213457371' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-693';
COPY DATAFILE '+DATAC2/ECCSTBY/DATAFILE/psapsr3750x.1755.1213457373' TO '+DATAC2/ECC/DATAFILE/data_d-ecc_ts-psapsr3750_fno-694';
SWITCH DATAFILES 1368,1369,1370,1371,1372,1373,1374,1375,1376,1377,1378,1379,1380,1381,1382,1383,1384,1385,1386,1387,1388,1389,1390,1391,1392,1393,1394,1395,1396,1397,1398,1399,1400,1401 TO COPY;
}

run
{
allocate channel c1 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c2 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c3 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c4 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c5 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c6 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c7 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
allocate channel c8 type disk format  '/sap_bkp/ECT/bkp_ECT_%U.rman';
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/sap_bkp/ECT/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECT CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/sap_bkp/ECT/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_ECT;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
CROSSCHECK ARCHIVELOG ALL;
BACKUP FORMAT '/sap_bkp/ECT/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_ECT CURRENT CONTROLFILE
spfile format '/sap_bkp/ECT/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_ECT
plus archivelog format '/sap_bkp/ECT/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_ECT;
}