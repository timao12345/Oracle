----------------------------------------------------------------------------------------
-- Export SYNONUMS
----------------------------------------------------------------------------------------

select 'create public synonym ' || synonym_name ||' for ' || table_owner || '.' || table_name || ';'
from dba_synonyms
where owner = '&OWNER'
and table_owner = '&TABLE'
/