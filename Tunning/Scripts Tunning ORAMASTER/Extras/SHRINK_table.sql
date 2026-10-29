1- Crie uma tabela clone da tabela SOE.ORDERS (se ja nao existir a ORDERS2) e crie um indice btree em qualquer coluna dessa tabela.
create table clone_table as select * from SOE.ORDERS ;


2- Analise o indice e veja o tamanho dele:
    ALTER INDEX SOE.&INDEX_NAME SHRINK SPACE;
    
    SELECT      i.owner,
                i.index_name AS "Index Name", 
                nvl(i.num_rows,0) AS "Rows",           
                ROUND((nvl(i.leaf_blocks,0) * p.value)/1024/1024,2) AS "Size MB", 
                i.last_analyzed AS "Last Analyzed"
    FROM        dba_indexes i,
                v$parameter p
    WHERE       i.owner = 'FUSIONT'
    AND         INDEX_NAME = '&index_name'
    AND         p.name = 'db_block_size'
    ORDER by    4 desc;

3- Delete 1 milhao de linhas na tabela criada no passo 1
    DELETE FROM SOE.&table_name WHERE ROWNUM < 100000;
    COMMIT;

4- Execute o SHRINK na tabela criada (ver comando abaixo), analise o indice novamente e veja de novo o tamanho dele. 
    alter table soe.orders2 shrink space;
    select * from dba_indexes where owner = 'SOE';
    
5- Agora responda a quest�o: o indice permaneceu com o mesmo tamanho, aumentou ou diminuiu? Porque?


select OWNER,SEGMENT_NAME,SEGMENT_TYPE,TABLESPACE_NAME,sum(bytes)/1024/1024 as MB from dba_segments where TABLESPACE_NAME='TSD_MEGA' 
group by  OWNER,SEGMENT_NAME,SEGMENT_TYPE,TABLESPACE_NAME
order by MB;


-- Realiza analise no index.
analyze index  FUSIONT.FUSIONTRAK_INTERP_LIMPA validate structure;

-- reliza shrink na tabela e movimenta a HWM
alter table FUSIONT.FUSIONTRAK_INT_ERP enable row movement;
alter table FUSIONT.FUSIONTRAK_INT_ERP shrink space;            


-- reliza shrink no index e movimenta a HWM
ALTER INDEX  FUSIONT.FUSIONTRAK_INTERP_LIMPA SHRINK SPACE;
ALTER INDEX  FUSIONT.FUSIONTRAK_PK SHRINK SPACE;
ALTER INDEX  FUSIONT.FUSIONTRAK_INTERP_VERIFICA SHRINK SPACE;

-- rebuild
alter index FUSIONT.FUSIONTRAK_INTERP_LIMPA rebuild;
alter index FUSIONT.FUSIONTRAK_PK rebuild;
alter index FUSIONT.FUSIONTRAK_INTERP_VERIFICA rebuild;

UNDEF INDEX_NAME
col owner for a15
col INDEX_NAME for a18
SELECT 
OWNER, 
INDEX_NAME, 
INDEX_TYPE, 
TABLE_NAME, 
STATUS,
LAST_ANALYZED
FROM DBA_INDEXES 
WHERE INDEX_NAME='FUSIONTRAK_INTERP_VERIFICA';
