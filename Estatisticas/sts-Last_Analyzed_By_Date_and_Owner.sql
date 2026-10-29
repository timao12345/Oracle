select '_Count_|_______Space_|LastAnalyze|_Owner__________'
       from dual union all
select substr (S, 1, 120) from (
  select lpad (count (o.NAME), 6, ' ') ||' | '||
         to_char (sum (nvl (s.BYTES, 0)) / 1024 / 1024, '9G999G990')||'M | '||
         decode (o.LA, null, '--never--', to_char (o.LA, 'DDMonYYYY')) ||' | '||
         o.OWNER
         S
    from DBA_SEGMENTS s,
         (select t.OWNER, trunc (t.LAST_ANALYZED) LA, t.TABLE_NAME NAME, 'TABLE' TYPE
            from DBA_TABLES t
           where t.TEMPORARY = 'N'
             and t.TABLE_NAME != 'PLAN_TABLE'
             and t.TABLE_NAME not like 'BIN$%=%$'
           union all
          select i.OWNER, trunc (i.LAST_ANALYZED) LA, i.INDEX_NAME NAME, 'INDEX' TYPE
            from DBA_INDEXES i
           where i.TEMPORARY = 'N'
             and i.INDEX_NAME not like 'BIN$%=%$') o
   where s.OWNER (+) = o.OWNER
     and s.SEGMENT_NAME (+) = o.NAME
     and s.SEGMENT_TYPE (+) = o.TYPE
     and s.OWNER not in
            ('ANONYMOUS','BACKUP','BACKUPDUMP','BKPDMP','CTXSYS',
             'DBSNMP','DIP','DMSYS','EXFSYS','HR','IX','LBACSYS',
             'MDDATA','MDSYS','MGMT_VIEW','ODM','ODM_MTR','OE',
             'OLAPSYS','ORDPLUGINS','ORDSYS','OUTLN','OWNER','PM',
             'QS','QS_ADM','QS_CB','QS_CBADM','QS_CS','QS_ES',
             'QS_OS','QS_WS','RECOVER','SCOTT','SH','SI_INFORMTN_SCHEMA',
             'STANDBY','SYS','SYSMAN','SYSTEM','TSMSYS','USERBKP',
             'WKPROXY','WKSYS','WMSYS','XDB','ORACLE_OCM')
   group by o.LA, o.OWNER
   order by o.OWNER, o.LA, sum (s.BYTES)
) ;
