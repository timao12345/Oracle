SQL> connect sys as sysdba
Enter password: ******
Connected.
SQL> alter system set audit_trail=DB scope=spfile ;

System altered.

SQL> shutdown immediate
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup ;
ORACLE instance started.

Total System Global Area 612368384 bytes
Fixed Size 1250428 bytes
Variable Size 234883972 bytes
Database Buffers 369098752 bytes
Redo Buffers 7135232 bytes
Database mounted.
Database opened.
SQL> audit session whenever not successful ;

Audit succeeded.

SQL> connect dummy/dummy
ERROR:
ORA-01017: invalid username/password; logon denied
Warning: You are no longer connected to ORACLE.
SQL> connect sys as sysdba
Enter password: ******
Connected.
SQL> select os_username,
username,
userhost,
to_char(timestamp,'mm/dd/yyyy hh24:mi:ss') timestamp,
returncode
from dba_audit_session
where action_name = 'LOGON'
and returncode > 0
order by timestamp ;

