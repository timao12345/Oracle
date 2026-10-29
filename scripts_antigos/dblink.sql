-- Dblinks
 
 
set lines 200 
set pages 80
col DB_LINK for a20
col name for a15
col USERNAME for a15
col host for a80
select * from dba_db_links;