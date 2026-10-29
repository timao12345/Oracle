begin
  for cur in (select sid, serial# from v$session a where a.STATUS = 'INACTIVE' ) loop
  
      execute immediate 'alter system kill session ' ||'''' || cur.sid || ', ' || cur.serial# || '''' || ' immediate' ; 
  
  end loop ;
end ;



select spid, osuser, s.program 
  from v$process p, v$session s 
 where p.addr=s.paddr
   and s.status='KILLED'


select 'alter system kill session '|| ''''|| sid || ', ' || serial#|| '''' || ' immediate;'
serial#
from gv$session 
where type !='BACKGROUND' 
and sql_id is null 
and status='INACTIVE'
and SECONDS_IN_WAIT > 300
and username not in ('PETERSON','KIPREVWEB','ADAIL','OPS$KPV','DOUGLASREIS','KIPREVWEBMSG','USRGIA','SYS','SYSTEM','REPORT_SERVER','APLKPVEUL','SYSRAC','KPVEUL','KIPREV','DBSNMP','USR_MONITOR','SYSMAN','USR_DSTAGE','SYSESTUDO','USR_SQLLINK','USR_REPLICA_NEW','USR_REPLICA_02','USR_REPLICA_03','USR_REPLICA','USR_REPLICA_CDC_TESTE','SYSRAC');
