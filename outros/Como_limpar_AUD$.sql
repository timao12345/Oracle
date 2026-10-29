	How to Truncate, Delete, or Purge Rows from the Audit Trail Table AUD$ (Doc ID 73408.1)
	
	How to Truncate, Delete, or Purge Rows from the Audit Trail Table AUD$ (Doc ID 73408.1)	To BottomTo Bottom	

APPLIES TO:

Oracle Database - Enterprise Edition - Version 8.1.7.4 to 11.2.0.3 [Release 8.1.7 to 11.2]
Information in this document applies to any platform.
Checked for relevance on 15-Feb-2013


PURPOSE

This document explains how to purge, truncate, or delete rows from the audit trail table SYS.AUD$. 



Starting with Oracle 11gR2 it is possible to use package DBMS_AUDIT_MGMT for this. More information about this package can be read in Note 731908.1 -New Feature DBMS_AUDIT_MGMT To Manage And Purge Audit Information.
SCOPE

This document is intended for DBA's or Oracle Support Analysts.

DETAILS

To delete rows from the database audit trail table, an appropriate privilege is required. You must either be the user SYS, or a user with DELETE ANY TABLE system privilege, or a user to whom SYS has granted the object privilege DELETE on SYS.AUD$.

1) To purge all the audit records from the audit trail run this command:


SQL> truncate table aud$;


2)To delete rows from the audit trail related to a particular audited object run this command:


SQL> DELETE FROM sys.aud$ WHERE obj$name='<object_name>';
 


Note: The above operations must be performed as an user who is granted the delete_catalog_role role or by SYS. If OLS is being installed then the delete_catalog_role might lose the delete privilege on table aud$ because of bug 9697811 which is fixed by patchset 11.2.0.2. To remedy this problem one can run the following statement as SYS: 

grant delete on sys.aud$ to delete_catalog_role;

3) If the audit trail information must be archived, copy the relevant rows to another table, then truncate the aud$ table and finally you can optionally export the backup table(backup_aud$) to an OS file and then drop the backup table : 



SQL> CREATE TABLE backup_aud$ AS SELECT * from sys.aud$;



SQL> truncate table aud$;


 export table backup_aud$:

 

[oracle@seclin4 ~]$ exp file=aud_backup.dmp tables=backup_aud$

Export: Release 11.2.0.3.0 - Production on Tue Jun 25 10:53:06 2013

Copyright (c) 1982, 2011, Oracle and/or its affiliates.  All rights reserved.


Username: / as sysdba

Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, Oracle Label Security, OLAP, Data Mining
and Real Application Testing options
Export done in US7ASCII character set and AL16UTF16 NCHAR character set
server uses AL32UTF8 character set (possible charset conversion)

About to export specified tables via Conventional Path ...
. . exporting table                    BACKUP_AUD$       1722 rows exported
Export terminated successfully without warnings.

SQL> drop table backup_aud$;



4) If your intention is to reduce the space occupied by the aud$ table you can perform the actions from 3) and at the end reload the data back to aud$: 



SQL>insert into aud$ select * from backup_aud$;
SQL>commit;


