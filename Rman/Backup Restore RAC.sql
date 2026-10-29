-- Gerar backup manual com opção de compressão, e paralelismo de 10 canais
run
{
allocate channel c1 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c2 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c3 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c4 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c5 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c6 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c7 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c8 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c9 type  disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
allocate channel c10 type disk format '/backup_acfs/BACKUP_FULL_KPV_05072025/bkp_kpv_%U.rman';
crosscheck archivelog all;
BACKUP FORMAT '/backup_acfs/BACKUP_FULL_KPV_05072025/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE;
backup as compressed backupset incremental level 0 database format '/backup_acfs/BACKUP_FULL_KPV_05072025/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_KPV;
BACKUP FORMAT '/backup_acfs/BACKUP_FULL_KPV_05072025/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE
spfile format '/backup_acfs/BACKUP_FULL_KPV_05072025/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_KPV;
}


-- backup controlfile direto para tape
RUN {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
BACKUP CURRENT CONTROLFILE;
release channel ch1;
}

-- Apos o backup 
--- Realizando start da instancia (com o FORCE se n�o tiver ainda spfile/pfile e for restaurar o spfile/pfile do bkp), e conectando no rman
export ORACLE_SID=kpvstby
rman nocatalog target /
startup nomount force;


--- Gerar cópia do init para utilizar no ambiente destino
create pfile='/xxx/pfileXXX.ora' from spfile;
mkdir -p /u01/app/oracle/admin/restore/adump
---- OU, posso restaurar o spfile/pfile do backup do control (pois o spfile vai junto)
restore spfile to pfile '$ORACLE_HOME/dbs/pfilekpvstby.ora' from '/backup_rman/restore/c-2622018584-20191111-00';
restore spfile from '/backup_rman/restore/c-2622018584-20191111-00';
---- Validar se precisa fazer algum ajuste de conf.: criar diret�rio ADUMP, sga/pga/db_unique_name/listener/controlfile etc.



---- ### - Criar arquivo de Senha para o Banco de Dados
---- ### (executar no servidor que será PRODUCÃO/STANDBY, com o usuario oracle), usar mesma senha do sys de prod.
---- ### caso não tenha senha do sys do produtivo, veja se pode alterar a senha e utilize a nova senha pra o standby
orapwd file=$ORACLE_HOME/dbs/orapwXXdbXX password=XXsenhaXX
orapwd file=$ORACLE_HOME/dbs/orapworadev password=


----- Baixar e subir a base novamente com o backup do spfile/pfile que foi restaurado
----- Tendo a ideia que já esteja dentro do $ORACLE_HOME/dbs, entre no sqlplus e execute os comandos abaixo ou no rman.
shutdown immediate;
startup pfile='pfilekpvstby.ora' nomount;



----- Restaurando controlfile do backup
----- se restaurar sem colocar um local o restore vai seguir o caminho que está no pfile que iniciou o banco podendo ja deixar dentro do ASM
restore controlfile from '/backup_rman/trdb/backup-trdb-c-17348252-20191021-00.rman';

---- colocar a base em modo MOUNT
---- validar caminho dos datafiles, se existe,(ASM ele cria sozinho, s� validar se tem o param. configurado: *.db_create_file_dest='+DATA')
alter database mount;
select file#,name from v$datafile;


-----  Limpar backups catalogados/expirados/n�o reconhecidos
crosscheck backup;
delete noprompt EXPIRED backup;

----- Catalogar arquivos de backup, com a base em MOUNT caso o backup seja fisico em um filesystem.
catalog start with '/backup_rman/restore/dwdb_';

-- Com banco em mount desatviar o flashback database pode gerar o erro ORA-38760: This database instance failed to turn on flashback database
-- ao tentar fazer recover
alter database flashback off;

---- Inicia o restore (SE ATENTAR AO UTILIZAR OS CHANNELS, SOMENTE ENTERPRISE, retirar se n�o for)
------ Se quiser log, utilizar o SPOOL
spool log to /backup_rman/bkpDBN09/trdb/restore_fullbackup.log


------ Iniciar o restore do banco (nesse caso foi utilizado o setnewname for database devido a mudan�a de nome da base para 'restore',
------ para não sobrescrever os arquivos no caminho default dela, OBS: Foi configurado o DB_UNIQUE_NAME e já estava configurado
------ o db_create_file_dest para ASM )


-- Modelos para criar o set newname dos datafiles, se necessário, para o restore.
-- Select para montar rename de datafiles para restore rman, se necessário:   ---- No / novo caminho

select ' set newname for datafile '|| h.FILE# ||' to '''|| replace(f.NAME,'+DATAC1/','+DATAC1/KPVSTBY/DATAFILE/') ||''' ; '
from V$DATAFILE_HEADER h, V$DATAFILE f
where h.FILE# = f.FILE# (+) 
order by h.file# ;

select ' set newname for datafile '|| to_char (f.FILE#, '990') ||
        ' to "/xxx/oracle/oradata/'|| lower (d.NAME) ||'/'||
        substr (f.NAME, instr (f.NAME, '/', -1, 1) + 1) ||'" ; '
  from V$DATABASE d,
        V$DATAFILE f
  order by f.TS#, f.NAME ;

select ' alter database rename file '|| FILE# ||' to ''XXX'|| f.NAME ||''' ; '
from V$DATAFILE f
order by file# ;

-- Modelo de comandos para restore e recover junto.
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
restore database;
switch datafile all;
switch tempfile all;
recover database;
}

-- modelo de comando para recover apos o restore.
run
{
allocate channel c1 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c2 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c3 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c4 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c5 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c6 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c7 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c8 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c9 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
allocate channel c10 type disk format '/backup_acfs/PDS/restore/restore_PDS_%U.rman';
recover database;
}

-- modelo com set newname.
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

----- apos finalizar o restore, criar diretorios se necessario para os arquivos que serao criados ao abrir a base (TEMP/REDO)
####------ Validar todos caminhos no banco produção
select N
  from (select name N from v$controlfile
         union all
        select member N from v$logfile
         union all
        select name N from v$datafile
         union all
        select name N from v$tempfile)
  order by N ;

-- Monta Comandos para Renomear DataFiles (sqplus), se necessário.
-- Necessario quando os Diretorios da base de Origem forem Diferentes
-- Os datafiles sao feitos acima pelo set NEWNAMEs no momento do restore, porem os REDOs e TEMPs dependendo da forma feita não, entao fazer aqui.

select ' alter database rename file '''|| f.MEMBER ||''' to '''|| replace(f.MEMBER,'+DATA_LDT/','+DATAC2/') ||''' ; '
from  V$LOGFILE f
order by f.MEMBER ;

select ' alter database rename file '''|| f.NAME ||''' to '''|| replace(f.NAME,'+DATA_LDT/','+DATAC2/') ||''' ; '
from  V$TEMPFILE f
order by f.NAME ;

---- Em casos bem especificos, pode ter o Change Tracking ativado, se estiver ativado, desativar antes do open resetlogs
select status,filename from V$BLOCK_CHANGE_TRACKING;
alter database disable block change tracking ;



-- Não RAC
ALTER SYSTEM SET undo_tablespace=UNDOTBS1 SCOPE=SPFILE;

--- Abrir namco com o resetlogs
alter database open resetlogs;
shutdown immediate;
startup;


-- também atenção se for RAC deve ser ativado o cluster_database=true, e o db_unique_name deve ser diferente do nome da instância
alter system set cluster_database=TRUE scope=spfile;
Alter database enable thread 2;
ALTER SYSTEM SET thread=1 SCOPE=SPFILE SID='ORAKPVHM1';
ALTER SYSTEM SET thread=2 SCOPE=SPFILE SID='ORAKPVHM2';

ALTER SYSTEM SET undo_tablespace=UNDOTBS1 SCOPE=SPFILE SID='ORAKPVHM1';
ALTER SYSTEM SET undo_tablespace=UNDOTBS2 SCOPE=SPFILE SID='ORAKPVHM2';

----- Apos o banco abrir com sucesso, criar o spfile direto no ASM.
create spfile='+DATAC1' from pfile='/u01/app/oracle/dbs/pfilekpvstby.ora';

-- Conferir o Parametro UNDO_TABLESPACE (caso necessário seguir o procedimento de criação de uma nova undo "criar nova undo.sql")
-- valide a undo setada no pfile é a correta, caso seje RAC
select name from v$tablespace where NAME like '%UNDO%' ;
show parameter undo_tablespace ;

ALTER SYSTEM SET undo_tablespace=PSAPUNDO1 SCOPE=SPFILE SID='pds1';
ALTER SYSTEM SET undo_tablespace=PSAPUNDO2 SCOPE=SPFILE SID='pds2';

--- Criar serviços do GRID para a instancia/database se utilizar (utilizado em GRID single, validar se o destino for RAC)
srvctl add database -d portaldb -oraclehome $ORACLE_HOME
srvctl stop database -d portaldb
srvctl start database -d portaldb
/u01/app/grid/product/12.1.0/grid/bin/crsctl status resource -t

--- Validar serviços da base
show parameter service_names

---- Validar tablespace Tempor�ria atual, e se necess�rio recriar
SELECT property_name, property_value FROM database_properties WHERE property_name='DEFAULT_TEMP_TABLESPACE';
SELECT tablespace_name, file_name, bytes/1024/1024 MB, status FROM dba_temp_files;
create temporary tablespace TEMP tempfile '+DATAC2' size 32767M autoextend on next 100M maxsize 32767M;
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP;
DROP TABLESPACE TEMP_NEW INCLUDING CONTENTS AND DATAFILES;

alter tablespace temp add tempfile 

---- Ver objetos invalidos, ver se precisa rodar o utlrp
@?/rdbms/admin/utlrp.sql

--- Validar se ficou algum REDO de 'lixo', não utilizado pelo database
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

-- To see status of all restored datafiles can be done with this SQL
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

--   The output might looks like:
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