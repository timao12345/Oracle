-- Script para verificar data de criação do Banco de Dados

col name for a13
col created for a20
col log_mode for a13
col open_resetlogs for a14

select name, to_char(created,'dd/mm/yyyy hh24:mi:ss') created, log_mode, open_resetlogs
from v$database
/