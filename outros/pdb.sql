-- DETERMINANDO SE UM BANCO DE DADOS � UM CDB
SELECT CDB FROM V$DATABASE;

-- VERIFICA INFORMA��ES DOS CONTAINERS
COLUMN NAME FORMAT A8
SELECT NAME, CON_ID, DBID, CON_UID, GUID FROM V$CONTAINERS ORDER BY CON_ID;

-- Verifica container name, ID e status de cada CDB
COLUMN PDB_NAME FORMAT A15
SELECT PDB_ID, PDB_NAME, STATUS FROM DBA_PDBS ORDER BY PDB_ID;


alter session set container=SABREODS; 

-- abrir PDB
alter pluggable database U3RH open;
alter pluggable database U3RH open read only;


-- Parar o PDB / descer / stop
alter session set container=PDBRCUPRD; 
shutdown immediate;

-- ou

alter pluggable database PDBRCUPRD close;

-- sube varias intancias ao mesmo tempo
ALTER PLUGGABLE DATABASE pdb5  OPEN READ WRITE INSTANCES = ('ORCLDB_1', 'ORCLDB_2');


--
select status,message from pdb_plug_in_violations;

-- comandos

alter pluggable database pdb3 datafile all offline;

ALTER PLUGGABLE DATABASE PDBRCUPRD OPEN READ ONLY RESTRICTED;


-- DROPAR UM PDB PARA FAZER O RESTORE DA FITA
-- Primeiro deve colocar o PDB offline;
alter pluggable database PDBRCUPRD close immediate;
-- Depois dropar o PDB
drop pluggable database PDBRCUPRD including datafiles;

-- Depois restaurar o PDB via RMAN, nesse meteodo é usado o duplicate pois vamos alterar o nome de PDBRCUPRD para PDBRCUQA



RUN {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
DUPLICATE PLUGGABLE DATABASE PDBRCUPRD TO PDBRCUQA
FILE_NAME_CONVERT=('+DATAC1/ORARCU_55B_GRU/3806BC3C4DD09287E0634301620AA00B/DATAFILE/','+DATAC02/ORCL/PDBRCUQA/datafile/')
PDB_NAME_CONVERT=('PDBRCUPRD','PDBRCUQA');
RELEASE CHANNEL ch1;
}


set newname for datafile 9 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/system.1510.1218726843' ;
set newname for datafile 10 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/sysaux.1528.1218726877' ;
set newname for datafile 11 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undotbs1.1519.1218726859' ;
set newname for datafile 12 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/undo_2.1512.1218726845' ;
set newname for datafile 13 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/users.1521.1218726845' ;
set newname for datafile 14 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_mds.1516.1218726823' ;
set newname for datafile 15 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_wls.1515.1218726823' ;
set newname for datafile 16 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_ums.1509.1218726845' ;
set newname for datafile 17 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_iau.1522.1218726843' ;
set newname for datafile 18 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_stb.1514.1218726825' ;
set newname for datafile 19 to '+DATAC4/ORARCUSTBY/3806BC3C4DD09287E0634301620AA00B/DATAFILE/prdfrm12c_ias_opss.1513.1218726825' ;


-- bkp orarcu
BACKUP device type disk format '/backup_acfs/orarcu_bkp/backup-PDBRCU-t%T-b%up%pc%c.rman' PLUGGABLE DATABASE PDBRCUPRD ;




duplicate database to ORCL pluggable database PDBRCUQA until time "to_date('21.03.2023 09:10:00', 'dd.mm.yyyy hh24:mi:ss')";



RUN {
  ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
  ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
  DUPLICATE PLUGGABLE DATABASE PDBRCUPRD
    TO PDBRCUQA
    PDB_NAME_CONVERT ('PDBRCUPRD','PDBRCUQA')
    FILE_NAME_CONVERT ('+DATAC1/ORARCU_55B_GRU/3806BC3C4DD09287E0634301620AA00B/DATAFILE/','+DATAC02/ORCL/PDBRCUQA/datafile/')
    USING BACKUPSET;
  RELEASE CHANNEL ch1;
  RELEASE CHANNEL ch2;
}


--
RUN {
  ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  DUPLICATE PLUGGABLE DATABASE PDBRCUPRD
    TO PDBRCUQA
    DB_FILE_NAME_CONVERT
      ('+DATAC1/ORARCU_55B_GRU/3806BC3C4DD09287E0634301620AA00B/DATAFILE/',
       '+DATAC02/ORCL/PDBRCUQA/datafile/')
    USING BACKUPSET;

  RELEASE CHANNEL ch1;
  RELEASE CHANNEL ch2;
}



--- 
RUN {
  ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'
     PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
            ENV=(NB_ORA_SID=orarcu1,
                 NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                 NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                 NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE'
     PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
            ENV=(NB_ORA_SID=orarcu1,
                 NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                 NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                 NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  -- RESTAURA O ROOT
  
  RESTORE PLUGGABLE DATABASE PDBRCUPRD;
  RECOVER PLUGGABLE DATABASE PDBRCUPRD;

  RELEASE CHANNEL ch1;
  RELEASE CHANNEL ch2;
}


---

RUN {
  ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  -- MAPEAMENTO DOS DATAFILES PRO NOVO CAMINHO
  SET NEWNAME FOR PLUGGABLE DATABASE PDBRCUPRD
      TO '+DATAC02/ORCL/PDBRCUQA/datafile/';

  RESTORE PLUGGABLE DATABASE PDBRCUPRD;
  SWITCH DATAFILE ALL;
  RECOVER PLUGGABLE DATABASE PDBRCUPRD;

  RELEASE CHANNEL ch1;
  RELEASE CHANNEL ch2;
}


RUN
{
  ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE'
    PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
           ENV=(NB_ORA_SID=orarcu1,
                NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,
                NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,
                NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';

  SET NEWNAME FOR PLUGGABLE DATABASE PDBRCUPRD TO '+DATAC02/ORCL/PDBRCUQA/datafile/%f';

  RESTORE PLUGGABLE DATABASE PDBRCUPRD;

  SWITCH DATAFILE ALL;

  RECOVER PLUGGABLE DATABASE PDBRCUPRD;

  RELEASE CHANNEL ch1;
  RELEASE CHANNEL ch2;
}


RUN {ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
  LIST PLUGGABLE DATABASE;
  LIST BACKUP OF PLUGGABLE DATABASE;
  RELEASE CHANNEL ch1;
}


run {
    ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE'PARMS='SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
    restore controlfile to '/tmp/control_file.bak' from '/c-4284662918-20251124-17';
    release channel ch1;
} 


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
set newname for datafile  1 to '+DATAC02/ORCL/DATAFILE/system.285.1204301647' ;
set newname for datafile  2 to '+DATAC02/ORCL/PDBSEED/DATAFILE/system.274.1204301413' ;
set newname for datafile  3 to '+DATAC02/ORCL/DATAFILE/sysaux.294.1204301627' ;
set newname for datafile  4 to '+DATAC02/ORCL/PDBSEED/DATAFILE/sysaux.265.1204301413' ;
set newname for datafile  5 to '+DATAC02/ORCL/DATAFILE/undotbs1.286.1204301667' ;
set newname for datafile  6 to '+DATAC02/ORCL/PDBSEED/DATAFILE/undotbs1.291.1204301413' ;
set newname for datafile  7 to '+DATAC02/ORCL/DATAFILE/users.284.1204301685' ;
set newname for datafile  8 to '+DATAC02/ORCL/DATAFILE/undotbs2.293.1204301627' ;
set newname for datafile  9 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/system.305.1204302005' ;
set newname for datafile 10 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/sysaux.299.1204302015' ;
set newname for datafile 11 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/undotbs1.300.1204302025' ;
set newname for datafile 12 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/undo_2.301.1204302035' ;
set newname for datafile 13 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/users.304.1204302005' ;
set newname for datafile 14 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_mds.1248.1205714379' ;
set newname for datafile 15 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_wls.1247.1205714381' ;
set newname for datafile 16 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_ias_ums.1246.1205714381' ;
set newname for datafile 17 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_iau.1245.1205714383' ;
set newname for datafile 18 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_stb.1244.1205714385' ;
set newname for datafile 19 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_ias_opss.1243.1205714385' ;
SWITCH DATAFILE ALL;
restore databasee;
}




run{
allocate channel ch1 type disk;
allocate channel ch2 type disk;
allocate channel ch3 type disk;
allocate channel ch4 type disk;
set newname for tempfile to '+DATA';
set newname for database to 'restore';
restore database;
switch datafile all;
switch tempfile all;
recover database;
}



run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
set newname for datafile  1 to '+DATAC02/ORCL/DATAFILE/system.285.1204301647';
set newname for datafile  2 to '+DATAC02/ORCL/PDBSEED/DATAFILE/system.274.1204301413';
set newname for datafile  3 to '+DATAC02/ORCL/DATAFILE/sysaux.294.1204301627' ;
set newname for datafile  4 to '+DATAC02/ORCL/PDBSEED/DATAFILE/sysaux.265.1204301413';
set newname for datafile  5 to '+DATAC02/ORCL/DATAFILE/undotbs1.286.1204301667';
set newname for datafile  6 to '+DATAC02/ORCL/PDBSEED/DATAFILE/undotbs1.291.1204301413';
set newname for datafile  7 to '+DATAC02/ORCL/DATAFILE/users.284.1204301685';
set newname for datafile  8 to '+DATAC02/ORCL/DATAFILE/undotbs2.293.1204301627';
set newname for datafile  9 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/system.305.1204302005';
set newname for datafile 10 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/sysaux.299.1204302015';
set newname for datafile 11 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/undotbs1.300.1204302025';
set newname for datafile 12 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/undo_2.301.1204302035';
set newname for datafile 13 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/users.304.1204302005';
set newname for datafile 14 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_mds.1248.1205714379';
set newname for datafile 15 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_wls.1247.1205714381';
set newname for datafile 16 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_ias_ums.1246.1205714381';
set newname for datafile 17 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_iau.1245.1205714383';
set newname for datafile 18 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_stb.1244.1205714385';
set newname for datafile 19 to '+DATAC02/ORCL/PDBRCUQA/DATAFILE/prdfrm12c_ias_opss.1243.1205714385';
restore database;
switch datafile all;
}


run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
recover database;
}