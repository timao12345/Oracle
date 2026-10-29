select owner, object_name, object_type, status, timestamp from dba_objects
where to_date(substr(timestamp,1,10), 'yyyy-mm-dd')>=trunc(sysdate)
      and status='INVALID' and owner='RCVRY';



select 'ALTER ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
    owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
    from dba_objects
      where status like 'INVALID';
      
      to_date(substr(timestamp,1,10), 'yyyy-mm-dd')>=trunc(sysdate) and status like 'INVALID';
	  
	  
	  
	  
select owner, object_name, object_type, status, timestamp from dba_objects
where to_date(substr(timestamp,1,10), 'yyyy-mm-dd')>=trunc(sysdate)
      and status='INVALID' and object_name='PG_PROCESSAMENTO_SMS';