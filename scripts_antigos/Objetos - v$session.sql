SELECT 'ALTER SYSTEM KILL SESSION '||''''||sid ||','|| serial#||',@'|| INST_ID||''''||' immediate;'
 FROM gv$session
 WHERE status ='INACTIVE' and type != 'BACKGROUND';
 
 SELECT 'ALTER SYSTEM KILL SESSION '||''''||sid ||','|| serial#||''''||' immediate;'
 FROM v$session
 WHERE status ='INACTIVE' and type != 'BACKGROUND';
 
 

