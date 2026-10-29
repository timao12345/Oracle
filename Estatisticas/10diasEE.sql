SELECT 'exec dbms_stats.gather_' || o.T || '_stats(ownname=>''"' || o.O || '"'',' || o.TT || 'name=>''"' || o.N || '"'',degree=>8)/*' || to_char(o.L,'DDMonYYYY') || '*/;' "____"
FROM (SELECT 'table' T
    ,'tab' TT
    ,t.owner O
    ,t.table_name N
    ,t.last_analyzed L
    ,upper('/' || t.owner || '.' || t.table_name || '/' || to_char(t.last_analyzed,'DDMonYYYY') || '/') S
     FROM dba_tables t
     where temporary <> 'Y'
     UNION ALL
     SELECT 'index' T
    ,'ind' TT
    ,i.owner O
    ,i.index_name N
    ,i.last_analyzed L
    ,upper('/' || i.owner || '.' || i.index_name || '/' || i.table_owner || '.' || i.table_name || '/' || to_char(i.last_analyzed,'DDMonYYYY') || '/') S
     FROM dba_indexes i
     where temporary <> 'Y') o
WHERE o.O NOT IN ('APPQOSSYS','ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS','MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE','OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM','QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES','QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA','STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP','WKPROXY','WKSYS','WMSYS','XDB','PUBLIC','ORACLE_OCM')
      AND o.N != 'PLAN_TABLE'
      AND o.N NOT LIKE '%==%'
      AND (o.l IS NULL
           OR o.l < SYSDATE - 10)
ORDER BY o.T DESC,o.L
/
