-- pega hash
col HASH_VALUE format 999999999999;
SELECT INST_ID,ADDRESS, HASH_VALUE
FROM GV$SQLAREA
WHERE SQL_ID = '7xr63apacnuxt'
;

7xr63apacnuxt - 
4vazsm0c3g1dw - 
dndjha67f5vq9 - 
frhqtsq63r38y - 
3ry77td1nwjjq - 
cupdmrmjhrkqw - 
5x1z0k96f14c1 - 
403hp9z8sdbb3 - 
fvsb96cqzd79p -  


col HASH_VALUE format 999999999999;
SELECT 'EXEC DBMS_SHARED_POOL.PURGE ('''||ADDRESS ||','|| HASH_VALUE||''',''C'');'
FROM GV$SQLAREA
WHERE SQL_ID = '7xr63apacnuxt' 
OR sql_id = '4vazsm0c3g1dw'
OR sql_id = 'dndjha67f5vq9'
OR sql_id = 'frhqtsq63r38y'
OR sql_id = '3ry77td1nwjjq'
OR sql_id = 'cupdmrmjhrkqw'
OR sql_id = '5x1z0k96f14c1'
OR sql_id = '403hp9z8sdbb3'
OR sql_id = 'fvsb96cqzd79p'
;

EXEC DBMS_SHARED_POOL.PURGE ('000000139F06A5F0,1129203254','C');
EXEC DBMS_SHARED_POOL.PURGE ('00000012F6ECAFD0,1422551993','C');
EXEC DBMS_SHARED_POOL.PURGE ('00000012F6EF6B00,1289785729','C');
EXEC DBMS_SHARED_POOL.PURGE ('00000013AF171688,771136821','C');
EXEC DBMS_SHARED_POOL.PURGE ('000000138E7E14A8,3515264355','C');
EXEC DBMS_SHARED_POOL.PURGE ('00000012F73199A0,2397236937','C');
EXEC DBMS_SHARED_POOL.PURGE ('000000139ED56040,406291900','C');
EXEC DBMS_SHARED_POOL.PURGE ('000000139EC5FC98,2352712990','C');
EXEC DBMS_SHARED_POOL.PURGE ('000000137EF02928,3809200860','C');



col HASH_VALUE format 999999999999;
SELECT INST_ID,ADDRESS, HASH_VALUE, SQL_TEXT, SQL_ID
FROM GV$SQLAREA
WHERE SQL_TEXT LIKE '%FECHANDO A DIARIA DO DIA%'
;

col HASH_VALUE format 999999999999;
SELECT 'EXEC DBMS_SHARED_POOL.PURGE ('''||ADDRESS ||','|| HASH_VALUE||''',''C'');'
FROM GV$SQLAREA
WHERE SQL_TEXT LIKE 'SELECT s.sid, s.serial#, p.spid as "OS PID",s.username, s.sql_id,%'
;


--Lima o hash da memoria
EXEC DBMS_SHARED_POOL.PURGE ('00000002E9BD56B0,3785221109', 'C');




-- script abaixo precisa ser criado um arquivo no servidor e executado da seguinte forma @nome_do_script.sql b360utxq6abns$

set verify off;
set serveroutput on;
declare
 vJobName varchar2(200);
 cursor listaCursores is
    select inst_id, sql_id, hash_value, 'SYS.DBMS_SHARED_POOL.PURGE ('''||address||','||hash_value||''',''C'');' cmd 
      from GV$SQLAREA 
     where SQL_ID = '&1'
  order by inst_id;

begin
  for i in listaCursores loop
    vJobName := '"PURGE_CURSOR_' || i.sql_id || '_' || i.hash_value || '_' || i.inst_id || '"';
     
    dbms_scheduler.create_job 
    (  
      job_name      =>  vJobName,  
      job_type      =>  'PLSQL_BLOCK',  
      job_action    =>  'begin ' || i.cmd ||' end;',  
      start_date    =>  sysdate,  
      enabled       =>  FALSE,  
      auto_drop     =>  TRUE,  
      comments      =>  'Limpa cursor com SQL ID ' || i.sql_id || ' e Plan Hash Value ' || i.hash_value || ' na instance ' || i.inst_id
     );
 
    dbms_scheduler.set_attribute (name => vJobName, attribute => 'INSTANCE_ID', value => i.inst_id);
    dbms_scheduler.enable (name => vJobName);
 
    dbms_output.put_line('JOB: ' || vJobName || u'\000A' || i.cmd || u'\000A');
 end loop;
end;
/

-- verifica objetos pinados.

column kghluops heading "PINS AND|RELEASES" 
column kghlunfu heading "ORA-4031|ERRORS" 
column kghlunfs heading "LAST ERROR|SIZE" 
column kghlushrpool heading "SUBPOOL"   

select 
kghlushrpool, 
kghlurcr, 
kghlutrn, 
kghlufsh, 
kghluops, 
kghlunfu, 
kghlunfs 
from 
sys.x$kghlu 
where 
inst_id = userenv('Instance');


 
select inst_id, sql_id, address,hash_value
from GV$SQLAREA 
order by inst_id;


set verify off;
set serveroutput on;
declare
 vJobName varchar2(200);
 cursor listaCursores is
    select inst_id, sql_id,address, hash_value
      from GV$SQLAREA 
  order by inst_id;