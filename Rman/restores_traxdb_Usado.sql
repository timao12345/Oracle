Init

aq_tm_processes=1
audit_file_dest='/u01/app/oracle/admin/TRAXDB/adump'
background_dump_dest='/u01/app/oracle/admin/TRAXDB/bdump'
compatible='10.2.0.4.0'
control_file_record_keep_time=90
control_files='/u01/app/oracle/oradata/controlfile/cntrl01.dbf'
core_dump_dest='/u01/app/oracle/admin/TRAXDB/cdump'
cursor_sharing='SIMILAR'
db_block_size=8192
db_create_file_dest='/u01/app/oracle/oradata'
db_name='TRAXDB'
job_queue_processes=10
log_archive_dest_1='LOCATION=/u01/app/oracle/oradata/archivelog'
max_dump_file_size='20M'
nls_comp='LINGUISTIC'
nls_sort='BINARY'
open_cursors=4096
optimizer_index_caching=20
optimizer_index_cost_adj=15
pga_aggregate_target=4294967296
processes=1024
remote_login_passwordfile='exclusive'
sessions=1131
sga_target=4G
undo_management='AUTO'
undo_retention=9600
undo_tablespace='tsundo1'
user_dump_dest='/u01/app/oracle/admin/TRAXDB/udump'
utl_file_dir='*'


export ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
export ORACLE_SID=TRAXDB
export PATH=$PATH/usr/bin:/u01/app/oracle/product/10.2.0/db_1/bin

export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=TRAXDB
rman target /

run {
allocate channel c1 type 'sbt_tape';
send 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
restore controlfile to '/u01/app/oracle/oradata/controlfile/control01.dbf' from 'cntrl_31810_1_860992894';
release channel c1;
}

Continuar daqui:

/u01/app/oracle/oradata/controlfile/cntrl01.dbf

control01.dbf


alter database mount;
crosscheck archivelog all;
delete expired archivelog all; 


***acompanhar log da ferramenta
/usr/openv/netbackup/logs/user_ops/dbext/logs



SQL> select 'SET NEWNAME FOR DATAFILE '||FILE#||' to '|| chr(39) || name || chr(39)||';' from v$datafile;

#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=TRAXDB


rman target / log=/home/oracle/restore_tape_TRAXDB.log

run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
SET NEWNAME FOR DATAFILE 1 to '/u01/app/oracle/oradata/system.313.832188005';
SET NEWNAME FOR DATAFILE 2 to '/u01/app/oracle/oradata/tsundo1.318.832188003';
SET NEWNAME FOR DATAFILE 3 to '/u01/app/oracle/oradata/sysaux.297.832188017';
SET NEWNAME FOR DATAFILE 4 to '/u01/app/oracle/oradata/tsundo2.396.832188003';
SET NEWNAME FOR DATAFILE 5 to '/u01/app/oracle/oradata/users.298.832200139';
SET NEWNAME FOR DATAFILE 6 to '/u01/app/oracle/oradata/users.312.832200139';
SET NEWNAME FOR DATAFILE 7 to '/u01/app/oracle/oradata/users.309.832200139';
SET NEWNAME FOR DATAFILE 8 to '/u01/app/oracle/oradata/users.346.832200151';
SET NEWNAME FOR DATAFILE 9 to '/u01/app/oracle/oradata/users.316.832200151';
SET NEWNAME FOR DATAFILE 10 to '/u01/app/oracle/oradata/users.315.832200153';
SET NEWNAME FOR DATAFILE 11 to '/u01/app/oracle/oradata/users.299.832200153';
SET NEWNAME FOR DATAFILE 12 to '/u01/app/oracle/oradata/users.314.832200165';
SET NEWNAME FOR DATAFILE 13 to '/u01/app/oracle/oradata/users.310.832200165';
SET NEWNAME FOR DATAFILE 14 to '/u01/app/oracle/oradata/users.311.832200139';
SET NEWNAME FOR DATAFILE 15 to '/u01/app/oracle/oradata/users.317.832188017';
SET NEWNAME FOR DATAFILE 16 to '/u01/app/oracle/oradata/users.405.837685443';
SET NEWNAME FOR DATAFILE 17 to '/u01/app/oracle/oradata/users.296.840644281';
SET NEWNAME FOR DATAFILE 18 to '/u01/app/oracle/oradata/users.289.844614115';
SET NEWNAME FOR DATAFILE 19 to '/u01/app/oracle/oradata/users.313.dbf';
SET NEWNAME FOR DATAFILE 20 to '/u01/app/oracle/oradata/users.318.dbf';
SET NEWNAME FOR DATAFILE 21 to '/u01/app/oracle/oradata/users.292.855001171';
SET NEWNAME FOR DATAFILE 22 to '/u01/app/oracle/oradata/users.448.861552891';
SET NEWNAME FOR DATAFILE 23 to '/u01/app/oracle/oradata/users.450.862934449';
SET NEWNAME FOR DATAFILE 24 to '/u01/app/oracle/oradata/users.440.863451151';
SET NEWNAME FOR TEMPFILE 1 to '/u01/app/oracle/oradata/tstemp.307.758909407';
set until time "to_date('14-10-2014 08:00:00','dd-mm-yyyy hh24:mi:ss')";
restore database;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
release CHANNEL c2;
release CHANNEL c3;
release CHANNEL c4;
}


#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=TRAXDB
rman target / msglog=/home/oracle/restore_tape_TRAXDB.log << EOF
run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c2 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c3 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
ALLOCATE CHANNEL c4 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_D_DIA_22_01';
SET NEWNAME FOR DATAFILE 1 to '/u01/app/oracle/oradata/system.313.832188005';
SET NEWNAME FOR DATAFILE 2 to '/u01/app/oracle/oradata/tsundo1.318.832188003';
SET NEWNAME FOR DATAFILE 3 to '/u01/app/oracle/oradata/sysaux.297.832188017';
SET NEWNAME FOR DATAFILE 4 to '/u01/app/oracle/oradata/tsundo2.396.832188003';
SET NEWNAME FOR DATAFILE 5 to '/u01/app/oracle/oradata/users.298.832200139';
SET NEWNAME FOR DATAFILE 6 to '/u01/app/oracle/oradata/users.312.832200139';
SET NEWNAME FOR DATAFILE 7 to '/u01/app/oracle/oradata/users.309.832200139';
SET NEWNAME FOR DATAFILE 8 to '/u01/app/oracle/oradata/users.346.832200151';
SET NEWNAME FOR DATAFILE 9 to '/u01/app/oracle/oradata/users.316.832200151';
SET NEWNAME FOR DATAFILE 10 to '/u01/app/oracle/oradata/users.315.832200153';
SET NEWNAME FOR DATAFILE 11 to '/u01/app/oracle/oradata/users.299.832200153';
SET NEWNAME FOR DATAFILE 12 to '/u01/app/oracle/oradata/users.314.832200165';
SET NEWNAME FOR DATAFILE 13 to '/u01/app/oracle/oradata/users.310.832200165';
SET NEWNAME FOR DATAFILE 14 to '/u01/app/oracle/oradata/users.311.832200139';
SET NEWNAME FOR DATAFILE 15 to '/u01/app/oracle/oradata/users.317.832188017';
SET NEWNAME FOR DATAFILE 16 to '/u01/app/oracle/oradata/users.405.837685443';
SET NEWNAME FOR DATAFILE 17 to '/u01/app/oracle/oradata/users.296.840644281';
SET NEWNAME FOR DATAFILE 18 to '/u01/app/oracle/oradata/users.289.844614115';
SET NEWNAME FOR DATAFILE 19 to '/u01/app/oracle/oradata/users.313.dbf';
SET NEWNAME FOR DATAFILE 20 to '/u01/app/oracle/oradata/users.318.dbf';
SET NEWNAME FOR DATAFILE 21 to '/u01/app/oracle/oradata/users.292.855001171';
SET NEWNAME FOR DATAFILE 23 to '/u01/app/oracle/oradata/users.450.862934449';
SET NEWNAME FOR DATAFILE 24 to '/u01/app/oracle/oradata/users.440.863451151';
SET NEWNAME FOR TEMPFILE 1 to '/u01/app/oracle/oradata/tstemp.307.758909407';
set until time "to_date('14-10-2014 08:00:00','dd-mm-yyyy hh24:mi:ss')";
restore database;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
release CHANNEL c2;
release CHANNEL c3;
release CHANNEL c4;
}
EOF
SQL> select FILE#, CREATION_TIME from v$datafile where FILE# in ('22','23','24');

     FILE# CREATION_
---------- ---------
        22 21-OCT-14
        23 06-NOV-14
        24 12-NOV-14


		
***recover
#!/bin/bash
export NLS_DATE_FORMAT='DD/MM/YYYY-HH24:MI:SS'
export ORACLE_SID=TRAXDB
rman target / msglog=/home/oracle/recover_tape_TRAXDB.log << EOF
run {
allocate channel c1 type 'sbt_tape';
SEND 'NB_ORA_CLIENT=ORAFDBTB578A.servicos,NB_ORA_SERV=ipbtbms1,NB_ORA_POLICY=TB_AZL_D_OR_L_DIA_08_01';
set until time "to_date('14-10-2014 08:00:00','dd-mm-yyyy hh24:mi:ss')";
recover database;
release channel c1;
}
EOF

*** rename logfile
col member format a60
set lines 200
SQL> select * from v$logfile order by 1;

alter database rename file '+DGDATA02/sabrecc/onlinelog/group_1.386.820551165'  to '/u01/app/oracle/oradata/redo01.rdo';


alter database open resetlogs;



		