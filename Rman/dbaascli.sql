--
--https://docs.oracle.com/en/engineered-systems/exadata-cloud-service/ecscm/ecs-managing-db-backup-and-recovery.html#GUID-868D7AFE-66A7-4CED-8DEF-E75F53898310
--

-- Coomandos para verificar bkp (gera um log com as configurações), use vi ou outro editor para abrir o arquivo e analisar.
dbaascli database backup --help

dbaascli database backup --dbname ECC --list
dbaascli database backup --dbname ECC --getConfig
dbaascli database backup --dbname ECC --getConfig
dbaascli database backup --dbname ECC --showHistory   

-- arquivos de configuração do dbaascli
ls -lt /var/opt/oracle/creg/
/var/opt/oracle/log/dbHome/patch


--  Logs pedido pela OCI
/var/log/cellos

-- Desabilitar bkp atuomatico deletando archives automaticamente gerando problema.
1 - gerar o arquivo e alterar os parametros de acordo com a documentação
dbaascli database backup --dbname PSP --getConfig

2- Subir o arquivo gerado e alterado os parametros, com comando abaixo.
dbaascli database backup --configure --configFile <file_name> --dbname <database_name>

dbaascli database backup --configure --configFile /var/opt/oracle/log/dtrs/staging/tmpl/backup-378fb064-acb2-4cdc-9fd1-fb33b6378cd0-20251114-93636.cfg --dbname LTP

-- list backups
dbaascli database backup --dbname ORADEV --list --backupType ARCHIVELOG 

-- VERIFICA OS parametros de configuração do banco
SELECT * FROM v$nls_parameters;

-- Comandos para criar banco de dados no Exadata Cloud@Customer (ExaCC) usando dbaascli
dbaascli database create --dbname "ORAKPV" --dbUniqueName "KPVPRD" --dbSID "kpvprd" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "120000" --pgaSizeInMB "40000" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "ORAKPV" --dbUniqueName "KPVPRD" --dbSID "kpvprd" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "120000" --pgaSizeInMB "40000" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- Kiprev DEV
dbaascli database create --dbname "ORADEV" --dbUniqueName "ORADEV" --dbSID "oradev" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" 
--dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "16000" --pgaSizeInMB "5642" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 1000000 
--tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

dbaascli database create --dbname "APEXDEV" --dbUniqueName "APEXDEV" --dbSID "apexdev" --oracleHomeName "OraHome2" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "5000" --pgaSizeInMB "3000" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 100000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE


-- KIPREV DRS
dbaascli database create --dbname "ORAKPV" --dbUniqueName "kpvstby" --dbSID "kpvstby" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "120000" --pgaSizeInMB "40000" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

dbaascli database create --dbname "orarcu" --dbUniqueName "orarcu_55b_gru" --dbSID "orarcustby" --oracleHomeName "OraHome2" --createAsCDB true 
--dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "7600" --pgaSizeInMB "5000" 
--datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 300000 --tdeConfigMethod "FILE" 
--honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- APEX DR
dbaascli database create --dbname "APEXPRD" --dbUniqueName "apexstby" --dbSID "apexstby" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "5000" --pgaSizeInMB "3000" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 50000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE


-- SAP DR
dbaascli database create --dbname "ECC" --dbUniqueName "ECCSTBY" --dbSID "ECCSTBY" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "80000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 3000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "POP" --dbUniqueName "POPSTBY" --dbSID "POPSTBY" --oracleHomeName "OraHome2" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 300000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "SJP" --dbUniqueName "SJPSTBY" --dbSID "SJPSTBY" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 300000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "LTP" --dbUniqueName "LTPSTBY" --dbSID "LTPSTBY" --oracleHomeName "OraHome4" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 300000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "PSP" --dbUniqueName "PSPSTBY" --dbSID "PSPSTBY" --oracleHomeName "OraHome5" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 300000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- SAP HOM
dbaascli database create --dbname "ECQ" --dbUniqueName "ECQ" --dbSID "ECQ" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "30000" --pgaSizeInMB "6000" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 25000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "LTH" --dbUniqueName "LTH" --dbSID "LTH" --oracleHomeName "OraHome2" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "30000" --pgaSizeInMB "6000" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 20000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "POH" --dbUniqueName "POH" --dbSID "POH" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "24000" --pgaSizeInMB "6000" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 20000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "ECT" --dbUniqueName "ECT" --dbSID "ECT" --oracleHomeName "OraHome4" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "20000" --pgaSizeInMB "6000" --datafileDestination "+DATAC3" --fraDestination "+RECOC3" --fraSizeInMB 250000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- SAP PRD
dbaascli database create --dbname "ECC" --dbUniqueName "ECC" --dbSID "ECC00" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "80000" --pgaSizeInMB "17280" --datafileDestination "+DATAC1" --fraDestination "+RECOC" --fraSizeInMB 3000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "LTP" --dbUniqueName "LTP" --dbSID "LTP00" --oracleHomeName "OraHome2" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 3000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "POP" --dbUniqueName "POP" --dbSID "POP00" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "PSP" --dbUniqueName "PSP" --dbSID "PSP00" --oracleHomeName "OraHome4" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE
dbaascli database create --dbname "SJP" --dbUniqueName "SJP" --dbSID "SJP00" --oracleHomeName "OraHome5" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "26000" --pgaSizeInMB "17280" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- SAP DR
dbaascli database create --dbname "ECC" --dbUniqueName "ECC" --dbSID "ECC00" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "UTF8" --dbNCharset "UTF8" --dbLanguage "BRAZILIAN PORTUGUESE" --dbTerritory "BRAZIL" --sgaSizeInMB "80000" --pgaSizeInMB "17280" --datafileDestination "+DATAC2" --fraDestination "+RECOC" --fraSizeInMB 3000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE


-- KIPREV HOM
dbaascli database create --dbname "ORAKPVHM" --dbUniqueName "ORAKPVHM" --dbSID "orakpvhm" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "64000" --pgaSizeInMB "20000" --datafileDestination "+DATAC2" --fraDestination "+RECOC2" --fraSizeInMB 1000000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

dbaascli database create --dbname "APEXHOM" --dbUniqueName "APEXHOM" --dbSID "apexhom" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "5000" --pgaSizeInMB "3000" --datafileDestination "+DATAC2" --fraDestination "+DATAC2" --fraSizeInMB 100000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- APEX PRD
dbaascli database create --dbname "APEXPRD" --dbUniqueName "APEXPRD" --dbSID "apexprd" --oracleHomeName "OraHome3" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "5000" --pgaSizeInMB "3000" --datafileDestination "+DATAC1" --fraDestination "+RECOC1" --fraSizeInMB 100000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- CATALOGO PRD
dbaascli database create --dbname "dbrman" --dbUniqueName "dbrman" --dbSID "dbrman" --oracleHomeName "OraHome1" --createAsCDB false --dbCharset "WE8ISO8859P15" --dbNCharset "AL16UTF16" --dbLanguage "AMERICAN" --dbTerritory "AMERICA" --sgaSizeInMB "10000" --pgaSizeInMB "6412" --datafileDestination "+DATAC4" --fraDestination "+RECOC4" --fraSizeInMB 100000 --tdeConfigMethod "FILE" --honorNodeNumberForInstance "TRUE" --enableParallelDBCreation "TRUE" --waitForCompletion TRUE

-- Arrumar problema na wallet

--#Verificar a senha

$ORACLE_HOME/bin/mkstore -wrl /var/opt/oracle/dbaas_acfs/<DBNAME>/db_wallet -viewEntry tde_ks_passwd

--#Remover ou fazer backup da wallet existente

cd var/opt/oracle/dbaas_acfs/PDS/wallet_root/tde
mv ewallet.p12 ewallet.p12_bkp
mv cwallet.sso cwallet.sso_bkp

--#Processo para criar a wallet

SQL> SHOW PARAMETER WALLET_ROOT   <<<<<<< IDENTIFY THE DIRECTORY PATH AND USE THE SAME IN BELOW COMMAND AS <WALLET_ROOT>/TDE

SQL> ADMINISTER KEY MANAGEMENT CREATE KEYSTORE '/var/opt/oracle/dbaas_acfs/pds/wallet_root/tde' IDENTIFIED BY "<TDE PASSWORD>";

SQL> ALTER SYSTEM SET TDE_CONFIGURATION="KEYSTORE_CONFIGURATION=FILE" SCOPE=BOTH;

--Depois reinicie o banco.

SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY *******;

SQL> ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY "Tde8e9CScFvNQw1" WITH BACKUP;

SQL> ADMINISTER KEY MANAGEMENT CREATE AUTO_LOGIN KEYSTORE FROM KEYSTORE '/var/opt/oracle/dbaas_acfs/PDS/wallet_root/tde' IDENTIFIED BY "Tde8e9CScFvNQw1";

-- teste
SQL> ADMINISTER KEY MANAGEMENT SET KEYSTORE CLOSE;

SQL> SELECT * FROM V$ENCRYPTION_WALLET;

SQL> SELECT CON_ID,KEY_ID,ACTIVATION_TIME,CREATION_TIME FROM V$ENCRYPTION_KEYS;

--#Caso demora para atualizar na console pode tentar rodar isso

dbaascli diag healthcheck
sudo systemctl restart dbcsagent
sudo systemctl restart dbcsmonitor

-------------- // ----------------

Configurar TDE no ambiente Origem(Primário) / Destino(Standby) para configuração HIBRIDA no oracle 19c:

On primary:

Create new TDE wallet directory 
alter system set wallet_root='<path>' scope=spfile sid='*';
alter system set TABLESPACE_ENCRYPTION=DECRYPT_ONLY scope=spfile sid='*';
restart database in RAC rolling fashion
Set TDE_CONFIGURATION after DB bounce 
ALTER SYSTEM SET TDE_CONFIGURATION = "KEYSTORE_CONFIGURATION=FILE" SCOPE = BOTH SID = '*';

On Standby:

check WRL_PARAMETER point to the correct TDE Wallet Directory , STATUS is "OPEN AUTOLOGIN"
Take a manual backup of TDE Wallet Directory 
alter system set wallet_root='<path>' scope=spfile sid='*';
alter system set TABLESPACE_ENCRYPTION=AUTO_ENABLE scope=spfile sid='*';
restart database in RAC rolling fashion
Set TDE_CONFIGURATION after DB bounce 
ALTER SYSTEM SET TDE_CONFIGURATION = "KEYSTORE_CONFIGURATION=FILE" SCOPE = BOTH SID = '*';

Pause MRP on standby<<<<<<<<<<<<<<

On primary:

ADMINISTER KEY MANAGEMENT CREATE KEYSTORE IDENTIFIED BY xxxxxxxxxx;     
Confirm correct wallet is open with correct Location and Status is correct.
Take a manual backup of TDE Wallet Directory
ADMINISTER KEY MANAGEMENT SET KEY FORCE KEYSTORE IDENTIFIED BY xxxxxxxxxx WITH BACKUP USING 'masterkey_backup';  
Confirm MASTERKEY_ACTIVATED column in V$DATABASE_KEY_INFO becomes YES
ADMINISTER KEY MANAGEMENT CREATE AUTO_LOGIN KEYSTORE FROM KEYSTORE IDENTIFIED BY xxxxxxxxxx;   
Take another manual backup of TDE Wallet Directory after SET KEY.
Copy the primary's wallets .p12 and .sso to the standby server's $WALLET_ROOT/tde directory.

On Standby:

Confirm correct wallet is open 
Take another manual backup of TDE Wallet Directory after standby configuration.
Restart MRP and confirm MASTERKEY_ACTIVATED column in V$DATABASE_KEY_INFO becomes YES

select MASTERKEY_ACTIVATED from V$DATABASE_KEY_INFO;

set lines 400
col key_id format a60
col key_use format a15
col creation_time format a20
col activation_time format a20
col tag format a20
SELECT KEY_ID, 
       KEY_USE,
       TAG,
       to_char(CREATION_TIME,'dd/mm/yyyy hh24:mi:ss') as creation_time, 
       to_char(ACTIVATION_TIME,'dd/mm/yyyy hh24:mi:ss') as activation_time
FROM V$ENCRYPTION_KEYS ;

-- ativar master key
ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY "S1SCVP2024#OR#";

-- ativa a master key
ADMINISTER KEY MANAGEMENT SET KEY IDENTIFIED BY "S1SCVP2024#OR#" WITH BACKUP;

Realizar o mapeamento dos datafiles para serem removidos no ambiente DESTINO New ExaCC
sqlplus /nolog
conn /as sysdba
set heading off linesize 999 pagesize 0 feedback off trimspool on 
spool /tmp/delete_ASM_files_LDT.sh
select 'asmcmd rm '||name from v$datafile
union all
select 'asmcmd rm '||name from v$tempfile
union all
select 'asmcmd rm '||member from v$logfile;
spool off

'+DATAC1/ECC/CONTROLFILE/control_01.ctl', '+RECOC1/ECC/CONTROLFILE/control_02.ctl'

-- Verifca informações do home
dbaascli dbhome info 

-- Syncronizar com a OCI caso em algum momento tenha perdido a comunicação ou erro na hroa do path do home ou database
dbaascli system getDBHomes



-- Caso gerer erro na console da OCI ao executar paths de grid ou database, no nosso caso no banco foi atualizado mas gerou erro devido a objetos invalidos, 
--   sendo necessário desabilitar as triggers que geraram erros geralmente triggers de validação.
-- Erro no path no 19c, erros no verbose, em alguns casos desabilitando a trigger e executando manual resolve o problema
-- Desabilite as triggers
BEGIN
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.NO_VM_DDL DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.REFRESH_ON_ALTER DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.ADD_OBJ_TRIGGER DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER SYS.LOGMNRGGC_TRIGGER DISABLE';
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(SQLERRM);
END;
/

BEGIN
  DBMS_UTILITY.compile_schema(schema => 'WMSYS', compile_all => TRUE);
END;
/
-- Após desabilitar as triggers execute o datapatch novamente
/u02/app/oracle/product/19.0.0.0/dbhome_1/OPatch/datapatch -verbose

-- agora ative as triggers
 BEGIN
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.NO_VM_DDL ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.REFRESH_ON_ALTER ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER WMSYS.ADD_OBJ_TRIGGER ENABLE';
  EXECUTE IMMEDIATE 'ALTER TRIGGER SYS.LOGMNRGGC_TRIGGER DISABLE';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line(SQLERRM);
END;
/


-- Directorio de parametros dos bancos que estão na OCI
/var/opt/oracle/creg

-- Caso não siga os passos abaixo, não será refletido na OCI.
-- Não execute nada antes de analisar o log do dbaastools
-- Encontre o log do dbaastools mais proximo do erro (no caso de exemplo foi o de database que deu erro)
cd /var/opt/oracle/log/dbHome/patch/
vi dbaastools_2026-01-24_10-45-01-AM_293951.log

-- trecho do erro
INFO: [2026-01-24 11:27:38.299 BRT][main][PilotPluginCommandProcessor.createResumeCommand:316]
******************************* Resume command *******************************
To resume this failed session, run the following command:
dbaascli dbHome patch --oracleHomeName aaff36da-0dea-4479-be75-c4bb97764340 --waitForCompletion false --targetVersion 19.28.0.0.0 --sessionID 22775 --resume




dbaascli dbHome patch --preCheck true --oracleHomeName c555308e-294e-4f3b-b278-d7fa37ac3ed1 --prechecksOnly true --precheck_only true --precheckOnly true --hName c555308e-294e-4f3b-b278-d7fa37ac3ed1 --targetVersion 19.28.0.0.0 --executePrereqs true
dbaascli dbHome patch --oracleHomeName c555308e-294e-4f3b-b278-d7fa37ac3ed1 --waitForCompletion false --targetVersion 19.28.0.0.0 --sessionID 22775 --resume
dbaascli dbHome patch --oracleHomeName ee05fdf0-0537-4d86-9646-2d7adf69489f --waitForCompletion false --targetVersion 19.28.0.0.0 --resume

dbaascli database runDatapatch --dbname APEXDEV --executePrereqs true --resume --sessionID 202602 
dbaascli dbhome patch --oracleHome <path> --targetVersion <version> --resume


dbaascli dbHome patch --oracleHomeName OraHome3 --waitForCompletion false --targetVersion 19.28.0.0.0 --sessionID 49187 --resume

a622e4dd-48ec-40ff-86fd-299244a6abde


-- Execute com root o comando sugerido no log acima.
[root@exacc01-kpv-hom-db01 ~]# dbaascli dbHome patch --oracleHomeName aaff36da-0dea-4479-be75-c4bb97764340 --waitForCompletion false --targetVersion 19.28.0.0.0 --sessionID 22775 --resume
DBAAS CLI version 25.3.1.0.0
Executing command dbHome patch --oracleHomeName aaff36da-0dea-4479-be75-c4bb97764340 --waitForCompletion false --targetVersion 19.28.0.0.0 --sessionID 22775 --resume
Job id: 0f45608c-c386-4368-a06d-ae00b1d9890a
Session log: /var/opt/oracle/log/dbHome/patch/dbaastools_2026-01-24_12-48-23-PM_216584.log
Job accepted. Use "dbaascli job getStatus --jobID 0f45608c-c386-4368-a06d-ae00b1d9890a" to check the job status.

-- Em alguns minutos vai refletir na OCI, caso não faça via dbaascli não tera efeito na OCI e ficara com versão defasada na console da OCI.
-- Execute  dbaascli job getStatus com o jobID retornado no comando acima para acompanhar o status do patch
job getStatus --jobID 0f45608c-c386-4368-a06d-ae00b1d9890a

-- apos isso aguarde uns minutos e valide na OCI se o patch foi aplicado com sucesso.

--- /// ---

dbaascli admin getSingleDbDetails --dbname PDS
dbaascli database status --dbname PDS

-- Apos encontrar o log, encontre o comando que gerou o erro

-- valida tde
dbaascli tde status --dbname orakpvhm
dbaascli tde status --dbname SJP
dbaascli tde status --dbname POP
dbaascli tde status --dbname PSP
dbaascli tde status --dbname ECC
dbaascli tde status --dbname LDT

set pages 5000 lines 1000
col inst_id for 99
col wrl_parameter for a60
col status for a15
col wrl_type for a15
select inst_Id,wrl_type,wrl_parameter,status,wallet_type from gv$ENCRYPTION_WALLET;


Allow group Grp-temp-CSH to manage all-resources in compartment InstallExaCC where target.vmcluster.id = 'ocid1.vmcluster.oc1.sa-saopaulo-1.antxeljrminy63qaiqnv2ezybseqdltrfhzuwkwhehe2yz5vlrgqwyxt3noa'
allow group Grp-temp-CSH to manage vmclusters in compartment InstallExaCC where target.vmcluster.id = 'oocid1.vmcluster.oc1.sa-saopaulo-1.antxeljrminy63qaiqnv2ezybseqdltrfhzuwkwhehe2yz5vlrgqwyxt3noa'
allow group Grp-temp-CSH to manage exadata-vmclusters in compartment InstallExaCC where target.vmcluster.id = 'ocid1.vmcluster.oc1.sa-saopaulo-1.aaaa...'



Allow group Grp-temp-CSH to manage all-resources in compartment COMP_01
allow group Grp-temp-CSH to use virtual-network-family in compartment installExaCC

allow group Grp-temp-CSH to manage exadata-vmcluster-networks in compartment InstallExaCC where target.resource.id = 'ocid1.vmclusternetwork.oc1.sa-saopaulo-1.antxeljrminy63qa3pq6kzr5ifdfqr5wsbysoayz7ci7fd33p3qiuiqu53rq'
allow group Grp-temp-CSH to manage exadata-vmcluster-networks in compartment InstallExaCC


allow group Grp-temp-CSH to use cloud-vmclusters in compartment compartment_name where any {request.permission='CLOUD_VM_CLUSTER_UPDATE_EXADATA_STORAGE', request.permission='CLOUD_VM_CLUSTER_UPDATE_LOCAL_STORAGE'}
allow group Grp-temp-CSH to use cloud-exadata-infrastructures in compartment compartment_name where request.permission = 'CLOUD_EXADATA_INFRASTRUCTURE_INSPECT'
allow group Grp-temp-CSH to use cloud-vmclusters in compartment compartment_name where request.permission = 'CLOUD_VM_CLUSTER_INSPECT'

allow group Grp-temp-CSH  to manage cloud-exadata-infrastructures in compartment InstallExaCC

-- comando para toda infra
Allow group Grp-temp-CSH to manage exadata-infrastructures in compartment InstallExaCC


-- verifica imagens disponiveis para download
dbaascli cswlib showImages

-- verificar imagens do dbhome localmente
dbaascli cswLib listLocal

-- baixa uma imagem especifica localmente precisa da tag.
dbaascli cswlib download --imageTag 19.30.0.0.0

-- Atica e modifica a imagem padrão do home a ser criado
dbaascli dbImage activateBP --version 19.28.0.0.0 --bp JUL2025

-- Comando para listar imagens do grid disponiveis.
dbaascli cswlib showImages --product grid

-- Comando para listar imagens do database disponiveis.
dbaascli cswlib showImages --product database

-- apos uma migração aonde um banco veio da 19.24 por exemplo e nosso novo home é 19.30, é necessário aplicar o patch para atualizar o home e depois aplicar o datapatch para atualizar os bancos.
-- A imagem tem que existir no SO localmente, caso contrário, baixe a imagem com o comando acima e depois execute o patch.
dbaascli dbHome patch --oracleHomeName OraHome1 --waitForCompletion false --targetVersion 19.30.0.0.0
dbaascli database runDatapatch --dbname dbrman --executePrereqs true --waitForCompletion true


pwcopy /tmp/pwdapexstby.1591.1225798277 +DATAC1/APEXSTBY/PASSWORD/pwdapexstby.1591.1225798277



srvctl modify database -db dbrman -pwfile +DATAC4/DB_UNKNOWN/PASSWORD/pwddb_unknown.260.1232103595


asmcmd
cd +DATAC4/DBRMAN/PASSWORD/
mkalias +DATAC4/DB_UNKNOWN/PASSWORD/pwddb_unknown.260.1232103595 +DATAC4/DBRMAN/PASSWORD/orapwdbrman


rmalias +DATAC4/DB_UNKNOWN/PASSWORD/pwddb_unknown.260.1232103595

pwcopy -f --dbuniquename apexprd  +DATAC1/APEXPRD/PASSWORD/pwdapexprd.1591.1225798277 /tmp/pwdapexprd.1591.1225798277

pwcopy -f --dbuniquename apexprd /tmp/pwdapexprd.1591.1225798277 +DATAC1/APEXSTBY/PASSWORD/pwdapexprd.1591.1225798277

pwcopy -f --dbuniquename dbrman /acfs01/bkp_catalog/orapwdbrman +DATAC4/DBRMAN/PASSWORD/orapwdbrman


orapwd file='/acfs01/bkp_catalog/orapwdbrman' dbuniquename='dbrman' asmfile='+DATAC4/DBRMAN/PASSWORD/orapwdbrman' format=12


orapwd describe file='/acfs01/bkp_catalog/orapwdbrman' format=12.2 asmfile='+DATAC4/DBRMAN/PASSWORD/orapwdbrman' dbuniquename='dbrman'


orapwd input_file='/acfs01/bkp_catalog/orapwdbrman' asmfile='+DATAC4/DBRMAN/PASSWORD/orapwdbrman' dbuniquename='dbrman'


orapwd input_file='/acfs01/bkp_catalog/orapwdbrman' file='+DATAC4/DBRMAN/PASSWORD/orapwdbrman' dbuniquename='dbrman' force=y 

-- 
-- orarcu
orapwd input_file='/tmp/pwdorarcu' file='+DATAC1/ORARCUSTBY/password/pwdorarcu' dbuniquename='orarcustby'
orapwd input_file='/tmp/pwdapexstby' file='+DATAC1/APEXSTBY/PASSWORD/pwdapexstby' dbuniquename='apexstby'

srvctl modify database -db apexstby -pwfile ''
srvctl modify database -db orarcustby -pwfile '+DATAC1/ORARCUSTBY/PASSWORD/pwdorarcustby.1582.1233330863'

'+DATAC1/APEXSTBY/PASSWORD/pwdapexstby.1585.1236166073'
--



sqlplus sys/S1SCVP2024#OR#@//10.98.1.81:1521/dbrman as sysdba

# Remove o registro antigo para não dar conflito
srvctl modify database -d dbrman -pwfile ""

# Remove o arquivo problemático do ASM
asmcmd rm +DATAC4/DBRMAN/PASSWORD/orapwdbrman

# Copia o arquivo do ACFS para o ASM com as permissões corretas
asmcmd pwcopy /acfs01/bkp_catalog/orapwdbrman +DATAC4/DBRMAN/PASSWORD/orapwdbrman
asmcmd pwcopy /acfs01/bkp_catalog/orapwdbrman +DATAC4/DBRMAN/PASSWORD/pwdbrman

# Registra o novo arquivo no Clusterware
srvctl modify database -d dbrman -pwfile +DATAC4/DBRMAN/PASSWORD/orapwdbrman


orapwd file='+DATAC4/DBRMAN/PASSWORD/orapwdbrman' password='S1SCVP2024#OR#' entries=10 force=y

orapwd file='+DATAC4/DBRMAN/orapwdbrman' password='S1SCVP2024#OR#' entries=10 dbuniquename='dbrman' force=y