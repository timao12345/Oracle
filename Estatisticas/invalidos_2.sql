select owner, object_name, object_type, status, timestamp from dba_objects
where to_date(substr(timestamp,1,10), 'yyyy-mm-dd')>=trunc(sysdate) and status='INVALID' and owner='USRMSAF';



select 'ALTER ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
from dba_objects
where to_date(substr(timestamp,1,10), 'yyyy-mm-dd')>=trunc(sysdate) and status like 'INVALID'
and owner='GRUPOCP';
	  
	  
	  
	  
select owner, object_name, object_type
from dba_objects
where  status='INVALID' and owner='SAPSR3';