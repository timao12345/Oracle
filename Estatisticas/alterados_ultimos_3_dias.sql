select 'exec DBMS_STATS.GATHER_TABLE_STATS(ownname=>''"'|| t.owner || '"'',tabname=>''' || t.table_name || ''',METHOD_OPT=>''FOR ALL COLUMNS SIZE SKEWONLY'',degree=>4); '
--select /*+rule*/ 'exec dbms_stats.gather_table_stats(ownname=> ' ||''''|| t.owner ||''''|| ', tabname=>'|| '''' || '"' || t.table_name || '"' || '''' || ', partname=> null);'
from dba_objects q,
	 dba_tables t
where trunc(LAST_DDL_TIME) >= trunc( sysdate-1)
	  and q.STATUS = 'VALID'
	  and q.OWNER not in ('SYS','PUBLIC')
	  and q.owner = t.owner
	  and q.object_name = t.table_name
	  and t.owner not in ('SYS','SYSTEM','OUTLN','DIP','TSMSYS','DBSNMP','WMSYS','EXFSYS','XDB','ANONYMOUS','CTXSYS','DMSYS','MDSYS','ORDSYS','SYSMAN')
	  and t.tablespace_name is not null
	  and t.temporary = 'N'
union all
select 'exec dbms_stats.gather_index_stats(ownname=> ' ||''''|| t.owner ||''''|| ', indname=>'|| '''' || '"' || t.index_name || '"' || '''' || ', partname=> null,degree=>4);'
from dba_objects a,
	 dba_indexes t
where trunc(LAST_DDL_TIME) >= trunc( sysdate-1)
	  and a.STATUS = 'VALID'
	  and a.OWNER not in ('SYS','PUBLIC')
	  and a.owner = t.owner
	  and a.object_name = t.index_name
	  and t.owner not in ('SYS','SYSTEM','OUTLN','DIP','TSMSYS','DBSNMP','WMSYS','EXFSYS','XDB','ANONYMOUS','CTXSYS','DMSYS','MDSYS','ORDSYS','SYSMAN')
/

set feedback off;
set heading off;
set underline off;
set pagesize 0;
set timing on;
select seg_cnt
	from (with a as
		(SELECT /*+ RULE */ a.last_analyzed
	FROM dba_tables a, dba_objects c
WHERE (a.last_analyzed IS NULL OR a.last_analyzed < SYSDATE - 15)
		AND a.OWNER NOT IN ('APPQOSSYS','ANONYMOUS','AUDSYS','APEX_030200','APEX_040000','APEX_040200','BKP','BACKUP','BACKUPDUMP','BKPDMP','COMUM','CTXSYS',
							'DBSNMP','DIP','DBM','DBSFWUSER','DVF','DVSYS','DMSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','HR','IX','LBACSYS','MDDATA',
							'MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OJVMSYS','OLAPSYS','ORDPLUGINS','ORDSYS','ORDDATA','ORACLE_OCM','OUTLN','OPER_USER',
							'PERFSTAT','PM','PUBLIC','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','REMOTE_SCHEDULER_AGENT',
							'RESTORE','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TESTE','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB')
		AND a.temporary = 'N'
		AND a.TABLE_NAME not in ('PLAN_TABLE', 'TOAD_PLAN_TABLE', 'TOAD_PLAN_SQL')
		AND a.table_name NOT IN (SELECT table_name FROM dba_external_tables)
		AND a.table_name NOT IN (SELECT TABLE_NAME FROM dba_tab_statistics WHERE STATTYPE_LOCKED IS NOT NULL)
		AND c.created < TRUNC (SYSDATE - 2)
		AND a.table_name = c.object_name
UNION ALL
SELECT /*+ RULE */ a.last_analyzed
	FROM dba_indexes a, dba_objects c
WHERE (a.last_analyzed IS NULL OR a.last_analyzed < SYSDATE - 15)
		AND a.owner NOT IN ('APPQOSSYS','ANONYMOUS','AUDSYS','APEX_030200','APEX_040000','APEX_040200','BKP','BACKUP','BACKUPDUMP','BKPDMP','COMUM','CTXSYS',
							'DBSNMP','DIP','DBM','DBSFWUSER','DVF','DVSYS','DMSYS','EXFSYS','FLOWS_FILES','GSMADMIN_INTERNAL','HR','IX','LBACSYS','MDDATA',
							'MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OJVMSYS','OLAPSYS','ORDPLUGINS','ORDSYS','ORDDATA','ORACLE_OCM','OUTLN','OPER_USER',
							'PERFSTAT','PM','PUBLIC','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','REMOTE_SCHEDULER_AGENT',
							'RESTORE','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TESTE','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB')
		AND a.temporary = 'N'
		AND a.INDEX_TYPE not in ('LOB', 'DOMAIN')
		AND a.index_name NOT IN (SELECT INDEX_NAME FROM DBA_IND_STATISTICS WHERE STATTYPE_LOCKED IS NOT NULL)
		AND c.created < TRUNC (SYSDATE - 2)
		AND a.index_name = c.object_name)
		select count(1) seg_cnt from a);