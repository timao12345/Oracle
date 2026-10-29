DATA/pepsico/datafile/pepsidata01.dbf
+DATA/pepsico/datafile/pepsidata02.dbf
+DATA/pepsico/datafile/pepsiidx01.dbf
+DATA/pepsico/datafile/rbtextonet.dbf
+DATA/pepsico/datafile/sysaux.257.734881335
+DATA/pepsico/datafile/system.256.734881335
+DATA/pepsico/datafile/undotbs1.258.734881335
+DATA/pepsico/datafile/undotbs2.266.734881427
+DATA/pepsico/datafile/users.259.734881335

9 rows selected.

SQL> create tablespace TBS_AUDIT datafile '+DATA/pepsico/datafile/TBS_AUDIT_01.dbf' size 1024M autoextend on next 10m maxsize 5000m;

Tablespace created.

SQL> alter table AUDIT_ACTIONS move tablespace TBS_AUDIT;

Table altered.

SQL> alter table AUDIT$ move tablespace TBS_AUDIT;

Table altered.

SQL> alter table AUD$  move tablespace TBS_AUDIT;

Table altered.

SQL> ALTER  index SYS.I_AUDIT_ACTIONS rebuild tablespace TBS_AUDIT;

Index altered.

SQL> ALTER  index SYS.I_AUD1 rebuild tablespace TBS_AUDIT;

Index altered.

SQL> ALTER  index SYS.I_AUDIT rebuild tablespace TBS_AUDIT;

Index altered.


col USERNAME form a30
col OS_USERNAME form a10
col USERNAME form a30
col USERHOST form a15
select USERNAME, OS_USERNAME, USERNAME, USERHOST, RETURNCODE, RETURNCODE, to_char(TIMESTAMP,'dd/mm/yyyy hh24:mi:ss') from DBA_AUDIT_TRAIL where RETURNCODE <>0;




http://download.oracle.com/docs/cd/B10500_01/server.920/a96521/audit.htm


