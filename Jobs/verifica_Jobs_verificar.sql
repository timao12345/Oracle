select JOB, lowner LOG_USER, powner PRIV_USER, cowner SCHEMA_USER,
    LAST_DATE, substr(to_char(last_date,'HH24:MI:SS'),1,8) LAST_SEC,
    THIS_DATE, substr(to_char(this_date,'HH24:MI:SS'),1,8) THIS_SEC,
    NEXT_DATE, substr(to_char(next_date,'HH24:MI:SS'),1,8) NEXT_SEC,
    (total+(sysdate-nvl(this_date,sysdate)))*86400 TOTAL_TIME,
    decode(mod(FLAG,2),1,'Y',0,'N','?') BROKEN,
    INTERVAL# interval, FAILURES, WHAT,
    nlsenv NLS_ENV, env MISC_ENV, j.field1 INSTANCE
  from sys.job$ j
  
Definition of DBA_JOBS_RUNNING:
select v.SID, v.id2 JOB, j.FAILURES,
    LAST_DATE, substr(to_char(last_date,'HH24:MI:SS'),1,8) LAST_SEC,
    THIS_DATE, substr(to_char(this_date,'HH24:MI:SS'),1,8) THIS_SEC,
    j.field1 INSTANCE
  from sys.job$ j, v$lock v
  where v.type = 'JQ' and j.job (+)= v.id2

There is an interesting outer join in the WHERE clause of DBA_JOBS_RUNNING. 
It means that DBA_JOBS_RUNNING shows jobs which are not registered in 
sys.job$, but we can see them in V$LOCK (job is currently running).