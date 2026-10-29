-- verifica patchs instalados no BD

SET LINESIZE 500
SET PAGESIZE 1000
SET SERVEROUT ON
SET LONG 2000000
COLUMN action_time FORMAT A18
COLUMN action FORMAT A10
COLUMN patch_type FORMAT A10
COLUMN description FORMAT A55
COLUMN status FORMAT A10
COLUMN version FORMAT A10
alter session set "_exclude_seed_cdb_view"=FALSE;
select CON_ID,
TO_CHAR(action_time, 'DD/MM/YY HH24:MI') AS action_time,
PATCH_ID,
PATCH_TYPE,
ACTION,
DESCRIPTION,
SOURCE_VERSION,
TARGET_VERSION
from CDB_REGISTRY_SQLPATCH
order by CON_ID, action_time, patch_id;