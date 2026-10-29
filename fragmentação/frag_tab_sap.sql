-- Pega as tabelas fragmentadas e forma o loop para gerar o script de shrink
col CREATED format a20
col last_analyzed format a20
col last_ddl_time format a20
col table_name format a35
col owner format a20
col Num_Rows format 9999999999
col Atual_Mb format 9999999
col Estimate_MB format 99999999
col Pct_Frag format 99999
set serveroutput on
set lines 750 pages 1000
set colsep '|'
set timing on
spool 'reorg_sap.sql'
begin
for r in (with tab_frag as (
Select Dba_Objects.Created,
      Dba_Tables.Last_Analyzed,
      Dba_Objects.last_ddl_time,
      Dba_Objects.owner,
      Dba_Tables.Table_Name as table_name ,
      Dba_Tables.Num_Rows,
      Round(Dba_Tables.Avg_Row_Len) AvgRow_Bytes,
      Round((Dba_Tables.Blocks * '8192') / 1024 / 1024) Atual_Mb,
      Round((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024) Estimate_MB,
      Round(((Dba_Tables.Blocks * '8192') / 1024 / 1024) -
            ((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024)) Frag_Mb,
      Round(((Dba_Tables.Blocks * '8192') -
            (Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len)) /
            (Dba_Tables.Blocks * '8192') * 100) Pct_Frag
From Dba_Objects, Dba_Tables
Where Dba_Objects.Object_Name = Dba_Tables.Table_Name
  And Dba_Objects.Owner = Dba_Tables.Owner
  And Dba_Objects.OBJECT_TYPE = 'TABLE'
  --And Dba_Tables.table_name = upper('ADR2')
  And Dba_Tables.Blocks >= 10000
  And Dba_Tables.Num_Rows >= 10000
  and (dba_tables.blocks * 8192 / 1024 / 1024) > 10000 and (dba_tables.blocks * 8192 / 1024 / 1024) < 100000
  and (((Dba_Tables.Blocks * '8192') - (Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len)) / (Dba_Tables.Blocks * '8192') * 100) > 20
Order By  Atual_Mb asc
)
select owner,table_name from tab_frag)
loop
-- Executa o row movement
  dbms_output.put_line('ALTER TABLE '|| r.owner || '.'||r.table_name|| ' ENABLE ROW MOVEMENT;');

-- Executa shrink nas tabelas
  dbms_output.put_line( 'ALTER TABLE '|| r.owner || '.'||r.table_name|| ' SHRINK SPACE CASCADE;');

-- Desabilita o row movement
  dbms_output.put_line( 'ALTER TABLE '|| r.owner || '.'||r.table_name|| ' DISABLE ROW MOVEMENT;');
  
  -- Executa a coleta de estatistica ao termino do processo de shrink
  dbms_output.put_line('EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>''' || r.owner || ''', TABNAME=>''' || r.table_name || ''', cascade=>true, degree=>5);');

  -- Verifica indices da tabela e gera o script de rebuild por indice da tabela.
  for i in (select owner, INDEX_NAME from DBA_INDEXES where TABLE_OWNER = r.owner AND TABLE_NAME =  r.table_name)
  loop
    dbms_output.put_line('ALTER INDEX '||i.owner ||'."'||i.INDEX_NAME||'" REBUILD parallel 5 nologging;');
  end loop;
end loop;
end;
/
spool off


col CREATED format a20
col last_analyzed format a20
col last_ddl_time format a20
col table_name format a35
col owner format a20
col Num_Rows format 9999999999
col Atual_Mb format 9999999
col Estimate_MB format 99999999
col Pct_Frag format 99999
set lines 750 pages 1000
set colsep '|'
Select Dba_Objects.Created,
      Dba_Tables.Last_Analyzed,
      Dba_Objects.last_ddl_time,
      Dba_Objects.owner,
      Dba_Tables.Table_Name as table_name ,
      Dba_Tables.Num_Rows,
      Round(Dba_Tables.Avg_Row_Len) AvgRow_Bytes,
      Round((Dba_Tables.Blocks * '8192') / 1024 / 1024) Atual_Mb,
      Round((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024) Estimate_MB,
      Round(((Dba_Tables.Blocks * '8192') / 1024 / 1024) -
            ((Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len) / 1024 / 1024)) Frag_Mb,
      Round(((Dba_Tables.Blocks * '8192') - (Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len)) / (Dba_Tables.Blocks * '8192') * 100) Pct_Frag
From Dba_Objects, Dba_Tables
Where Dba_Objects.Object_Name = Dba_Tables.Table_Name
  And Dba_Objects.Owner = Dba_Tables.Owner
  And Dba_Objects.OBJECT_TYPE = 'TABLE'
  And Dba_Tables.Blocks >= 10000
  And Dba_Tables.Num_Rows >= 1000
  and (dba_tables.blocks * 8192 / 1024 / 1024) > 10000 and (dba_tables.blocks * 8192 / 1024 / 1024) < 100000
  and (((Dba_Tables.Blocks * '8192') - (Dba_Tables.Num_Rows * Dba_Tables.Avg_Row_Len)) / (Dba_Tables.Blocks * '8192') * 100) > 20
Order By  Atual_Mb desc;



-- Bloco para realizar shrink em uma tablespace especifica.
BEGIN
  -- Percorre todas as tabelas da tablespace desejada
  FOR t IN (SELECT table_name 
            FROM dba_tables 
            WHERE tablespace_name = 'PSAPSR3' -- Substitua pelo nome da sua tablespace
  LOOP
    BEGIN
      -- 1. Habilita o movimento de linhas
      EXECUTE IMMEDIATE 'ALTER TABLE ' || t.table_name || ' ENABLE ROW MOVEMENT';
      
      -- 2. Executa o shrink
      EXECUTE IMMEDIATE 'ALTER TABLE ' || t.table_name || ' SHRINK SPACE';
      
      DBMS_OUTPUT.PUT_LINE('Sucesso na tabela: ' || t.table_name);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao processar ' || t.table_name || ': ' || SQLERRM);
    END;
  END LOOP;
END;
/