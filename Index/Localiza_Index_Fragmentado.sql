-- Criar tabela
create table sys.tb_index_stats (name varchar2(40), del_lf_rows number,  lf_rows_used number, ibadness number);

-- executar o comando para pegar todos index do owner desejado, demora mesmo!, pode dar erro se uma tabela estiver bloqueada por alguma operação
begin
  for i in (select owner, index_name from dba_indexes)
    loop

      execute immediate 'ANALYZE INDEX '|| i.owner||'.'||i.index_name ||' VALIDATE STRUCTURE';

      insert into sys.tb_index_stats (SELECT name, del_lf_rows, lf_rows - del_lf_rows lf_rows_used, TO_CHAR( del_lf_rows /(DECODE(lf_rows,0,0.01,lf_rows))*100,'999.99999') ibadness FROM index_stats);

      commit;
    end loop;
end;
/


--Se o valor da coluna IBADNESS da tabela sys.tb_index_stats for maior que 20, o indice é candidato a reduild.
--este select concatena e gera script para recriar os indices

select 'alter index '||OWNER||'.'||index_name||' rebuild tablespace '||TABLESPACE_NAME||';' from dba_indexes
WHERE INDEX_NAME IN (SELECT NAME FROM sys.tb_index_stats WHERE ibadness >20);
