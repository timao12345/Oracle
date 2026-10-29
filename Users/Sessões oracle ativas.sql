--Verficia as sessões 
col status for a8
col inst_id for a5 for 999
col sid for a3 for 999999
col serial# for a5 for 999999
col username for a15
col osuser for a8
col machine for a12
col event for a30
col program for a20
col sql_id for a15
col logon_time for a20
set linesize 2500
set pages 250
select s.STATUS, s.inst_id,s.USER#, s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE, s.event, s.sql_id, s.program, (last_call_et / 60) "Minutes since active", to_char(s.logon_time,'DD-MON-YYYY HH24:MI:SS') logon_time
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status ='ACTIVE'
order by logon_time;

--total de sessões ativas no momento agrupando por usuario
select count(*) as "TOTAL_SESSAO_ATIVA",s.USERNAME
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status!='ACTIVE'
group by s.username;

select count(*) as "TOTAL_SESSAO_ATIVA"
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status='ACTIVE';

-- 10 sessões com maior tempo em execução no banco de dados
col MACHINE for a30
select STATUS, SID, serial#, USERNAME, osuser, MACHINE, sql_id, (last_call_et/60) as "Minutes since active"
from (select s.STATUS, s.inst_id,s.USER#, s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE, s.event, s.sql_id, s.program, last_call_et
      from gv$process p, gv$session s 
      where s.PADDR = p.ADDR and s.type != 'BACKGROUND' 
      order by last_call_et desc)
where rownum <11;


-------------- // ----------------

SELECT
   s.sid                sid
 , s.serial#            serial_id
 , lpad(s.status,9)     session_status
 , lpad(s.username,12)  oracle_username
 , lpad(s.osuser,9)     os_username
 , lpad(p.spid,7)       os_pid
 , s.program            session_program
 , lpad(s.machine,14)   session_machine
 , sstat.value          cpu_value
FROM v$process p
 , v$session  s
 , v$sesstat  sstat
 , v$statname statname
WHERE p.addr= s.paddr 
AND s.sid= sstat.sid
AND statname.statistic# = sstat.statistic# 
AND statname.name= 'CPU used by this session'
ORDER BY cpu_value DESC;

------- // ---------

--
col osuser for a20
col machine for a20
col username for a20 
col service_name for a15
col spid for a10
select s.STATUS,s.inst_id,s.SID, s.serial#, s.USERNAME, s.osuser, s.MACHINE,s.sql_id, p.PID, p.SPID,s.SERVICE_NAME
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.username='WIS50' order by status;

--and username= 'USER_TAXBR';


select * from v$session 
where username = 'WIS50';

-- Verificar o que está sendo executado a partir do SQL_ID 
select SQL_TEXT,ROWS_PROCESSED,USERS_EXECUTING,CPU_TIME,SQLTYPE
from v$sql 
where SQL_ID='8y0cjjx7hvypz';

--RODAR PARA VERIFICAR O QUAL O USU�RIO E O QUE QUAL A��O ESTA SENDO EFETUADA 
select sql_text, object_status, first_load_time, username, sid,s.serial#
from v$session s, v$sql sql 
where sql.sql_id = s.sql_id  and sid=1854; 


-- Gera comando para matar as sessões
SELECT 'alter system kill session ' || '''' || s.SID || ',' || s.serial# || ',@' || s.inst_id || '''' || ' immediate;' 
from gv$process p, gv$session s
where s.PADDR = p.ADDR and s.type != 'BACKGROUND' and s.status='INACTIVE';

alter system kill session '291,28685';



SET SERVEROUTPUT ON 

BEGIN
BMS_OUTPUT.enable (1000000);     
FOR do_loop IN (SELECT session_id,a.object_id,xidsqn,oracle_username,b.owner owner, b.object_name object_name,b.object_type object_type 
                FROM v$locked_object a, dba_objects b 
                WHERE xidsqn != 0 AND b.object_id = a.object_id)
    LOOP 
        DBMS_OUTPUT.put_line ('.'); 
        DBMS_OUTPUT.put_line ('Blocking Session: ' || do_loop.session_id);          
        DBMS_OUTPUT.put_line ('Object (Owner/Name): ' || do_loop.owner || '.' || do_loop.object_name);        
        DBMS_OUTPUT.put_line ('Object Type: ' || do_loop.object_type);
            FOR next_loop  IN (SELECT sid  
                               FROM v$lock 
                               WHERE id2 = do_loop.xidsqn AND sid != do_loop.session_id)         
            LOOP          
                DBMS_OUTPUT.put_line ('Sessions being blocked:  ' || next_loop.sid);
            END LOOP;      
    END LOOP;    
END;
/



