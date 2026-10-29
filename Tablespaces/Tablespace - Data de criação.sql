select a.file_name,a.tablespace_name,b.creation_time from dba_temp_files a,v$datafile b
where a.file_id=b.file# and a.tablespace_name like 'TEMP%' order by tablespace_name;
