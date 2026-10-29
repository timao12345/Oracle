|=======================|
|   ESTATISTICS TABLE   |
|=======================|

-- Verificar  estatísticas por tabela

alter session set nls_date_format='dd/mm/yy:hh24:mi:ss';
UNDEF TABLE_NAME
set pages 200
col LAST_ANALYZED for a20
SELECT OWNER, TABLE_NAME, TABLESPACE_NAME, STATUS, LAST_ANALYZED FROM DBA_TABLES WHERE TABLE_NAME=upper ('&&TABLE_NAME');