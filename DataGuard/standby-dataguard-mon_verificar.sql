-----------------------
-- Dataguard Monitoring
-----------------------

COLUMN destination FORMAT A35 WRAP 
column process format a7 
column archiver format a8 
column ID format 99 

select dest_id "ID",destination,status,target, archiver,schedule,process,mountid 
  from v$archive_dest; 

select dest_id,process,transmit_mode,async_blocks, net_timeout,delay_mins,reopen_secs,register,binding 
  from v$archive_dest; 

column error format a55 tru 

select dest_id,status,error from v$archive_dest; 

column message format a80 
select message, timestamp 
  from v$dataguard_status 
where severity in ('Error','Fatal') 
order by timestamp; 

SELECT SEQUENCE#, FIRST_TIME, NEXT_TIME,APPLIED FROM V$ARCHIVED_LOG ORDER BY SEQUENCE#;


select ads.dest_id,max(sequence#) "Current Sequence",max(log_sequence) "Last Archived", 
       max(applied_seq#) "Last Sequence Applied" 
 from v$archived_log al, 
      v$archive_dest ad, 
      v$archive_dest_status ads 
 where ad.dest_id=al.dest_id 
   and al.dest_id=ads.dest_id 
 group by ads.dest_id; 

column SRL_Count format 99 
column SRL_Active format 99 

select dest_id,database_mode,recovery_mode, 
       protection_mode,standby_logfile_count "SRL_COUNT",standby_logfile_active "SRL_ACTIVE", 
       archived_seq#, applied_seq# 
 from v$archive_dest_status; 

select process,status,client_process,sequence#,block#,active_agents,known_agents 
  from v$managed_standby; 

select group#,sequence#,bytes from v$standby_log; 

select group#,thread#,sequence#,bytes,archived,status from v$log;



1)	Para verificação simples
(Mostra a última sequência de archives aplicada no standby e horário de geração do archive no primary) 

[STANDBY]
select to_char(COMPLETION_TIME, 'dd/mm/yyyy hh24:mi') COMPLETION_TIME, SEQUENCE#, ARCHIVED, APPLIED, DELETED
  from v$archived_log
  where sequence#=(select max(SEQUENCE#)
                    from v$archived_log
                   where APPLIED='YES');

COMPLETION_TIME        SEQUENCE# ARC APP DEL
---------------- ---------- --- --- ---
2012/06/21 14:35      11675 YES YES NO



2)	Para verificação precisa 
(Mostra o ponto-no-tempo que o banco standby está em relação ao primary, através do SCN)

[STANDBY]
select to_char(current_scn) from v$database;

TO_CHAR(CURRENT_SCN)
----------------------------------------
83119445991

[PRIMARY]
conn sys/manager@PRIMARY as sysdba
Connected.
 select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') "SCN_TO_TIMESTAMP" from dual
Enter value for scn_do_standby: 83118910408
old   1: select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') "SCN_TO_TIMESTAMP" from
new   1: select to_char(scn_to_timestamp('83118910408'),'DD/MM/YYYY HH24:MI:SS') "SCN_TO_TIMESTAMP" from dua

SCN_TO_TIMESTAMP
-------------------
21/06/2012 14:33:07


3)	Verificação do status da replicação (erros)

set lines 180 pages 10000
col message form a80
select to_char(TIMESTAMP,'dd/mm/yyyy-hh24:mi') "DATE", MESSAGE 
from V$DATAGUARD_STATUS where TIMESTAMP>sysdate-1/12;

21/06/2012-14:27 Media Recovery Waiting for thread 1 sequence 11675 (in transit)
21/06/2012-14:35 Primary database is in MAXIMUM PERFORMANCE mode
21/06/2012-14:35 RFS[8]: Successfully opened standby log 12: '+FRA/sphm_std/onlinelog/group_12.4279.777562981'
21/06/2012-14:35 Media Recovery Log +FRA/sphm_std/archivelog/2012_06_21/thread_1_seq_11675.5549.786551703
21/06/2012-14:40 Media Recovery Waiting for thread 1 sequence 11676 (in transit)

OBS.: As duas últimas linhas significam que a última sequência 11675 foi aplicada e o processo de recover do standby aguarda pela próxima sequência que está sendo enviada.




