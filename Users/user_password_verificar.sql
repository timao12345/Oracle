select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
   dba_users where username='U10742';

SMW

select 
'alter user "'||username||'" identified by values '''||extract(xmltype(dbms_metadata.get_xml('USER',username)),'//USER_T/PASSWORD/text()').getStringVal()||''';'  old_password 
from 
   dba_users where username='SMW';

alter user "SMW" identified by values 'F1CFC666596DAE43';



nohup impdp '"/ as sysdba"' DIRECTORY=oradump dumpfile=expdp_GEDGEOP_para_CTG_%U.dmp logfile=imp_GEDGEOP_para_CTG_20240223.log parallel=10 &

nohup impdp '"/ as sysdba"' directory=DUMP dumpfile=backup_name_%u.dmp logfile=log_import.log REMAP_TABLESPACE=DADOS:SYSTEM REMAP_SCHEMA=oracle:system;


export ORACLE_HOME=/u01/app/oracle/product/19.3.0.0/dbhome_1
export ORACLE_SID=GEDGEOP
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=/u01/app/oracle/product/19.3.0.0/dbhome_1/lib
HOJE=$(date +"%Y%m%d")

expdp \"/as sysdba\" schemas=SMW directory=oradump dumpfile=expdp_GEDGEOP_para_CTG_%U.dmp logfile=expdp_GEDGEOP_para_CTG_$HOJE.log EXCLUDE=STATISTICS parallel=10



alter user "TR042296" identified by  LcCGtderPO40#rgbbFg;

LccGtderPO30#rgbbFG