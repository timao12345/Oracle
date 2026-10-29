rh_visum

SQL> select open_mode, name from v$database;

OPEN_MODE            NAME
-------------------- ---------
MOUNTED              RHVISUM

SQL> select instance_name, status from v$instance;

INSTANCE_NAME    STATUS
---------------- ------------
RHVIPARA         MOUNTED

SQL> select name from v$controlfile;

NAME
--------------------------------------------------------------------------------
+ARCH/rhvipara/controlfile/control.clt

SQL> show parameter db_name

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
db_name                              string      RHVISUM




Restore controlfile:

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
restore controlfile to '+ARCH/rhvipara/controlfile/control.clt' from 'cntrl_1160_1_862792405';
release channel c1;
}

using target database control file instead of recovery catalog
allocated channel: c1
channel c1: SID=63 device type=SBT_TAPE
channel c1: Veritas NetBackup for Oracle - Release 7.5 (2013061020)

sent command to channel: c1

Starting restore at 09-11-2014 15:33:14

channel c1: restoring control file
channel c1: restore complete, elapsed time: 00:00:25
Finished restore at 09-11-2014 15:33:39

released channel: c1



Restore banco de dados:

#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=RHVIPARA
rman target / log=/home/oracle/restore_tape_RHVIPARA.log 

RMAN> run {
              allocate channel c1 type 'sbt_tape';
              send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
              SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
              SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
              SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
              SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
              SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
              SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
              SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
              SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
              SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
              SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
              set until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
              restore database;
              switch datafile all;
              switch tempfile all;
			  release CHANNEL c1;
}



#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=RHVIPARA
run
{
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS="ENV=(NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)";  
CATALOG DEVICE TYPE 'sbt_tape' BACKUPPIECE  'dbbkp_RHVISUM_RHVISUM_1615_1_863246755';
}



***recover
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=RHVIPARA

rman target / log=/home/oracle/recover_tape_RHVIPARA.log

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_SERV=d1-netbackup21.uolcloud, NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos, NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01';
set until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
recover database;
release channel c1;
}
EOF

