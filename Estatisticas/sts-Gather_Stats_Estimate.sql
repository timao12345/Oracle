select 'exec dbms_stats.gather_'|| o.T ||'_stats(ownname=>''"'||o.O||
        '"'','|| o.TT ||'name=>''"'|| o.N ||'"'',estimate_percent=>&___ESTIMATE_PERCENT___'||
        decode (o.T, 'table', ',cascade=>FALSE', '')||
        ');'
        "____"
  from (select 'table' T, 'tab' TT, t.owner O, t.table_name N, t.last_analyzed L,
               upper (t.owner ||'.'|| t.table_name ||' '||
                      nvl (to_char (t.last_analyzed, 'DDMonYYYY/HH24:MI'), 'NOTANALYZED')) S
          from dba_tables t
         where t.owner not in
                ('ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS',
                 'DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS',
                 'MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE',
                 'OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM',
                 'QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES',
                 'QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA',
                 'STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP',
                 'WKPROXY','WKSYS','WMSYS','XDB','ORACLE_OCM')
         union all
        select 'index' T, 'ind' TT, i.owner O, i.index_name N, i.last_analyzed L,
               upper (i.owner ||'.'|| i.index_name ||' '||
                      i.table_owner ||'.'|| i.table_name ||' '||
                      nvl (to_char (i.last_analyzed, 'DDMonYYYY/HH24:MI'), 'NOTANALYZED')) S
          from dba_indexes i
         where i.owner not in
                ('ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS',
                 'DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS',
                 'MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE',
                 'OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM',
                 'QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES',
                 'QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA',
                 'STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP',
                 'WKPROXY','WKSYS','WMSYS','XDB','ORACLE_OCM')) o
 where o.S like upper ('%&___SEARCH___%')
   and o.N != 'PLAN_TABLE'
   and o.N not like 'BIN$%=%$'
 order by o.T desc, o.L ;
