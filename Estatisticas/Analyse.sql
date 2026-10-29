select distinct 'exec dbms_stats.gather_table_stats(ownname=> ' ||''''|| a.owner ||''''|| ', tabname=>'|| '''' || '"' || a.table_name || '"' || '''' || ', partname=> null)'|| '/*' ||a.last_analyzed||' */;'
from dba_tables a, dba_objects c
where (a.last_analyzed is null or a.last_analyzed < sysdate -5)
AND a.OWNER not in ('APPQOSSYS','ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS','MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB','PUBLIC','ORACLE_OCM', 'PERFSTAT', 'GSMADMIN_INTERNAL', 'AUDSYS', 'OJVMSYS', 'DBSFWUSER', 'ORDDATA', 'DVSYS', 'APEX_040200')
and a.temporary = 'N'
and a.table_name not in (select table_name from dba_external_tables)
and c.created < trunc(sysdate-10)
and a.table_name=c.object_name;