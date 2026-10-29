---------
--Em produção arrumar tnsnames com os service do produção e do standby, fazer isso nas 2 máquinas
exemplo:
orcl =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = dataguard1)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = orcl)
    )
  )

orcl_stdby =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = dataguard2)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = orcl_stdby)
    )
  )


--ligar archivelog
alter database archivelog

--ligar force logging
alter database force logging;

--Adicionar standby logfiles, tem que ser sempre pelo menos 1 a mais do que o produção, Adiciona no standby  e no produção se for fazer switch over entre eles. Mas é mais para o standby
--Essa view mostra se está sendo usado   select * from v$standby_log;
ALTER DATABASE ADD standby LOGFILE ('/oracle/oradata/orcl/stadby_redo01.log') SIZE 50M;
ALTER DATABASE ADD standby LOGFILE ('/oracle/oradata/orcl/stadby_redo02.log') SIZE 50M;
ALTER DATABASE ADD standby LOGFILE ('/oracle/oradata/orcl/stadby_redo03.log') SIZE 50M;
ALTER DATABASE ADD standby LOGFILE ('/oracle/oradata/orcl/stadby_redo04.log') SIZE 50M;
-----
--se for RAC
ALTER DATABASE ADD standby LOGFILE thread 1 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 1 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 1 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 1 ('+DATAC1') SIZE 200M;

ALTER DATABASE ADD standby LOGFILE thread 2 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 2 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 2 ('+DATAC1') SIZE 200M;
ALTER DATABASE ADD standby LOGFILE thread 2 ('+DATAC1') SIZE 200M;
-----------------
-- NO PRIMARY / PROD / SOURCE --
-----------------


ALTER SYSTEM SET LOG_ARCHIVE_CONFIG='DG_CONFIG=(db_unique_name_primario,db_unique_name_standby)' SCOPE=BOTH;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=standby_tns ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=db_unique_name_standby' SCOPE=BOTH;


--LOG_ARCHIVE_CONFIG: Habita ou desabilita o comportamento de enviar as mensagens do redo log para o destino. Com a opção DG_CONFIG, podemos definir um range de até 9 destinos, definindo através do DB_UNIQUE_NAME de cada um deles.
ALTER SYSTEM SET LOG_ARCHIVE_CONFIG='DG_CONFIG=(ORCL,ORCL_STDBY)';

--LOG_ARCHIVE_DEST_1: Especifica o caminho do primeiro destino de archive do banco de dados. 
--No nosso caso ele será gravado no caminho /u01/app/oracle/archive/orcl do servidor do banco primario. A opão VALID_FOR define como sera gravado os dados.
alter system set LOG_ARCHIVE_DEST_1='LOCATION=/u01/app/oracle/archive/orcl VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=orcl';

--LOG_ARCHIVE_DEST_2: Esse parametro, defini o segundo destino de archive. Nesse parametro que concentra a magica do Oracle Dataguard, 
--  diferente com o que fizemos no primeiro destino (LOG_ARCHIVE_DEST_1), vamos fazer com que o segundo destino de archive do banco primario seja gravado no primeiro destino de archive do banco standby. 
--Veja que é exatamente o que definimos nesse parametro, pedidos para o LGWR escrever os dados de log atraves do serviço chamado orcl_stdby para o banco de dados stdby
alter system set LOG_ARCHIVE_DEST_2='SERVICE=KPVPRD_STBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=KPVPRD_STBY';

alter system set log_archive_dest_2='SERVICE=ptl_dg NOAFFIRM ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=ptl_dg'; --> um pouco diferente

--habilita o primeiro destino que é no próprio disco.
alter system set LOG_ARCHIVE_DEST_STATE_1=ENABLE;


--FAL_SERVER e FAL_CLIENT: São parâmetros de inicialização usados para o FAL (fetch archive log), ou seja é utilizado para a detecão e resolução dos destinos do Data Guard. 
-- Basicamente o nó primário o FAL_SERVER será o TNS service name do banco standby e vice-versa.
alter system set FAL_SERVER=orcl_stdby;  --> para onde vai  perguntar os archives, se virar standby
alter system set FAL_CLIENT=orcl;

--Ligar o standby
ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT=AUTO;

--verificar parametro
remote_login_passwordfile = exclusive

-- tem que criar o arquivo de senha igual em todos nos ou no ASM caso seja RAC.
orapwd file=orapwexadb1 password=ruop2390pip ignorecase=y force=y

-- 1 entrar no asmcmd e copiar o arquivo de senha de prod, pode dar um cp no +DATAC1/APEXPRD/PASSWORD/pwdapexprd.1591.1225798277
-- Exemplo 
cp pwdapexprd.1591.1225798277 /tmp/pwdapexprd.1591.1225798277
--enviar pro dataguard no nosso caso está no /tmp/ e restaurar no ASM do dataguard com comando abaixo e no usuario oracle do dataguard
-- obs: exceto o orapw do ASM, os outros orapw podem ser criados no filesystem do OS, mas o ASM tem que ser criado no ASM.
orapwd input_file='/tmp/pwdapexstby' file='+DATAC1/APEXSTBY/PASSWORD/pwdapexstby' dbuniquename='apexstby'


orapwd file='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/orapwkpvprd' password=S1SCVP2024#OR# format=12 force=y

-- verifica caminho do password file que o banco está usando
select * from V$PASSWORDFILE_INFO;
select * from V$PWFILE_USERS;

Se necessário usar o convert
 alter system set db_file_name_convert='/oracle/oradata/orcl','/oracle/oradata/orcl' scope=spfile;
 alter system set log_file_name_convert='/oracle/oradata/orcl','/oracle/oradata/orcl' scope=spfile;


ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=ENABLE;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=DEFER;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=stdby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=stdby'; 

ALTER SYSTEM SET log_archive_config='DG_CONFIG=(kpvprd1,KPVPRD_STBY)' SCOPE=BOTH;


alter system set LOG_ARCHIVE_DEST_2='SERVICE=LTPSTBY ASYNC NOAFFIRM COMPRESSION=ENABLE VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=LTPSTBY' SCOPE=BOTH;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=LTPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=LTPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' SCOPE=BOTH;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=POPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=POPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' SCOPE=BOTH;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=PSPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=PSPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' SCOPE=BOTH;

alter system set LOG_ARCHIVE_DEST_2='SERVICE=SJPSTBY LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=SJPSTBY NET_TIMEOUT=30 REOPEN=60 MAX_CONNECTIONS=5' SCOPE=BOTH;

-----------------
-- NO STANDBY  --
-----------------
Restaurar como um standby normal, montar ele igual um standby normal
copiar o tnsnames.ora da produção, copiar o orapwXXX do produção

Alterar os seguintes parametros no init
alter system set db_unique_name='orcl_stdby';
alter system set log_archive_config='DG_CONFIG=(orcl,orcl_stdby)';
alter system set LOG_ARCHIVE_DEST_1='LOCATION=/oracle/archive/orcl VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=orcl_stdby'; --> aponta para o orcl_stdby
ALTER SYSTEM SET LOG_ARCHIVE_DEST_2='SERVICE=orcl LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=orcl';  aponta para o produção mesmo, para fazer switch

alter system set LOG_ARCHIVE_DEST_STATE_1=ENABLE;
alter system set FAL_SERVER=orcl;  --> aqui os valores são os inversos do produção
alter system set FAL_CLIENT=orcl_stdby;     --> aqui os valores s�o os inversos do produção
ALTER SYSTEM SET STANDBY_FILE_MANAGEMENT=AUTO;
alter system set remote_login_passwordfile = exclusive;

ALTER SYSTEM SET log_archive_dest_4='service="PRODAR"','LGWR ASYNC NOAFFIRM delay=0 optional compression=disable max_failure=0 
max_connections=1 reopen=300 db_unique_name="PRODAR" net_timeout=30','valid_for=(all_logfiles,primary_role)' SCOPE=BOTH;


--Colocar a base no ar,
alter database mount standby database;
-----
--Ir na base de produção e habilitar o destino de archive 2, isso faz com que os archivelogs sejam enviados para o standby via sqlnet
ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=ENABLE;  --> arqui liga o envio para o standby

alter system set log_archive_dest_state_3='DEFER'; --> desabilita o envio

--Se ficar travado verificar os erros usando esse sql:
select *  from V$ARCHIVE_DEST where dest_name='LOG_ARCHIVE_DEST_2';->> verifica status do envio, se está comprimindo
-----
--Ir no standby e habilitar o recover automatico dele
alter database recover managed standby database disconnect;  --> aqui habilita o recover

--Se precisar cancelar o processo
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

--Se quiser colocar um delay entre a chega dos archives e aplicacão deles
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DELAY 30 DISCONNECT FROM SESSION;


----------------

--E dai para verificar basta fazer select ou olhar o alert, basta fazer alguns switchs e ver ele aplicando automático

SELECT sequence#, first_time, next_time,applied
FROM   v$archived_log
ORDER BY sequence#;

select thread#,dest_id,sequence#,first_time,next_time from v$archived_log where resetlogs_change#=(select resetlogs_change# from v$database) order by thread#, sequence#, dest_id;


select process,status,sequence# from v$managed_standby;


select *  from V$ARCHIVE_DEST where dest_name='LOG_ARCHIVE_DEST_2';         ->> verifica status do envio, se está comprimindo

--verifica modo do banco
select DATABASE_ROLE,open_mode,controlfile_type from v$database;

--No alert vai estar assim:
Archived Log entry 46 added for thread 1 sequence 33 ID 0x53d8b65b dest 1:
LNS: Standby redo logfile selected for thread 1 sequence 34 for destination LOG_ARCHIVE_DEST_2



-------------------------------------
log_archive_dest_2='SERVICE=exadb_stdby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=exadb_stdby';



--Se travar seta de novo os 3 em prod
alter system set log_archive_config='DG_CONFIG=(exadb,dgexadb,exadb_stdby)';
alter system set log_archive_dest_2='SERVICE=exadb_stdby LGWR ASYNC VALID_FOR=(ONLINE_LOGFILES,PRIMARY_ROLE) DB_UNIQUE_NAME=exadb_stdby';
ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=ENABLE;


--- configs KIPREV EXA DR - Primary
log_archive_config
dg_config=(KPVPRD,ORAKPV,kpv_stby)

log_archive_dest_1
LOCATION=+RECOC1 VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=KPVPRD

log_archive_dest_2
service="kpv_stby", ASYNC NOAFFIRM delay=0 optional compression=disable max_failure=0 reopen=300 db_unique_name="kpv_stby" net_timeout=30, valid_for=(online_logfile,all_roles)

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
fal_client                           string      KPVPRD
fal_server                           string      KPV_STBY


