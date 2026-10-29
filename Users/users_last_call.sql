select sid, serial#, 
       to_char(logon_time, 'dd/mm/yyyy hh24:mi:ss') login_em, 
       to_char( sysdate-last_call_et/86400, 'dd/mm/yyyy hh24:mi:ss') ultimo_acesso, 
       last_call_et, username 
  from  v$session 
 where status ='INACTIVE' 
 order by last_call_et