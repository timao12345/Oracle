#
 # Verifica autoextend do datafile;
#

undef YES_NO
select 'alter database datafile '||file_id||' autoextend off;'
from dba_data_files
where autoextensible=upper ('&&YES_NO')
union 
select 'alter database tempfile '||file_id||' autoextend off;'
from dba_temp_files
where autoextensible=upper ('&&YES_NO')
/
