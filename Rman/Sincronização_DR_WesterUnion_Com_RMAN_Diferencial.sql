------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
Servidor Produção: dbtb775anew		 

SQL> col name format a70
SQL> set lines 200
SQL> select file#,name from v$datafile;

     FILE# NAME
---------- ----------------------------------------------------------------------
         1 +ORADATA/middle/datafile/system.366.818087971
         2 +ORADATA/middle/datafile/sysaux.365.818087977
         3 +ORADATA/middle/datafile/undotbs1.364.818087981
         4 +ORADATA/middle/datafile/undotbs2.267.818087989
         5 +ORADATA/middle/datafile/users.265.818087989
         6 +ORADATA/middle/datafile/middle.423.818091973
         7 +ORADATA/middle/datafile/statspack.292.818520761
         8 +ORADATA/middle/datafile/tsdlogreport01.483.866556307
         9 +ORADATA/middle/datafile/tsilogreport01.474.866556313

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

Servidor DR: drdbtb775

SQL> col name format a70
SQL> set lines 200
SQL> select file#,name from v$datafile;

     FILE# NAME
---------- ----------------------------------------------------------------------
         1 +ORADATA/middle/datafile/system.266.875727807
         2 +ORADATA/middle/datafile/sysaux.282.875727807
         3 +ORADATA/middle/datafile/undotbs1.498.875727805
         4 +ORADATA/middle/datafile/undotbs2.400.875727809
         5 +ORADATA/middle/datafile/users.280.875727827
         6 +ORADATA/middle/datafile/middle.281.875727807
         7 +ORADATA/middle/datafile/statspack.499.875727807
         8 +ORADATA/middle/datafile/tsdlogreport01.496.875727807
         9 +ORADATA/middle/datafile/tsilogreport01.399.875727809
		 


		 SQL> select * from v$recover_file;

     FILE# ONLINE  ONLINE_ ERROR                                                                CHANGE# TIME
---------- ------- ------- ----------------------------------------------------------------- ---------- ---------
         1 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         2 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         3 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         4 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         5 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         6 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         7 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         8 ONLINE  ONLINE                                                                     916113255 18-JUL-15
         9 ONLINE  ONLINE                                                                     916113255 18-JUL-15

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
		 
Servidor Produção: dbtb775anew

[dbtb775anew oracle@middle1]/replicacao/MIDDLE> rman target /
RMAN> BACKUP AS COMPRESSED BACKUPSET INCREMENTAL FROM SCN 916113255  DATABASE FORMAT '/replicacao/MIDDLE/ForStandby_%U.bkp' tag 'FORSTANDBY';
BACKUP CURRENT CONTROLFILE  FORMAT '/replicacao/MIDDLE/ForStandbyCTRL.bck';


[dbtb775anew oracle@middle1]/replicacao/MIDDLE> scp ForStandb* oracle@drdbtb775:/replicacao/MIDDLE/.
oracle@drdbtb775's password:
Permission denied, please try again.
oracle@drdbtb775's password:
ForStandby_62qci45c_1_1.bkp                                                                                                100%  118MB   1.2MB/s   01:43
ForStandby_63qci4im_1_1.bkp                                                                                                100% 5760KB   1.4MB/s   00:04
ForStandbyCTRL.bck                                                                                                         100%   79MB   1.1MB/s   01:09

Senha: so2006wes

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

Servidor DR: drdbtb775

[oracle@drdbtb775 MIDDLE]$ rman target /

RMAN> catalog backuppiece '/replicacao/MIDDLE/ForStandby_62qci45c_1_1.bkp';
RMAN> catalog backuppiece '/replicacao/MIDDLE/ForStandby_63qci4im_1_1.bkp'
RMAN> catalog backuppiece '/replicacao/MIDDLE/ForStandbyCTRL.bck'
RMAN> recover database noredo;

[oracle@drdbtb775 MIDDLE]$ sqlplus "/as sysdba"

SQL> select instance_name, host_name from v$instance;

INSTANCE_NAME    HOST_NAME
---------------- ----------------------------------------------------------------
middle           drdbtb775 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SQL> shut immediate;
ORA-01109: database not open

SQL> startup nomount;
ORACLE instance started.

[oracle@drdbtb775 MIDDLE]$ rman target /
RMAN> RESTORE CONTROLFILE FROM '/replicacao/MIDDLE/ForStandbyCTRL.bck';

[oracle@drdbtb775 MIDDLE]$ sqlplus "/as sysdba"

SQL> alter database mount;

Database altered.

SQL> set lines 10500
SQL> SELECT file#,online_status,error,change#,to_char(time,'dd/mm/yyyy hh24:mi:ss') time FROM v$recover_file;

9 rows selected.


     FILE# ONLINE_ ERROR                                                                CHANGE# TIME
---------- ------- ----------------------------------------------------------------- ---------- -------------------
         1 ONLINE  FILE NOT FOUND                                                             0
         2 ONLINE  FILE NOT FOUND                                                             0
         3 ONLINE  FILE NOT FOUND                                                             0
         4 ONLINE  FILE NOT FOUND                                                             0
         5 ONLINE  FILE NOT FOUND                                                             0
         6 ONLINE  FILE NOT FOUND                                                             0
         7 ONLINE  FILE NOT FOUND                                                             0
         8 ONLINE  FILE NOT FOUND                                                             0
         9 ONLINE  FILE NOT FOUND                                                             0

9 rows selected.

Produção																			DR
alter database rename file '+ORADATA/middle/datafile/system.366.818087971' to '+ORADATA/middle/datafile/system.266.875727807';
alter database rename file '+ORADATA/middle/datafile/sysaux.365.818087977' to '+ORADATA/middle/datafile/sysaux.282.875727807';
alter database rename file '+ORADATA/middle/datafile/undotbs1.364.818087981' to '+ORADATA/middle/datafile/undotbs1.498.875727805';
alter database rename file '+ORADATA/middle/datafile/undotbs2.267.818087989' to '+ORADATA/middle/datafile/undotbs2.400.875727809';
alter database rename file '+ORADATA/middle/datafile/users.265.818087989' to '+ORADATA/middle/datafile/users.280.875727827';
alter database rename file '+ORADATA/middle/datafile/middle.423.818091973' to '+ORADATA/middle/datafile/middle.281.875727807';
alter database rename file '+ORADATA/middle/datafile/statspack.292.818520761' to '+ORADATA/middle/datafile/statspack.499.875727807';
alter database rename file '+ORADATA/middle/datafile/tsdlogreport01.483.866556307' to '+ORADATA/middle/datafile/tsdlogreport01.496.875727807';
alter database rename file '+ORADATA/middle/datafile/tsilogreport01.474.866556313' to '+ORADATA/middle/datafile/tsilogreport01.399.875727809';

SQL> SELECT file#,online_status,error,change#,to_char(time,'dd/mm/yyyy hh24:mi:ss') time FROM v$recover_file;

     FILE# ONLINE_ ERROR                                                                CHANGE# TIME
---------- ------- ----------------------------------------------------------------- ---------- -------------------
         1 ONLINE                                                                     918405725 20/07/2015 21:50:36
         2 ONLINE                                                                     918405725 20/07/2015 21:50:36
         3 ONLINE                                                                     918405725 20/07/2015 21:50:36
         4 ONLINE                                                                     918405725 20/07/2015 21:50:36
         5 ONLINE                                                                     918405725 20/07/2015 21:50:36
         6 ONLINE                                                                     918405725 20/07/2015 21:50:36
         7 ONLINE                                                                     918405725 20/07/2015 21:50:36
         8 ONLINE                                                                     918405725 20/07/2015 21:50:36
         9 ONLINE                                                                     918405725 20/07/2015 21:50:36

9 rows selected.

[oracle@drdbtb775 MIDDLE]$ crontab -l
[oracle@drdbtb775 MIDDLE]$ sh /replicacao/MIDDLE/scripts/sincronismo.sh


		 