-- Verifica aonde está os datafiles/diskgroups de uma determinada TableSpace --

set lines 999
set pages 1000
col file_name format a75
col tablespace_name format a30
col status format a15
select FILE_NAME,ONLINE_STATUS, AUTOEXTENSIBLE, BYTES/1048576 AS MB, MAXBYTES/1048576 AS MAX_MB, INCREMENT_BY as INCREMENT_IN_BLKS
from dba_data_files
where TABLESPACE_NAME=upper('&qual_tablespace');


-- Versões 8 e 9i

set lines 999
set pages 1000
col file_name format a75
col tablespace_name format a30
col status format a15
select FILE_NAME, AUTOEXTENSIBLE, BYTES/1048576 AS MB, MAXBYTES/1048576 AS MAX_MB, INCREMENT_BY as INCREMENT_IN_BLKS
from dba_data_files
where TABLESPACE_NAME=upper('&qual_tablespace');