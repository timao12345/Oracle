-- VALIDAÇÃO BANCO ORACLE

-- PROCESSOS PMON

ps -ef | grep -i pmon

-- LINTENER

ps -ef | grep -i tns
lsnrctl status

-- LOGAR NO BANCO

echo $ORACLE_SID

sqlplus / as sysdba

-- ALERT LOG

show parameter back


SET SQLBLANKLINES ON
SET COLSEP '|'
COL STARTUP_TIME     FOR A20
COL INSTANCE_NAME    FOR A15
COL HOST_NAME        FOR A10
COL SYSDATE          FOR A30
COL "NOME_SERVIDOR"  FOR A30
COL "BANCO_INICIADO" FOR A20
COL "DATA_E_HORA"    FOR A20
SET LINES 900 PAGES 500 TRIMS ON
SET TIME ON
SELECT DISTINCT INSTANCE_NAME NOME_BANCO, I.HOST_NAME NOME_SERVIDOR, TO_CHAR(STARTUP_TIME,'DD/MM/YYYY HH24:MI:SS') BANCO_INICIADO,
D.LOG_MODE, I.STATUS, I.LOGINS, D.DATABASE_ROLE, D.OPEN_MODE, TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') DATA_E_HORA
FROM GV$INSTANCE I, GV$DATABASE D;

================================================================================================================================================================


Clear Columns Computes Breaks
set lines 200
set pages 200
col file_name for a50
col tablespace_name for a30
col status for a21
compute sum of "Total(Mb)" on report
compute sum of "Free(Mb)" on report
break on report
SELECT  t.tablespace_name,
        ts.contents,
        ts.status,
        round(nvl(t.bytes,0)/1024/1024,1) "Total(Mb)",
        round((nvl(nvl(f.free,ft.free),0)/1024/1024),1) "Free(Mb)",
        round((nvl(nvl(f.free,ft.free),0)*100/t.bytes),1) "% Free",
decode((case when
round((nvl(nvl(f.free,ft.free),0)/1024/1024/1024))>=5 then 'OK' else
'NOK' end),'OK','OK',decode(contents,'UNDO','OK - UNDO 
TABLESPACE',decode(contents,'TEMPORARY','OK - TEMP 
TABLESPACE',decode(round((nvl(nvl(f.free,ft.free),0)*100)/t.bytes) 
,'0','CRITICAL','1','CRITICAL','2','CRITICAL','3','CRITICAL','4','CRITICAL','5','WARNING','6','WARNING','7','WARNING','8','WARNING','9','WARNING','OK'))))
STATUS FROM (SELECT d.tablespace_name,
sum(d.bytes) bytes
FROM dba_data_files d
GROUP BY tablespace_name
UNION
SELECT d.tablespace_name,
sum(d.bytes) bytes
FROM dba_TEMP_files d
GROUP BY tablespace_name) t,
(SELECT tablespace_name,
sum(bytes) free
FROM dba_free_space
GROUP BY tablespace_name) f,
(select TABLESPACE_NAME,
sum(bytes_free) free
from V$TEMP_SPACE_HEADER
group by tablespace_name) ft,
dba_tablespaces ts
WHERE t.tablespace_name = f.tablespace_name(+)
AND t.tablespace_name = ft.tablespace_name(+)
AND t.tablespace_name = ts.tablespace_name
ORDER BY 5;

======================================================================================================================================================================================



set lines 1000
set pages 2000
col tablespace_name for a15
col name for a60
col status1 for a12
col status2 for a12
col status3 for a12
col online_status for a12
col status_backup for a12
col recover for a7
col error for a5
col "FILE#" for 9999
select df.tablespace_name,
d.FILE#,
d.NAME,
df.autoextensible,
df.bytes/1024/1024 "Total(Mb)",
d.status   status1,
dh.STATUS  status2,
df.status  status3,
--df.online_status,
b.STATUS status_backup,
dh.RECOVER,
dh.ERROR
from v$datafile d,
dba_data_files df, 
v$backup b,
v$datafile_header dh
where d.FILE# = dh.FILE#(+)
and d.FILE# = b.FILE#(+)
and d.FILE# = df.file_id(+) 
order by df.tablespace_name,d.NAME;

-- VERIFICAR ESTADO DOS OBJETOS

break on owner skip 2
comp sum of mb1 on owner
col o_type for a15
col mb1 format 999g999g999d99
col qtde format 9999g9999
select owner, o_type, tablespace_name, st, count (*) qtde
 from
(
select owner, 'TABLE' o_type, tablespace_name, status st
from dba_tables
union all
select owner, object_type, 'SYSTEM', status st
from dba_objects 
where object_type not in ('TABLE','INDEX','LOB')
union all
select owner, 'IX-' ||index_type, tablespace_name, status st
from dba_indexes
)
where owner not in (
'SYS','SYSTEM','PERFSTAT','DBSNMP','OUTLN','WMSYS','XDB','OLAPSYS','MDSYS','EXFSYS',
'SYSMAN','TSMSYS','PUBLIC','ORACLE_OCM','CTXSYS','DMSYS','ORDSYS','ORDPLUGINS'
)
group by owner, o_type, tablespace_name, st
order by owner, o_type, tablespace_name, st
/






