-- consultando ITL (Interested Transaction List) Waits por segmento:
select OWNER, OBJECT_NAME, statistic_name, value from v$segment_statistics where statistic_name = 'ITL waits' AND VALUE > 0;

-----------------------------------------------------------------------------------------------------

-- criando a tabela SOE.OI para testar PCTFREE:
CREATE TABLE SOE.OI AS SELECT * FROM SOE.ORDER_ITEMS;

-- coletando estatisticas na tabela (necessario ate 11g apos CTAS)
--EXEC DBMS_STATS.GATHER_TABLE_STATS('SOE','OI');

-- verificar qtde linhas media por bloco
SELECT num_rows / blocks FROM DBA_TABLES WHERE OWNER = 'SOE' and table_name = 'OI';

-- consultando qtde linhas por bloco + menor e maior valor do identificador contidos nos blocos:
select      dbms_rowid.rowid_block_number(rowid) Block#, count(1) as total_linhas, min(col_ident) as menor_valor, max(col_ident) as maior_valor
from        SOE.OI
group by    dbms_rowid.rowid_block_number(rowid)
order by    1;

-- configurar PCTFREE = 70 e INITRANS =2:
ALTER TABLE SOE.OI PCTFREE 70 INITRANS 2;

-- REORGANIZE A TABELA:
ALTER TABLE SOE.OI MOVE;

-- coletando estatisticas na tabela (necessario ate 11g apos CTAS):
EXEC DBMS_STATS.GATHER_TABLE_STATS('SOE','OI');

-- verifique q a qtde linhas por bloco DIMINUIU:
SELECT num_rows / blocks FROM DBA_TABLES WHERE OWNER = 'SOE' and table_name = 'OI';

