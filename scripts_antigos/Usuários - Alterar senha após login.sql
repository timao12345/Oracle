oracle@mytestbed:~$ sqlplus / as sysdba
 
SQL*Plus: Release 10.2.0.1.0 - Production on Thu Jan 6 12:06:53 2011
 
Copyright (c) 1982, 2005, Oracle.  All rights reserved.
 
Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - Production
With the Partitioning, OLAP and Data Mining options
 
SQL> ALTER USER testing PASSWORD EXPIRE;
 
User altered.
 
SQL> QUIT
Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - Production
With the Partitioning, OLAP and Data Mining options
oracle@mytestbed:~$

oracle@mytestbed:~$ sqlplus testing/testing123
 
SQL*Plus: Release 10.2.0.1.0 - Production on Thu Jan 6 12:07:01 2011
 
Copyright (c) 1982, 2005, Oracle.  All rights reserved.
 
ERROR:
ORA-28001: the password has expired
 
Changing password for testing
New password:
Retype new password:
Password changed
 
Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - Production
With the Partitioning, OLAP and Data Mining options
 
SQL> QUIT
