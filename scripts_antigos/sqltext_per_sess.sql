rem
rem ARQUIVO
rem    sess_sql.sql
rem
rem FINALIDADE
rem    Exibe comandos SQL por sessao
rem
rem MODIFICACOES
rem    01-07-97      Fabio Santana     criacao do script (pela n-esima vez...)
rem

set echo off
set verify off

col sql_text for a65 word_wrap
col sessao for a15

undef OWNER
break on sessao skip 1 on rows_processed on report

select '''' || to_char(s.sid) || ',' || to_char(s.serial#) || '''' as sessao,
       v.rows_processed,
       v.sql_text
from sys.gv_$session s,
     sys.gv_$sqlarea v
where s.sql_hash_value = v.hash_value
and s.username like upper('&OWNER')
order by s.sid;