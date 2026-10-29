/*
Sempre fazer o export e se assegurar que esta no sid da base que esta sendo restaurada:
Ex: produção é kpvprd1 então fazer todo  procedimento fazendo o export para a "export ORACLE_SID=kpvpprd" pois a que ira ser clonada vai se chamar kpvpprd
*/

--Iniciar o banco em nomount como comando abaixo:
--Obs: db_name esta como da produção, mas estamos exportando a variável ORACLE_SID=kpvpprd e iniciando o banco com todos os caminhos do kpvpprd

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=kpvpprd
-bash-4.1$ echo $ORACLE_SID
kpvpprd

SQL> startup mount pfile='/u01/app/oracle/product/19.0.0/db_1/dbs/initkpvpprd.ora';
ORACLE instance started.

--Pode ser mais eficaz salvar um init de prod e somente alterar os dados
--Modelo abaixo de Iinit salvo do banco préPRD por garantia

kpvpprd.__data_transfer_cache_size=0
kpvpprd.__db_cache_size=35701915648
kpvpprd.__inmemory_ext_roarea=0
kpvpprd.__inmemory_ext_rwarea=0
kpvpprd.__java_pool_size=0
kpvpprd.__large_pool_size=671088640
kpvpprd.__oracle_base='/u01/app/oracle'#ORACLE_BASE set from environment
kpvpprd.__pga_aggregate_target=6039797760
kpvpprd.__sga_target=42949672960
kpvpprd.__shared_io_pool_size=134217728
kpvpprd.__shared_pool_size=6308233216
kpvpprd.__streams_pool_size=0
kpvpprd.__unified_pga_pool_size=0
*.audit_file_dest='/u01/app/oracle/admin/orakpvpprd/adump'
*.audit_trail='db'
*.compatible='19.9.0.0'
*.control_files='/data/corp/orakpvpprd/controlfile/control01.ctl','/data/corp/orakpvpprd/controlfile/control02.ctl'#Restore Controlfile
*.db_block_size=8192
*.db_file_name_convert='+DATAC1','/data/corp/orakpvpprd'
*.db_files=2048
*.db_name='KPVPPRD'
*.diagnostic_dest='/u01/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=cdb1XDB)'
*.local_listener='LISTENER'
*.log_file_name_convert='+RECOC1','/data/corp/orakpvpprd','+DATAC1','/data/corp/orakpvpprd'
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.open_cursors=2000
*.pga_aggregate_target=5642m
*.processes=2560
*.remote_login_passwordfile='EXCLUSIVE'
*.sga_max_size=42949672960
*.sga_target=42949672960
*.undo_tablespace='UNDOTBS01'


--###############################################################################################################################################
--Em nomount fazer o restore do controlfile:
--Certificar se alterou o caminho do controlfile para local correto e esta com o mesmo nome que esta no init.


-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=KPVPPRD
-bash-4.1$ echo $ORACLE_SID
KPVPPRD


RMAN> run {
2> allocate channel c1 type 'sbt_tape';
3> send 'NB_ORA_SERV=d1-netbackup21.tstcloud, NB_ORA_CLIENT=L-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
4> restore controlfile to '+ARCH/KPVPPRD/controlfile/control.clt' from 'cntrl_1160_1_862792405';
5> release channel c1;
6> }


--###############################################################################################################################################
--Passar banco para mount para ler o controlfile:

RMAN> alter database mount;

database mounted

--###############################################################################################################################################
--Restore do banco de dados:

--Iniciando o Restore dos datafiles:

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=KPVPPRD
-bash-4.1$ echo $ORACLE_SID
KPVPPRD


run {
    allocate channel c1 type 'sbt_tape';
    send 'NB_ORA_SERV=d1-netbackup21.tstcloud, NB_ORA_CLIENT=L-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
    SET NEWNAME FOR DATAFILE 1 to '+DATA/KPVPPRD/datafile/system.256.851772955';
    SET NEWNAME FOR DATAFILE 2 to '+DATA/KPVPPRD/datafile/sysaux.257.851772959';
    SET NEWNAME FOR DATAFILE 3 to '+DATA/KPVPPRD/datafile/undotbs1.258.851772961';
    SET NEWNAME FOR DATAFILE 4 to '+DATA/KPVPPRD/datafile/users.260.851772969';
    SET NEWNAME FOR DATAFILE 5 to '+DATA/KPVPPRD/datafile/rh_visum.264.851792453';
    SET NEWNAME FOR DATAFILE 6 to '+DATA/KPVPPRD/datafile/rh_visumindice.263.851792589';
    SET NEWNAME FOR DATAFILE 7 to '+DATA/KPVPPRD/datafile/rh_visum.262.851795553';
    SET NEWNAME FOR DATAFILE 8 to '+DATA/KPVPPRD/datafile/rh_visum.265.851795637';
    SET NEWNAME FOR DATAFILE 9 to '+DATA/KPVPPRD/datafile/rh_visumindice.266.851795777';
            SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
    set until time "to_date('05/08/2024 21:00:00','dd/mm/yyyy hh24:mi:ss')";
    restore database;
    switch datafile all;
        switch tempfile all;
    release CHANNEL c1;
}

--###############################################################################################################################################
--Catalogando e Iniciando o recover dos archives:
--Obs: fazer um list backup of archivelog all para identificar o conjunto de backup de archive a ser restaurado;

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=KPVPPRD
-bash-4.1$ echo $ORACLE_SID
KPVPPRD

-bash-4.1$ rman target /

Recovery Manager: Release 11.2.0.4.0 - Production on Mon Nov 10 17:03:30 2014

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

connected to target database: RHVISUM (DBID=225566803, not open)

/*Nesse caso foi feito um catalog nos backups de archive pois foi feito manual antes, mas dependendo do modo que quer fazer não precisa*/
run
{CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_SERV=d1-netbackup21.tstcloud, NB_ORA_CLIENT=L-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)";
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'dbbkp_RHVISUM_RHVISUM_1615_1_863246755';
}


--###############################################################################################################################################
-- É importante entender que o restore foi feito setando util time para 21h abaixo o recover até aonde deseja restaurar é aonde vai usar os archives
-- Por exemplo nesse caso não tinhamos backup incremental para restauar ate o horario desejado, colocamos a hora para as 23h aonde será aplicado todos os archives
run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_SERV=d1-netbackup21.tstcloud, NB_ORA_CLIENT=L-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
set until time "to_date('05/08/2024 23:00:00','dd/mm/yyyy hh24:mi:ss')";
recover database;
release channel c1;
}

--###############################################################################################################################################

SQL> show parameter name

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      RHVISUM
db_unique_name                       string      RHVIPARA
instance_name                        string      RHVIPARA
service_names                        string      RHVIPARA

--###############################################################################################################################################

SQL> alter database open resetlogs;

--###############################################################################################################################################

SQL> shut abort;
ORACLE instance shut down.


SQL> startup mount;
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260088 bytes
Variable Size             381682568 bytes
Database Buffers          679477248 bytes
Redo Buffers                5517312 bytes
Database mounted.


--###############################################################################################################################################

Certifique se que esta na base certa e execute o NID:

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=KPVPPRD
-bash-4.1$ echo $ORACLE_SID
KPVPPRD

--###############################################################################################################################################


-bash-4.1$ nid target=/ dbname=RHVIPARA

DBNEWID: Release 11.2.0.4.0 - Production on Mon Nov 10 17:12:54 2014

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

Connected to database RHVISUM (DBID=225566803)

Connected to server version 11.2.0

Control Files in database:
    +ARCH/rhvipara/controlfile/control.clt

Change database ID and database name RHVISUM to RHVIPARA? (Y/[N]) => Y

Proceeding with operation
Changing database ID from 225566803 to 2641374550
Changing database name from RHVISUM to RHVIPARA
    Control File +ARCH/rhvipara/controlfile/control.clt - modified
    Datafile +DATA/rhvipara/datafile/system.307.86328208 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/sysaux.309.86328208 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/undotbs1.303.86328208 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/users.308.86328213 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/rh_visum.306.86328207 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/rh_visumindice.315.86328207 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/rh_visum.305.86328207 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/rh_visum.314.86328208 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/datafile/rh_visumindice.316.86328207 - dbid changed, wrote new name
    Datafile +DATA/rhvipara/tempfile/temp.304.86328424 - dbid changed, wrote new name
    Control File +ARCH/rhvipara/controlfile/control.clt - dbid changed, wrote new name
    Instance shut down

Database name changed to RHVIPARA.
Modify parameter file and generate a new password file before restarting.
Database ID for database RHVIPARA changed to 2641374550.
All previous backups and archived redo logs for this database are unusable.
Database has been shutdown, open database with RESETLOGS option.
Succesfully changed database name and ID.
DBNEWID - Completed succesfully.

--###############################################################################################################################################

SQL> alter database open ;

Database altered.

Ou

SQL> alter database open resetlogs;

Database altered.

--###############################################################################################################################################

SQL> show parameter name

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      RHVIPARA
db_unique_name                       string      RHVIPARA
instance_name                        string      RHVIPARA
service_names                        string      RHVIPARA

--###############################################################################################################################################

SQL> shut abort;
ORACLE instance shut down.

--###############################################################################################################################################

Troque o nome do parâmetro db_name no init para o nome correto após fazer o nid

SQL> startup mount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260088 bytes
Variable Size             381682568 bytes
Database Buffers          679477248 bytes
Redo Buffers                5517312 bytes
ORA-01103: database name 'RHVIPARA' in control file is not 'RHVISUM'

--###############################################################################################################################################

Crie um spfile from pfile com par�metros novos:

SQL> startup mount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260088 bytes
Variable Size             381682568 bytes
Database Buffers          679477248 bytes
Redo Buffers                5517312 bytes
Database mounted.

SQL> create spfile from pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';

shutdown e startup novamente para teste.

/*
FIM
*/