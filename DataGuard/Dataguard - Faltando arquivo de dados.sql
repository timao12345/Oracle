/*
Erros comum ao faltar datafile ou uma tablespace.

ORA-01111: o nome para o arquivo de dados 228  desconhecido - altere para o nome correto
ORA-01110: 228 do arquivo de dados: '/u01/app/oracle/product/11.2.0/db_1/dbs/UNNAMED00228'
ORA-01157: não possivel identificar/bloquear arquivo de dados 228 - consulte arquivo de analise DBWR
ORA-01111: o nome para o arquivo de dados 228  desconhecido - altere para o nome correto
ORA-01110: 228 do arquivo de dados: '/u01/app/oracle/product/11.2.0/db_1/dbs/UNNAMED00228'
Recovery Slave PR00 previously exited with exception 1111
MRP0: Background Media Recovery process shutdown (ajuri)

*/
-- https://community.oracle.com/tech/developers/discussion/2245224/media-recovery-failed-with-error-1111

-- 1 - executar comando abaixo no standby para ver qual está faltando ou erro
SQL> select * from v$recover_file where error like '%FILE%';

FILE# ONLINE  ONLINE_ ERROR                                                                CHANGE# TIME
---------- ------- ------- ----------------------------------------------------------------- ---------- --------
       228 ONLINE  ONLINE  FILE MISSING                                                               0


-- 2 - No standby verificar se existe o datafile com unamed

select file#,name from v$datafile where name like '%UNNAMED%';

-- 3 - executar no primary / prod
SQL> select file#,name from v$datafile where file#=1679;

    FILE# NAME
---------- ---------------------------------------------------------------------------
       21 /u01/sgd/data1/sysaux03.dbf


-- 4 - podemos ver que é diferente, vamos alterar o parametro abaixo.
alter system set standby_file_management=MANUAL;


-- renomear o datafile
alter database create datafile '/oracle/CLP/19C_64/dbs/UNNAMED01679' as '/oracle/CLP/sapdata1/sapindex1/PSAPSR_INDEX_0565.dbf';

--Start the MRP
SQL> alter database recover managed standby database disconnect from session;
Database altered.

-- 5 - Apos criar o arquivo, volte o parametro como estava, neste caso estava como AUTO.

alter system set standby_file_management=AUTO;

-- neste caso o banco standby é normal estar como read only, verifique se o banco está montado (MOUNT) e execute:
alter database open read only;

-- Datafile criado as UNNAMED
-- parametro new so ira funcionar quando parametro db_create_file estiver com algum valor setado.
set lines 220
set pages 220
col name for a70
select file#, name from v$datafile;

ALTER DATABASE CREATE DATAFILE '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf' as new;


alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf';
