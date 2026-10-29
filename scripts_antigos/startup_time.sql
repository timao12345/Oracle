-- Script para verificar horário de ativação da Instância

col host_name form a15
col instance_name form a10 head NAME
col version for a10
col startup_time for a23
col status for a12
col logins for a10
col database_status for a12 head DB_STATUS
col instance_role for a18

select
instance_name,
host_name,
version,
to_char(startup_time,'DD/MM/YYYY DY HH24:MI:SS') startup_time,
status,
logins,
database_status,
instance_role
from v$instance
/
