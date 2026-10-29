-- Create the user 
create user &&username identified by &&username
  default tablespace users
  temporary tablespace temp
  profile special;
-- Grant/Revoke role privileges 
grant connect, dba to &&username;
-- Grant/Revoke system privileges 
grant unlimited tablespace to &&username;


SELECT ' GRANT ' ||GRANTED_ROLE|| ' TO HOMOLOG ; ' FROM  DBA_ROLE_PRIVS WHERE GRANTEE='HOMOLOG';

SELECT ' GRANT ' ||PRIVILEGE|| ' TO ARCOMIXDW ; ' FROM  DBA_SYS_PRIVS WHERE GRANTEE='CONSINCODW';

create user ARCOMIXDW identified by MEGAPROAUTO;


SELECT * FROM  DBA_ROLE_PRIVS WHERE GRANTEE='USR_JOSAL';

SELECT * FROM  DBA_SYS_PRIVS WHERE GRANTEE='USR_JOSAL'; 

USERNAME                            
------------
ALTER USER  DBSNMP  account unlock;
ALTER USER  APPQOSSYS   account unlock; 
ALTER USER  GSMCATUSER  account unlock;
ALTER USER  DBSFWUSER  account unlock;                         
ALTER USER  REMOTE_SCHEDULER_AGENT account unlock;
ALTER USER  SYSBACKUP  account unlock; 
ALTER USER  GGSYS account unlock;
ALTER USER  GSMUSER   account unlock;
ALTER USER  SYSRAC account unlock;
ALTER USER  DVF  account unlock;
ALTER USER  DVSYS account unlock;
ALTER USER  OJVMSYS  account unlock;  
ALTER USER  AUDSYS  account unlock;
ALTER USER  GSMADMIN_INTERNAL account unlock;
ALTER USER  DIP  account unlock;
ALTER USER  LBACSYS account unlock;
ALTER USER  OLAPSYS account unlock;
ALTER USER  SYSKM account unlock;
ALTER USER  OUTLN   account unlock; 
ALTER USER  SYS$UMF  account unlock;
ALTER USER  XDB  account unlock;
ALTER USER  WMSYS  account unlock;  
ALTER USER  SYSDG account unlock;


