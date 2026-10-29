CREATE OR REPLACE FUNCTION LIST_FILES (lp_string IN VARCHAR2 default null)
RETURN file_array pipelined AS
 
lv_pattern VARCHAR2(1024);
lv_ns VARCHAR2(1024);
 
BEGIN
 
SELECT directory_path
INTO lv_pattern
FROM dba_directories
WHERE directory_name = 'pergamum_to_orahmgme';
 
SYS.DBMS_BACKUP_RESTORE.SEARCHFILES(lv_pattern, lv_ns);
 
FOR file_list IN (SELECT FNAME_KRBMSFT AS file_name
FROM X$KRBMSFT
WHERE FNAME_KRBMSFT LIKE '%'|| NVL(lp_string, FNAME_KRBMSFT)||'%' ) LOOP
PIPE ROW(file_list.file_name);
END LOOP;
 
END;
/


SELECT directory_path
FROM dba_directories
WHERE directory_name = 'GG';


How to list files on a directory from Oracle Database.	 13 September 2011
Posted by David Alejo Marcos in Exadata, Oracle 11.2, RAC, SQL - PL/SQL. 
Tags: Exadata, Oracle 11.2, RAC, SQL, SQL - PL/SQL
trackback
Couple of days ago I had an interesting request, “How can I see the contents of nfs_dir”?

The problem:

We were using DBFS to store our exports. This was the perfect solution as the business could “see” the files on the destination folder, but it did not meet our requirements performance wise on our Exadata.

We have decided to mount NFS and performance did improve, but we had a different problem. NFS is mounted on the database server and business do not have access for security reasons and segregation of duties.

Since then, the export jobs run, but business could not “see” what files were created, so the question was asked.

The solution:

After some research I came across with the following package:

SYS.DBMS_BACKUP_RESTORE.searchFiles

I did have to play a little bit, and I finished with the following script:
1.- Create an Oracle type

1
2
create type file_array as table of varchar2(100)
/
2.- Create the function as SYS:

--directory data
CREATE OR REPLACE FUNCTION LIST_FILES_DATA_DM01 (lp_string IN VARCHAR2 default null)
RETURN file_array pipelined AS
 
lv_pattern VARCHAR2(1024);
lv_ns VARCHAR2(1024);
 
BEGIN
 
SELECT directory_path
INTO lv_pattern
FROM dba_directories
WHERE directory_name = 'PERGAMUM_TO_ORAHMGME';
 
SYS.DBMS_BACKUP_RESTORE.SEARCHFILES(lv_pattern, lv_ns);
 
FOR file_list IN (SELECT FNAME_KRBMSFT AS file_name
FROM X$KRBMSFT
WHERE FNAME_KRBMSFT LIKE '%'|| NVL(lp_string, FNAME_KRBMSFT)||'%' ) LOOP
PIPE ROW(file_list.file_name);
END LOOP;
 
END;
/
3.- Grant necessary permissions:

1
2
grant execute on LIST_FILES_DATA_DM01 to public;
create public synonym LIST_FILES_DATA_DM01 for sys.LIST_FILES_data;

--directory reco
CREATE OR REPLACE FUNCTION LIST_FILES_RECO (lp_string IN VARCHAR2 default null)
RETURN file_array pipelined AS
 
lv_pattern VARCHAR2(1024);
lv_ns VARCHAR2(1024);
 
BEGIN
 
SELECT directory_path
INTO lv_pattern
FROM dba_directories
WHERE directory_name = 'RECO';
 
SYS.DBMS_BACKUP_RESTORE.SEARCHFILES(lv_pattern, lv_ns);
 
FOR file_list IN (SELECT FNAME_KRBMSFT AS file_name
FROM X$KRBMSFT
WHERE FNAME_KRBMSFT LIKE '%'|| NVL(lp_string, FNAME_KRBMSFT)||'%' ) LOOP
PIPE ROW(file_list.file_name);
END LOOP;
 
END;
/
3.- Grant necessary permissions:

1
2
grant execute on LIST_FILES_RECO to public;


create public synonym list_files_reco for sys.LIST_FILES_RECO;
4.- Test without WHERE clause:






TESTDB> select * from table(list_files);
COLUMN_VALUE
----------------------------------------------------------------------------------------------------
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB.log
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece1.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece2.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece3.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece4.dmp
/nfs/oracle/TESTDB/pump_dir/imdp_piece_TESTDB_09092011.log
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece1.dmp_old
/nfs/oracle/TESTDB/pump_dir/imdp_piece_TESTDB_12092011.log
 
8 rows selected.
 
Elapsed: 00:00:00.10
5.- Test with WHERE clause:

TESTDB> select * from table(list_files) where column_value like '%dmp%';
COLUMN_VALUE
----------------------------------------------------------------------------------------------------
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece1.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece2.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece3.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece4.dmp
/nfs/oracle/TESTDB/pump_dir/expdp_TESTDB_piece1.dmp_old
 
Elapsed: 00:00:00.12



 select SUBSTR(column_value,7,100) from table(list_files_data)where column_value not like'+data/DES01%' and column_value not like'+data/HOM01%' and column_value not like'+data/BI01%' order by 1;
 
 
 
 --gerar o comando do dbms_file_transfer

exec dbms_file_transfer.put_file ('DATA','ods_TODS_TSYS_OVERDUEACCOUNTS_12.dmp','EXP_SISBON','ods_TODS_TSYS_OVERDUEACCOUNTS_12.dmp','P8_BI01');


set head off
set pages 1000
select 'exec dbms_file_transfer.put_file (''DATA'','''||SUBSTR(column_value,7,100)||''',''EXP_SISBON'','''||SUBSTR(column_value,7,100)||',''P8_BI01'');' 
from table(list_files_data)where column_value not like'+data/DES01%' 
and column_value not like'+data/HOM01%' 
and column_value not like'+data/BI01%' 
order by 1;




--gerar o comando do dbms_file_transfer

exec dbms_file_transfer.put_file ('DATA','ods_TODS_TSYS_OVERDUEACCOUNTS_12.dmp','EXP_SISBON','ods_TODS_TSYS_OVERDUEACCOUNTS_12.dmp','P8_BI01');


set head off
set pages 1000
set lines 1000
select 'exec dbms_file_transfer.put_file (''RECO'','''||SUBSTR(column_value,7,100)||''',''EXP_SISBON'','''||SUBSTR(column_value,7,100)||',''P8_BI01'');' 
from table(list_files_reco)where column_value not like'+reco/DES01%' 
and column_value not like'+reco/HOM01%' 
and column_value not like'+reco/BI01%' 
order by 1;
