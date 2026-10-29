1 - EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

2 - SELECT * FROM v$backup WHERE status != 'NOT ACTIVE';  

3 - PURGE DBA_RECYCLEBIN

4 - SELECT USERNAME,PASSWORD_VERSIONS FROM DBA_USERS;

5 -  Run the preupgrade tool:

/*The preupgrade.jar Pre-Upgrade Information Tool is supplied with Oracle Database 12cR2.
This tool has reside in new oracle home.*/
/u03/app/oracle/product/12.2/db_1/rdbms/admin/preupgrade.jar

--SYNTAX:
/u01/app/oracle/product/11.2.0.4/db_1/jdk/bin/java -jar /u03/app/oracle/product/12.2/db_1/rdbms/admin/preupgrade.jar FILE DIR /u01/


--After run the above tool we will get below sql files.

6 - Run the preupgrade_fixup.sql

7 - Shutdown the database:

shut immediate;

8 - Copy the parameter and password file from the 11g home to the new 12c home.

9 - Set new ORACLE HOME of 12c location:

export ORACLE_HOME=/u01/app/oracle/product/12.2/db_1/

10 - start the database in upgrade mode.

11 - Run catctl.pl


$ORACLE_HOME/perl/bin/perl $ORACLE_HOME/rdbms/admin/catctl.pl -d $ORACLE_HOME/rdbms/admin -l /home/oracle/ -n 4 catupgrd.sql

12 -  Run postupgrade_fixups.sql .

13 -  To fix the manual error related to timezone

Download DBMS_DST_scriptsV1.9.zip file from metalink.

14 - Check the timezone version

15 - Unzip DBMS_DST_scriptsV1.9.zip file we will get below sql files for upgrade the timezone.

16 - Apply the New Timezone 

17 - Check the timezone version

Ps: Now it�s changed from 14 to 26.

18 - Execute utlu122s.sql

19 - Execute catuppst.sql

20 - Execute utlrp.sql script to compile  invalid objects.

21 - Set COMPATIBALE parameter value for 12.2.0 as well as  start the listener with 12.2 home.

22 - Finally to check the component and version using dba_registry view