-- Realizar a instalação dos pre-requisitos, comando abaixo instala os pre-requisitos do 19c mais recentes.
yum install -y oracle-database-preinstall-19c
-- Ou caso queira de uma versão especifica.
yum -y install oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm

-- Criar directorio para receber o binario do upgrade neste caso é do 19c
[oracle@sky-teste-oracle-dba product]$ cd /u01/app/oracle/product
[oracle@sky-teste-oracle-dba product]$ mkdir 19.3.0
[oracle@sky-teste-oracle-dba product]$ ls
12.2.0  19.3.0


-- Exporta as variaveis de ambiente.
export ORACLE_BASE=/u01/app/oracle

export ORACLE_HOME=/u01/app/oracle/product/19.3.0.0/db_2
--ou
export ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/oraapex
export SOFTWARE_DIR=/u01/software
export ORA_INVENTORY=/u01/app/oraInventory

export PATH=$PATH:$ORACLE_HOME/bin

export PATH="/u01/app/oracle/product/19.0.0.0/oraapex/bin:/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/oracle/.local/bin:/home/oracle/bin:/u01/app/oracle/product/19.0.0.0/oraapex/"
export PWD="/u01/app/oracle/product/19.0.0.0/oraapex"
export LD_LIBRARY_PATH="/u01/app/oracle/product/19.0.0.0/oraapex/lib:/lib:/usr/lib"
export ORACLE_SID="oraapex"
export ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/oraapex
export TEMP=/tmp
export TMP=/tmp
export CLASSPATH="/u01/app/oracle/product/19.0.0.0/oraapex/JRE:/u01/app/oracle/product/19.0.0.0/oraapex/jlib:/u01/app/oracle/product/19.0.0.0/oraapex/rdbms/jlib"

-- Para versões de SO com 8 usar o abaixo principalmente para 19c
export CV_ASSUME_DISTID=RHEL8

-- instalar o bynario
cd /u01/app/oracle/product/19.0.0.0/oraapex/
./runInstaller

-- ou silence mode, tem que configurar o response file, precisa criar o response file ou ir editando até a parte do root scripts aonde deve colocar false.
-- https://www.br8dba.com/install-oracle-19c-database-software-in-silent-mode/
-- Executar o pre-requisito
./runInstaller -executePrereqs -silent -responseFile /u01/app/oracle/product/19.0.0.0/oraapex/install/response/db_install.rsp

-- apos o pre-requisito, executar a instalação
./runInstaller -silent -responseFile /u01/app/oracle/product/19.0.0.0/oraapex/install/response/db_install.rsp

-- nesse caso vamos executar com o ignore pois o que gerou de erro no pre-requisito não impacta na instalação.
./runInstaller -ignorePrereq -waitforcompletion -silent -responseFile /u01/app/oracle/product/19.0.0.0/oraapex/install/response/db_install.rsp 

-- Apos instalação realizar o preupgrade
-- aponte as variaveis para o ambiente antigo 12cR2
export ORACLE_HOME=/u01/app/oracle/product/12.2.0.1/oraapex
export ORACLE_BASE=/u01/app/oracle
export PATH=/usr/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/oracle/.local/bin:/home/oracle/bin
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export ORACLE_SID=oraapex

-- Executar dentro do banco
SET SERVEROUTPUT ON;
EXECUTE DBMS_PREUP.INVALID_OBJECTS;
EXECUTE DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
EXECUTE DBMS_STATS.GATHER_DICTIONARY_STATS;
EXECUTE DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;
PURGE DBA_RECYCLEBIN;

declare
list_failures integer(3) :=0;
begin
DBMS_MVIEW.REFRESH_ALL_MVIEWS(list_failures,'C','', TRUE, FALSE);
end;
/

-- criar um ponto de restauração antes do upgrade
archive log list
alter system set db_recovery_file_dest_size=10G;

select flashback_on from v$database;
select name,open_mode,log_mode from v$database;
show parameter compatible
show parameter recovery
select * from V$restore_point;

create restore point pre_upgrade guarantee flashback database;


col name for a20
col GUARANTEE_FLASHBACK_DATABASE for a10
col TIME for a60
set lines 190
select NAME,GUARANTEE_FLASHBACK_DATABASE,TIME from V$restore_point;

--SYNTAX do preupgrade, deve executar o que o preupgrade gerar de comandos.
[oracle@vmlnxdev016 oraapex]$ /u01/app/oracle/product/12.2.0.1/oraapex/jdk/bin/java -jar /u01/app/oracle/product/19.0.0.0/oraapex/rdbms/admin/preupgrade.jar FILE DIR /u01/app/oracle/product/19.0.0.0/software
==================
PREUPGRADE SUMMARY
==================
  /u01/app/oracle/product/19.0.0.0/software/preupgrade.log
  /u01/app/oracle/product/19.0.0.0/software/preupgrade_fixups.sql
  /u01/app/oracle/product/19.0.0.0/software/postupgrade_fixups.sql

Execute fixup scripts as indicated below:

Before upgrade:

Log into the database and execute the preupgrade fixups
@/u01/app/oracle/product/19.0.0.0/software/preupgrade_fixups.sql

After the upgrade:

Log into the database and execute the postupgrade fixups
@/u01/app/oracle/product/19.0.0.0/software/postupgrade_fixups.sql

Preupgrade complete: 2026-02-21T11:46:26


---//---


-- Shutdown Database
Shutdown immediate;

-- Copiar pwdfile, spfile, pfile, tnsnames.ora, listener.ora, sqlnet se tiver do 12cR2 para o 19c
cp $ORACLE_HOME/dbs/spfileoraapex.ora /u01/app/oracle/product/19.0.0.0/oraapex/dbs/
cp $ORACLE_HOME/dbs/pfileoraapex.ora /u01/app/oracle/product/19.0.0.0/oraapex/dbs/
cp $ORACLE_HOME/dbs/orapworaapex /u01/app/oracle/product/19.0.0.0/oraapex/dbs/
cp $ORACLE_HOME/network/admin/tnsnames.ora /u01/app/oracle/product/19.0.0.0/oraapex/network/admin/


-- iniciar o upgrade
export ORACLE_HOME=/u01/app/oracle/product/19.0.0.0/oraapex
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=oraapex

-- logar no banco em modo upgrade
sqlplus / as sysdba

startup upgrade;

select name,open_mode,cdb,version,status from v$database,v$instance;

-- executar o catctl.pl
nohup /u01/app/oracle/product/19.0.0.0/oraapex/perl/bin/perl catctl.pl -l /home/oracle/whileupgrade -n 4 catupgrd.sql &
--ou
nohup $ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catctl.pl -d $ORACLE_HOME/rdbms/admin -l /home/oracle/ -n 4 catupgrd.sql &

-- Subir o banco normalmente apos o upgrade
startup;

-- Componentes do BD
set lines 333 pages 111
col COMP_NAME form a55
select comp_name, version, status from dba_registry;
select name,open_mode,cdb,version,status from v$database,v$instance;

-- validar objetos invalidos e faz o recompile
select count(*) from dba_objects where status='INVALID';
@?/rdbms/admin/utlrp.sql


-- Apos o recompile com sucesso executar o posupgrade que foi gerado no preupgrade
@/u01/app/oracle/product/19.0.0.0/software/postupgrade_fixups.sql

-- verifica o timezone
COL PROPERTY_NAME FOR A25
COL PROPERTY_VALUE FOR A21
Select version from v$timezone_file;


   VERSION
----------
        26


select PROPERTY_NAME,PROPERTY_VALUE from database_properties where property_name ='DST_PRIMARY_TT_VERSION';

PROPERTY_NAME             PROPERTY_VALUE
------------------------- ---------------------
DST_PRIMARY_TT_VERSION    26


-- verificar o compatible e mudar
ALTER SYSTEM SET COMPATIBLE = '19.0.0' SCOPE=SPFILE;

select name,open_mode,version from v$database,v$instance;

-- executar a atualização do timezone se necessario
@/u01/app/oracle/product/19.0.0.0/oraapex/rdbms/admin/utltz_upg_check.sql
