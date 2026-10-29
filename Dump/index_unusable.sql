SET LINES 900
SELECT OWNER, 
	INDEX_NAME, 
	INDEX_TYPE, 
--	TABLE_ONWER,
	TABLE_NAME, 
	STATUS,
	TABLESPACE_NAME,
	LAST_ANALYZED
FROM DBA_INDEXES 
WHERE STATUS !='VALID' and table_name='LANCONTAB';


SELECT 'ALTER INDEX '||OWNER||'."'||INDEX_NAME||'" REBUILD;' FROM DBA_INDEXES WHERE STATUS = 'UNUSABLE';

SELECT	
	OWNER,
	OBJECT_NAME,
	OBJECT_TYPE,
	STATUS,editionable,edition_name,generated
from dba_objects
where status <> 'VALID';

declare
	query varchar(100);
	index varchar(100);
begin
	SELECT INDEX_NAME INTO INDEX FROM DBA_INDEXES WHERE STATUS ='UNUSABLE';
	query :='ALTER INDEX :1 REBUILD ONLINE';
	execute immediate query using  index;
end;
/


SELECT INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'LM%';

SELECT INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'LM%';

SELECT owner,INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'AK_FIL_IN_CODIGO%';
SELECT owner,INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'IE_SO_DATAENTRADA%';
SELECT owner,INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'IE_SODATADOCTO%';
SELECT owner,INDEX_NAME,STATUS FROM DBA_INDEXES WHERE index_name like 'IE_SO_PRORROGADO%';


SELECT INDEX_NAME,STATUS  FROM DBA_INDEXES where status='INVISIBLE';

execute immediate alter index query REBUILD online;

-- deixar index invisivel
alter index MGFIN.AK_FIL_IN_CODIGO invisible;
alter index MGFIN.IE_SO_DATAENTRADA invisible;
alter index MGFIN.IE_SODATADOCTO invisible;
alter index CONSINCOMONITOR.IDX_LLS_TB_DOCTO01 invisible;

-- deixar o index visivel novamente
alter index CONSINCOMONITOR.TB_DOCTO_IE3 VISIBLE;

