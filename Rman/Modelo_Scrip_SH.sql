/home/pq1adm/scripts
pq1adm> vi otimizacao.sh
pq1adm> chmod 750 otimizacao.sh

 
#!/bin/bash
export ORACLE_HOME=/oracle/PP1/product/11203
export ORACLE_SID=PP1
sqlplus -s / << EOF
spool /tmp/PP1.log
alter table SAPSR3.SXMSPMAST enable row movement;
alter table SAPSR3.SXMSPMAST shrink space compact;
alter table SAPSR3.SXMSPMAST shrink space ;
alter table SAPSR3.SXMSCLUR enable row movement;
alter table SAPSR3.SXMSCLUR shrink space compact;
alter table SAPSR3.SXMSCLUR shrink space ;
alter table SAPSR3.SXMSCLUP enable row movement;
alter table SAPSR3.SXMSCLUP shrink space compact;
alter table SAPSR3.SXMSCLUP shrink space;
alter index "SAPSR3"."SXMSPMAST~MON" rebuild;
alter index "SAPSR3"."SXMSPMAST~PAR" rebuild;
alter index "SAPSR3"."SXMSPMAST~RTM" rebuild;
alter index "SAPSR3"."SXMSPMAST~TID" rebuild;
alter index "SAPSR3"."SXMSPMAST~0" rebuild;
alter index "SAPSR3"."SXMSPMAST~ARC" rebuild;
alter index "SAPSR3"."SXMSPMAST~DEL" rebuild;
alter index "SAPSR3"."SXMSCLUR~0" rebuild;
alter index "SAPSR3"."SXMSCLUP~0" rebuild;
EXEC DBMS_STATS.gather_table_stats('SAPSR3', 'SXMSPMAST');
EXEC DBMS_STATS.gather_table_stats('SAPSR3', 'SXMSCLUR');
EXEC DBMS_STATS.gather_table_stats('SAPSR3', 'SXMSCLUP');
spool off
EOF
  

  
#!/bin/bash
export ORACLE_HOME=/u01/app/oracle/product/11.2.0.4/dbhome_1
export ORACLE_SID=racnovo1
<< EOF
spool /d01dmp/d01dmp/scripts/racnovo1.log
expdp \"/ as sysdba\" directory=DUMPSYN dumpfile=sysperg20052015-A%U.dmp,sysperg20052015-B%U.dmp logfile=exp-sysperg20052015_.log FILESIZE=10G schemas=SYSPERGAMUM PARALLEL=8 &
spool off
EOF


#!/bin/bash
export ORACLE_HOME=/oradata/acmsa0/oracle/11.2.0/dbhome_1
export ORACLE_SID=acmsa0
<< EOF
spool /export_hbsis/C441758/acmsa0_msaf.log
expdp \"/ as sysdba\" directory=C441758 dumpfile=acmsa0_msaf.dmp logfile=acmsa0_msaf.log schemas=MSAF PARALLEL=6 COMPRESSION=all &
spool off
EOF



Modelo da Estacio:

echo `date` >> /u01/refresh/orahmgme/stats.log
#export ORACLE_SID=oradsvme
sqlplus /nolog <<EOF
conn /as sysdba
set echo on
spool gera_stats.log
execute DBMS_STATS.GATHER_DATABASE_STATS (estimate_percent => 1, degree => 8, cascade => true, gather_sys => FALSE, no_invalidate => true, gather_temp => true);
spool off
EOF
exit
echo `date` >> /u01/refresh/orahmgme/stats.log

