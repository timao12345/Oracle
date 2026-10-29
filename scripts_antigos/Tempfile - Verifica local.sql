-- Verifica aonde está os tempfiles/diskgroups de uma TableSpace --

set linesize 180
col file_name format a70
col tablespace_name format a20
SELECT file_name, tablespace_name, bytes/1024/1024/1024 GB, blocks, AUTOEXTENSIBLE,MAXBYTES/1024/1024/1024
FROM dba_temp_files
ORDER BY tablespace_name, file_name;