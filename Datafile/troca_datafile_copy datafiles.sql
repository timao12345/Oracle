srvctl stop database -d MIDWPRD
[oracle@dm01db03 dbs]$ srvctl status database -d MIDWPRD
Instance midwprd1 is running on node dm01db03
Instance midwprd2 is running on node dm01db04


ora.midwprd.db
      1        ONLINE  INTERMEDIATE dm01db03                 Mounted (Closed)
      2        ONLINE  INTERMEDIATE dm01db04                 Mounted (Closed)
ora.oc4j

C407169

   87 +DATA_DM01/midwprd/datafile/mfpsoalinux_soainfra.624.867557307
   88 +DATA_DM01/midwprd/datafile/prdsoalinux_soainfra.909.867709087

ora.midwprd.db
      1        ONLINE  ONLINE       dm01db03                 Open
      2        ONLINE  ONLINE       dm01db04                 Open
ora.oc4j

srvctl start database -d MIDWPRD -o mount;

set lines 10500
set pages 500
select FILE_ID, FILE_NAME, tablespace_name, status from dba_data_files where FILE_ID=88

   FILE_ID FILE_NAME                                                                                            TABLESPACE_NAME
---------- ---------------------------------------------------------------------------------------------------- ------------------------------
        88 /u01/app/oracle/product/11.2.0.4/dbhome_1/dbs/DATA_DM01                                              PRDSOALINUX_SOAINFRA

+DATA_DM01/midwprd/datafile/prdsoalinux_soainfra.905.867666207


RMAN> copy datafile 88 to '+DATA_DM01';

RMAN> sql 'alter database datafile 88 offline';

RMAN> switch datafile 88 to copy;

RMAN> recover datafile 88;

RMAN> sql 'alter database datafile 88 online';

Verificar:
SQL> col name form a75
SQL> select file#, name from v$datafile;

Após verificação OK remover os arquivos antigos



RMAN> backup as copy datafile 15 format '/oradata/newdatafile15.dbf' ;
RMAN> list backup of datafile 15;
RMAN> sql ‘alter database datafile 15 offline’;
RMAN> switch datafile 15 to copy;
RMAN> recover datafile 15 ;
RMAN> sql ‘alter database datafile 15 online’;