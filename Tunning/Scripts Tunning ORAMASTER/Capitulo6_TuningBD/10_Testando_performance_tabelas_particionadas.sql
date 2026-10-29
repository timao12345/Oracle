-- deixar PK da CUSTOMERS invisible para permitir comparar planos de sqls similares sem usar indice:
ALTER INDEX SOE.CUSTOMERS_PK INVISIBLE;

-- criar tabela heap clone:
create table soe.customers2 as select * from soe.customers;

-- ver plano de execucao na tabela HEAP clone:
explain plan for
  select * from soe.customers2 where CUSTOMER_ID in (2380, 531, 6612, 8881); -- 9,8s
select * from table(dbms_xplan.display);

-- ver plano de execucao da consulta abaixo na tabela particionada 
explain plan for
  select * from soe.customers where CUSTOMER_ID in (2380, 531, 6612, 8881);  -- 0,2s
select * from table(dbms_xplan.display);

-- apague a tabela customers2:
DROP TABLE soe.customers2;

-- reconfigure o indice:
ALTER INDEX SOE.CUSTOMERS_PK INVISIBLE;