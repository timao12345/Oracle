-- Result cache pode ser habilitado via 3 caminhos: alter session, alter system e hint em sql. Para habilita-lo vc pode usar os parametros:
--    result_cache_mode: MANUAL (default) ou FORCE
--    result_cache_max_size:  valor em bytes do tamanho da result cache
--    result_cache_max_result: valor percentual q um unico resultset pode armazenar (default = 5%) -> para grandes resultados pode ser necessario aumentar este valor
--    result_cache_remote_expiration: tempo em minutos para objetos remotos expirarem (valor default nao faz cache de objetos remotos)

-- verificar parametros result_cache
SHOW PARAMETER result_cache

-- configurando area para result cache
alter system set result_cache_max_size =100M;  -- tamanho da RC
alter system set result_cache_max_result = 50;  -- tamanho default eh igual 5 por cento do tamanho total do RC
alter system set result_cache_remote_expiration = 10; -- configurando para objetos remotos expirarem depois de 10 minutos

-- limpar BC e RC:
alter system flush buffer_cache;
exec  dbms_result_cache.flush;

-- testando SQL abaixo sem RC (tempo medio de 7s):
 select distinct * from (select department_name, emp_count
 from (select 
      department_id, count(*) emp_count
      from hr.employees
      group by department_id) e, hr.departments d
 where e.department_id = d.department_id
 connect by level < 7);
  
-- testando mesmo SQL acima com RC (tempo medio a partir da 2a execucao = 0,005s)
 select /*+ result_cache */ distinct * from (select department_name, emp_count
 from (select 
      department_id, count(*) emp_count
      from hr.employees
      group by department_id) e, hr.departments d
 where e.department_id = d.department_id
 connect by level < 7);
 
 -- Ao fazer UPDATE na tabela veja que o RC foi excluido:
 UPDATE hr.employees SET department_id = department_id WHERE ROWNUM =1;
 COMMIT;

-- visualizar objetos no result cache
select * from v$result_cache_objects where UPPER(name) like '%HR.%';

-- ver estatisticas do result cache
select * from v$result_cache_statistics;
 
-- limpar result cache
exec dbms_result_cache.flush;

-- configurar para nao usar o result cache
exec dbms_result_cache.bypass(true);

-- configurar para voltar a usar o result cache
exec DBMS_RESULT_CACHE.BYPASS(false);

-- visualizar relatorio com visao geral sobre a result cache
set serveroutput on
exec DBMS_RESULT_CACHE.MEMORY_REPORT;