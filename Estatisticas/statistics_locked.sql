select owner, table_name, last_analyzed,      
       stattype_locked, stale_stats      
  from dba_tab_statistics 
--  where stale_stats='YES'; -- se quiser as stales...
  