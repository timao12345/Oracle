----------------------------------------------------------------------------------------
-- VERIFICAR TAMANHO DOS OBJETOS DE UM SCHEMA E TAMANHO DUMP GERADO
----------------------------------------------------------------------------------------
set pagesize 5555
set linesize 500
column OBJETO format a40
undef owner
BREAK ON REPORT

ACCEPT owner CHAR PROMPT 'Nome do owner do objeto: '

SELECT A.OWNER, A.TABLESPACE_NAME, SUM(A.Tamanho_MB) TOTAL_MB, SUM(B.TAMANHO_MB_DUMP) DUMP_MB
FROM 
	(select tablespace_name, owner, round(sum(bytes)/1024/1024, 2) TAMANHO_MB
	 from dba_segments
	 where owner IN ('&&Owner')
	 group by tablespace_name, owner) A,
	(select owner, round(sum(bytes)/1024/1024, 2) TAMANHO_MB_DUMP
	 from dba_segments
	 where owner IN ('&&Owner')
	 and segment_type not in ('INDEX','INDEX PARTITION','INDEX SUBPARTITION')
	 group by owner) B
WHERE a.owner = b.owner
group by A.TABLESPACE_NAME, A.OWNER
/
