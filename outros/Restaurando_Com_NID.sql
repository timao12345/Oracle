Boa tarde,

Segue procedimento.


Primeiro passo é configurar o init com o db_name com o nome da produção:
Nunca Esquecer de sempre fazer o export e se assegurar que esta no sid da base que esta sendo restaurada:
Ex: a produção é RHVISUM então vou fazer todo meu procedimento fazendo o export para a "export ORACLE_SID=RHVIPARA" pois a que ira ser clonada se chama RHVIPARA
Sempre executando os comandos a baixo para ter certeza que não ira erra a base.

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA



Iniciar o banco em nomount como comando abaixo:
Obs: db_name esta como da produção, mas estou exportando a variável ORACLE_SID=RHVIPARA e iniciando o banco com todos os caminhos do RHVIPARA

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA

SQL> startup mount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';
ORACLE instance started.


Modelo de Iinit

Parâmetros importantes: 
?	db_name='RHVISUM'
-?	db_unique_name=RHVIPARA



*.audit_file_dest='/u01/app/oracle/admin/RHVIPARA/adump'
*.audit_trail='db'
*.compatible='11.2.0.4.0'
*.control_files='+ARCH/rhvipara/controlfile/control.clt'
*.db_block_size=8192
*.db_domain=''
?*.db_name='RHVISUM'
-?db_unique_name=RHVIPARA
*.diagnostic_dest='/u01/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=RHVIPARA_PARALXDB)'
*.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=172.25.12.16)(PORT=1521))'
*.log_archive_dest_1='LOCATION=+ARCH'
*.log_archive_format='%t_%s_%r.dbf'
*.open_cursors=300
*.pga_aggregate_target=1G
*.processes=300
*.remote_login_passwordfile='EXCLUSIVE'
*.sec_case_sensitive_logon=FALSE
*.sessions=335
*.sga_target=1G
*.sga_max_size=1G
*.undo_tablespace='UNDOTBS1'



###############################################################################################################################################
Em nomount faço o restore do controlfile:
Certifique se criou o controlfile no local correto e esta com o mesmo nome que esta no init.


-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA


RMAN> run {
2> allocate channel c1 type 'sbt_tape';
3> send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
4> restore controlfile to '+ARCH/rhvipara/controlfile/control.clt' from 'cntrl_1160_1_862792405';
5> release channel c1;
6> }

using target database control file instead of recovery catalog
allocated channel: c1
channel c1: SID=63 device type=SBT_TAPE
channel c1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)

sent command to channel: c1

Starting restore at 10-11-2014 16:31:55

channel c1: restoring control file
channel c1: restore complete, elapsed time: 00:00:25
Finished restore at 10-11-2014 16:32:20

released channel: c1


###############################################################################################################################################

Passo banco para mount para ler o controlfile:

RMAN> alter database mount;

database mounted

###############################################################################################################################################

Restore do banco de dados:
Obs: a posição dos parâmetros do send deve estar nesta posição, recomendado pela equipe de backup:

Erros que podem ocorrer e devem entrar em contato com a equipe de backup:

ORA-19507: failed to retrieve sequential file, handle="cntrl_1135_1_862706024", parms=""
ORA-27029: skgfrtrv: sbtrestore returned error
ORA-19511: Error received from media manager layer, error text:
   Backup file <cntrl_1135_1_862706024> not found in NetBackup catalog


Iniciando o Restore dos datafiles:

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA


RMAN> run {
2>              allocate channel c1 type 'sbt_tape';
3>              send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
4>              SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
5>              SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
6>              SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
7>              SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
8>              SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
9>              SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
10>             SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
11>             SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
                SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
12> 13>                 SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
14>             set until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
15>             restore database;
                switch datafile all;
16> 17>                 switch tempfile all;
18>             release CHANNEL c1;
19> }

allocated channel: c1
channel c1: SID=63 device type=SBT_TAPE
channel c1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)

sent command to channel: c1

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET NEWNAME

executing command: SET until clause

Starting restore at 10-11-2014 16:34:16

channel c1: starting datafile backup set restore
channel c1: specifying datafile(s) to restore from backup set
channel c1: restoring datafile 00001 to +DATA/rhvipara/datafile/system.256.851772955
channel c1: restoring datafile 00002 to +DATA/rhvipara/datafile/sysaux.257.851772959
channel c1: restoring datafile 00003 to +DATA/rhvipara/datafile/undotbs1.258.851772961
channel c1: restoring datafile 00004 to +DATA/rhvipara/datafile/users.260.851772969
channel c1: restoring datafile 00005 to +DATA/rhvipara/datafile/rh_visum.264.851792453
channel c1: restoring datafile 00006 to +DATA/rhvipara/datafile/rh_visumindice.263.851792589
channel c1: restoring datafile 00007 to +DATA/rhvipara/datafile/rh_visum.262.851795553
channel c1: restoring datafile 00008 to +DATA/rhvipara/datafile/rh_visum.265.851795637
channel c1: restoring datafile 00009 to +DATA/rhvipara/datafile/rh_visumindice.266.851795777
channel c1: reading from backup piece dbbkp_RHVISUM_RHVISUM_1157_1_862791948
channel c1: piece handle=dbbkp_RHVISUM_RHVISUM_1157_1_862791948 tag=DLY_RHVISUM_L0
channel c1: restored backup piece 1
channel c1: restore complete, elapsed time: 00:06:07
Finished restore at 10-11-2014 16:40:25

datafile 1 switched to datafile copy
input datafile copy RECID=12 STAMP=863282425 file name=+DATA/rhvipara/datafile/system.307.863282081
datafile 2 switched to datafile copy
input datafile copy RECID=13 STAMP=863282425 file name=+DATA/rhvipara/datafile/sysaux.309.863282081
datafile 3 switched to datafile copy
input datafile copy RECID=14 STAMP=863282425 file name=+DATA/rhvipara/datafile/undotbs1.303.863282081
datafile 4 switched to datafile copy
input datafile copy RECID=15 STAMP=863282425 file name=+DATA/rhvipara/datafile/users.308.863282137
datafile 5 switched to datafile copy
input datafile copy RECID=16 STAMP=863282426 file name=+DATA/rhvipara/datafile/rh_visum.306.863282075
datafile 6 switched to datafile copy
input datafile copy RECID=17 STAMP=863282426 file name=+DATA/rhvipara/datafile/rh_visumindice.315.863282079
datafile 7 switched to datafile copy
input datafile copy RECID=18 STAMP=863282426 file name=+DATA/rhvipara/datafile/rh_visum.305.863282077
datafile 8 switched to datafile copy
input datafile copy RECID=19 STAMP=863282426 file name=+DATA/rhvipara/datafile/rh_visum.314.863282081
datafile 9 switched to datafile copy
input datafile copy RECID=20 STAMP=863282426 file name=+DATA/rhvipara/datafile/rh_visumindice.316.863282079

renamed tempfile 1 to +DATA/rhvipara/tempfile/temp.259.851772963 in control file

released channel: c1

Recovery Manager complete.

###############################################################################################################################################

Catalogando e Iniciando o recover dos archives:
Obs: fazer um list backup of archivelog all para identificar o conjunto de backup de archive a ser restaurado;

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA
-bash-4.1$ rman target /

Recovery Manager: Release 11.2.0.4.0 - Production on Mon Nov 10 17:03:30 2014

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.

connected to target database: RHVISUM (DBID=225566803, not open)

RMAN> run
2> {
3> CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)";
4> CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'dbbkp_RHVISUM_RHVISUM_1615_1_863246755';
5> }

using target database control file instead of recovery catalog
new RMAN configuration parameters:
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS  "ENV=(NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)";
new RMAN configuration parameters are successfully stored

allocated channel: ORA_SBT_TAPE_1
channel ORA_SBT_TAPE_1: SID=63 device type=SBT_TAPE
channel ORA_SBT_TAPE_1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)
cataloged backup piece
backup piece handle=dbbkp_RHVISUM_RHVISUM_1615_1_863246755 RECID=1144 STAMP=863283825

###############################################################################################################################################

RMAN> run {
2> allocate channel c1 type 'sbt_tape';
3> send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
4> set until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
5> recover database;
6> release channel c1;
7> }

using target database control file instead of recovery catalog
allocated channel: c1
channel c1: SID=63 device type=SBT_TAPE
channel c1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)

sent command to channel: c1

executing command: SET until clause

Starting recover at 10/11/2014-17:07:38

starting media recovery

archived log for thread 1 with sequence 248 is already on disk as file +ARCH/rhvisum/archivelog/2014_11_05/thread_1_seq_248.1159.862792389
archived log file name=+ARCH/rhvisum/archivelog/2014_11_05/thread_1_seq_248.1159.862792389 thread=1 sequence=248
channel c1: starting archived log restore to default destination
channel c1: restoring archived log
archived log thread=1 sequence=249
channel c1: restoring archived log
archived log thread=1 sequence=250
channel c1: reading from backup piece dbbkp_RHVISUM_RHVISUM_1615_1_863246755
channel c1: piece handle=dbbkp_RHVISUM_RHVISUM_1615_1_863246755 tag=DLY_RHVISUM_L0
channel c1: restored backup piece 1
channel c1: restore complete, elapsed time: 00:00:35
archived log file name=+ARCH/rhvipara/archivelog/2014_11_10/thread_1_seq_249.1311.863284073 thread=1 sequence=249
archived log file name=+ARCH/rhvipara/archivelog/2014_11_10/thread_1_seq_250.1312.863284073 thread=1 sequence=250
media recovery complete, elapsed time: 00:00:18
Finished recover at 10/11/2014-17:08:41

released channel: c1

###############################################################################################################################################

SQL> show parameter name

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      RHVISUM
db_unique_name                       string      RHVIPARA
instance_name                        string      RHVIPARA
service_names                        string      RHVIPARA

###############################################################################################################################################

SQL> alter database open resetlogs;

###############################################################################################################################################

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


###############################################################################################################################################

Certifique se que esta na base certa e execute o NID:

-bash-4.1$ #!/bin/bash
-bash-4.1$ export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
-bash-4.1$ export ORACLE_SID=RHVIPARA
-bash-4.1$ echo $ORACLE_SID
RHVIPARA

###############################################################################################################################################


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

###############################################################################################################################################

SQL> alter database open ;

Database altered.

Ou

SQL> alter database open resetlogs;

Database altered.

###############################################################################################################################################

SQL> show parameter name

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      RHVIPARA
db_unique_name                       string      RHVIPARA
instance_name                        string      RHVIPARA
service_names                        string      RHVIPARA

###############################################################################################################################################

SQL> shut abort;
ORACLE instance shut down.

###############################################################################################################################################

Troque o nome do parâmetro db_name no init para o nome correto após fazer o nid

SQL> startup mount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260088 bytes
Variable Size             381682568 bytes
Database Buffers          679477248 bytes
Redo Buffers                5517312 bytes
ORA-01103: database name 'RHVIPARA' in control file is not 'RHVISUM'

###############################################################################################################################################

Crie um spfile from pfile com parâmetros novos:

SQL> startup mount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';
ORACLE instance started.

Total System Global Area 1068937216 bytes
Fixed Size                  2260088 bytes
Variable Size             381682568 bytes
Database Buffers          679477248 bytes
Redo Buffers                5517312 bytes
Database mounted.

SQL> create spfile from pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA101114.ora';

Faça shutdown e startup novamente para teste.

FIM
