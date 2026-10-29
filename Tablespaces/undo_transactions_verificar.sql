select 
 sid, serial#, username, osuser,  
 to_char(logon_time,'dd-mon hh24:mi:ss') connected,  
 to_char(start_date,'dd-mon hh24:mi:ss') started  
 from  v$transaction tr,  
       v$session se  
where 
    se.saddr = tr.ses_addr  
order by started ;  
