set lines 300 pages 10000 long 100000000 trimspool on
col username form a28
col sql_text form a70
col machine form a12
col module form a10
col spid form a10
col last_call_et form a18
col logon_time form a18
col inst_id form 9
col serial# form 999999
col sid form 999999
col elapsed form a8
select /*+ RULE */
         se.inst_id,se.sid, se.serial#, p.pname,
         se.status, se.username,
         si.consistent_gets, 
         substr(se.module,1,10) as module,
         to_char(logon_time, 'DD/MM/YY HH24:MI:SS') as logon_time,
         --to_char((sysdate - (se.last_call_et / 86400)), 'DD/MM/YY HH24:MI:SS') as last_call_et,
         to_char(trunc((sysdate-sql_exec_start)*24),'FM9900') || ':' ||to_char(trunc(mod((sysdate-sql_exec_start)*86400,3600)/60),'FM00') || ':' ||to_char(mod((sysdate-sql_exec_start)*86400,60),'FM00') elapsed,
         --sa.sql_id,chr(10)||substr(sa.sql_text,1,70) as sql_text
		 sa.sql_id, substr(sa.sql_text,1,50) as sql_text
    from gv$session se, gv$sqlarea sa, gv$process p, sys.v_$sess_io si
   where se.username is not null
     --and resource_consumer_group='CSF_USR_PCENTER'
     and se.paddr = p.addr(+)
     and sa.address(+) = se.sql_address
     --and sa.hash_value = se.sql_hash_value
     and si.SID(+) = se.SID
     and se.TYPE <> 'BACKGROUND'
	 and se.STATUS='ACTIVE'
--     and se.username in ('CSF_SB_PCENTER','PRD01_BI_ODS','PRD01_BI_DM','PRD01_BI_DW','CSF_SB_PCENTER_PRC_BONUS')
order by si.consistent_gets desc, se.username, sa.sql_id, p.pname;
