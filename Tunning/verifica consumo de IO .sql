--Verifica consumo de I/O por datafile
set pages 100
set lines 100

column "col1"  format a60      heading "Nome do Data File"  word_wrapped
column "col2"  format 999,999,999,990     heading "Blocos      |Fisicos     "
column "col3"  format 999,999,999,990     heading "Leituras    |Fisicas     "
column "col4"  format 999,999,999,990     heading "Gravacoes   |Fisicas     "
column "col5"  format 999,999,999,990     heading "Total       |de I/O      "

select 
 a.name         "col1" ,  
 b.phyblkrd              "col2" ,  
 b.phyrds               "col3" ,  
 b.phywrts        "col4" , 
 b.phyrds+b.phywrts       "col5"  
from
 v$datafile a,
 v$filestat b
where
 a.file#=b.file#
order by 3;

----Verifica consumo de I/O por Tablespace
set feedback off

set lines 155
break on report
compute sum of WRITEPCT on report
compute sum of READPCT on report
compute sum of IOPCT on report

select * from
( SELECT TABLESPACE_NAME
, sum(PHYRDS) as PHYRDS
, sum(PHYWRTS) as PHYWRTS
, sum(PHYBLKRD) as PHYBLKRD
, sum(PHYBLKWRT) as PHYBLKWRT
, sum(READPCT) as READPCT
, sum(WRITEPCT) as WRITEPCT
, sum(IOPCT) as IOPCT
FROM
( SELECT
ts.name
as tablespace_name
, fs.PHYRDS
, fs.PHYWRTS
, fs.PHYBLKRD
, fs.PHYBLKWRT
, 100 * ratio_to_report(fs.PHYBLKRD) over () as readpct
, 100 * ratio_to_report(fs.PHYBLKWRT) over () as writepct
, 100 * ratio_to_report(fs.PHYBLKRD+fs.PHYBLKWRT) over () as iopct
FROM V$FILESTAT fs, V$DATAFILE df, v$tablespace ts, dba_tablespaces dt
WHERE fs.file# = df.file#
AND df.ts# = ts.ts#
AND dt.tablespace_name = ts.name )
GROUP BY tablespace_name
ORDER BY iopct desc )
where rownum < 11 ; 

--Verifica consumo de I/O por sessão
set lines 190
col name for a30
col module for a20
col program for a30
col username for a20

select a.sid, b.name, a.value, c.module, c.program, c.username, c.OSUSER
   from v$sesstat a, v$statname b, v$session c
  where a.STATISTIC# = b.STATISTIC#
    and b.STAT_ID in (1190468109, 2263124246)
    and a.sid = c.sid
    and type <> 'BACKGROUND'
    --and c.OSUSER='bruno.mendonca'
  order by a.value;

--Verifica consumo de I/O por sessão2
set lines 200
col username for a20

select nvl(ses.USERNAME,'CONSINCO') username,
 OSUSER os_user,
 PROCESS pid,
 ses.SID sid,
 SERIAL#,
 PHYSICAL_READS,
 BLOCK_GETS,
 CONSISTENT_GETS,
 BLOCK_CHANGES,
 CONSISTENT_CHANGES
from v$session ses, 
 v$sess_io sio
where  ses.SID = sio.SID AND OSUSER='bruno.mendonca'
order  by PHYSICAL_READS, ses.USERNAME;