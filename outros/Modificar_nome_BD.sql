--------------------------------------------------------------------------------------------------------------------------------------------
-- Procedimento para alterar o nome do BD apos um refresh / duplicate / criação de um ambiente que deseje alterar o nome.                 --
-- Baseando que já esteja com as variaveis de ambiente configuradas e o SID do BD já esteja setado corretamente seguir abaixo os passos.  --
--------------------------------------------------------------------------------------------------------------------------------------------

DBID= 15114161
DB_NAME (Nome do banco) = TESTE
-- Baixar o BD ou subir em mount.
SQL > shutdown immediate;
SQL > startup mount;

-- baixar o listener
lsnrctl stop

-- Usar o NID da maneira que mais convem no momento, é importante saber que se alterar o DBID terá que fazer o "alter database open resetlogs;"
-- Podemos Alterar apenas o DBID do banco de dados CDBDBAOCM (sem alterar o nome do banco de dados)
nid TARGET=sys/password@CDBDBAOCM
nid TARGET=/

-- Alterar apenas o nome do banco de dados de CDBDBAOCM para TESTE (sem alterar o DBID)
-- A cláusula SETNAME abaixo é utilizada para indicar que queremos somente alterar o nome do banco de dados.
nid TARGET=sys/password@CDBDBAOCM DBNAME=TESTE SETNAME=YES
nid TARGET=/ DBNAME=ECQ SETNAME=YES

startup mount exclusive pfile='pfileECQ.ora'; 
nid TARGET=system/T7UcVp20#24# DBNAME=ECQ SETNAME=Y
nid TARGET=/ DBNAME=ECQ SETNAME=Y

-- Alterar o DBID e também o nome do banco de dados de CDBDBAOCM para TESTE
nid TARGET=sys/password@CDBDBAOCM DBNAME=TESTE
nid TARGET=/ DBNAME=TESTE

nid TARGET=/ DBNAME=BD02

--- log de exemplo de alteração somente do nome do BD---
[oracle@TUNING-IMERSAO ~]$ nid target=/ dbname=TESTE setname=YES

DBNEWID: Release 19.0.0.0.0 - Production on Mon Jun 10 17:18:00 2024

Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.

Connected to database CDBDBAOC (DBID=1920932569)

Connected to server version 19.3.0

Control Files in database:
    /u01/oradata/CDBDBAOCM/control01.ctl
    /u01/oradata/CDBDBAOCM/control02.ctl

Change database name of database CDBDBAOC to TESTE? (Y/[N]) => y

Proceeding with operation
Changing database name from CDBDBAOC to TESTE
    Control File /u01/oradata/CDBDBAOCM/control01.ctl - modified
    Control File /u01/oradata/CDBDBAOCM/control02.ctl - modified
    Datafile /u01/oradata/CDBDBAOCM/system01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/sysaux01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/undotbs01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdbseed/system01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdbseed/sysaux01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/users01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdbseed/undotbs01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb1/system01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb1/sysaux01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb1/undotbs01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb1/users01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb2/CDBDBAOCM/132A4788CACA3D19E0636601A8C0EBB9/datafile/o1_mf_system_lypkombf_.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb2/CDBDBAOCM/132A4788CACA3D19E0636601A8C0EBB9/datafile/o1_mf_sysaux_lypkombn_.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb2/CDBDBAOCM/132A4788CACA3D19E0636601A8C0EBB9/datafile/o1_mf_undotbs1_lypkombo_.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb2/catalog_tbs1.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/temp01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdbseed/temp012023-09-15_17-01-20-170-PM.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb1/temp01.db - wrote new name
    Datafile /u01/oradata/CDBDBAOCM/pdb2/CDBDBAOCM/132A4788CACA3D19E0636601A8C0EBB9/datafile/o1_mf_temp_lypkombo_.db - wrote new name
    Control File /u01/oradata/CDBDBAOCM/control01.ctl - wrote new name
    Control File /u01/oradata/CDBDBAOCM/control02.ctl - wrote new name
    Instance shut down

Database name changed to TESTE.
Modify parameter file and generate a new password file before restarting.
Succesfully changed database name.
DBNEWID - Completed succesfully.

---------

-- Subir o banco de dados em modo nomount para setar o db_name, criar um pfile novo com nome novo do BD, depois baixar o BD novamente.
SQL> startup nomount;
SQL> alter system set db_name=ECQ scope=spfile;
SQL> create pfile='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/pfileECQ_temp.ora' from spfile; 

shutdown immediate;
--subir com o pfile novo.
SQL> startup nomount pfile='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/pfileECQ_temp.ora';


-- Mudar as entradas das strings que existirem no tnsnames.ora, ./bash_profile, listener.ora, /etc/oratab

--Criar o novo arquivo de senha o orapwd dentro do caminho $ORACLE_HOME/dbs
orapwd file=orapwSDJ password=Ora#123!12 - ok
orapwd file=orapwLDT password=Ora#123#13 - ok

orapwd file=orapwPDO password=Ora#123#14
orapwd file=orapwEDC password=Ora#123#15
orapwd file=orapwPDS password=Ora#123#16

orapwd file=orapwkpvpprd password=Ora#123#16

orapwd file=orapwdstby password=S1SCVP2024#OR#

backup as copy password file '/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/orapwkpvprd1' format '+DATAC1/KPVPRD/PASSWORD/orapwkpvprd';

-- Alterar o db_name no pfile criado e subir o banco com o novo pfile.
-- setar o SID novo e subir o BD.
--pode user o . oraenv
[oracle@TUNING-IMERSAO dbs]$ . oraenv
ORACLE_SID = [CDBDBAOCM] ? kpvpprd

[oracle@TUNING-IMERSAO dbs]$ sqlplus / as sysdba

SQL> startup nomount pfile='initkpvpprd_temp.ora';

SQL> alter database mount;
SQL> alter database open;


--Validar e subir o listener
select name from v$database;

-- Apos isso criar o spfile
create spfile from pfile;

--Fazer restart do banco.
shutdown immediate;
startup;

alter system set db_unique_name=kpvpprd scope=spfile sid='*';



*.control_files='/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/control_file_01.cf','/u02/app/oracle/product/19.0.0.0/dbhome_1/dbs/control_file_02.cf'

*.control_files='+datac01/kpvpprd/controlfile/control_file_01.cf','+datac01/kpvpprd/controlfile/control_file_02.cf'
