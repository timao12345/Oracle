select 'alter ' || decode(a.OBJECT_TYPE, 'PACKAGE BODY', 'PACKAGE', a.OBJECT_TYPE)  
                || ' ' || a.OWNER || '.' || a.OBJECT_NAME 
                || decode(a.OBJECT_TYPE, 'PACKAGE BODY', ' compile body;', ' compile;')
 from dba_objects a
where a.STATUS = 'INVALID'
  and a.owner not in ('SYS','SYSTEM')