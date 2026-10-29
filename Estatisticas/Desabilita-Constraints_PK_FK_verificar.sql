



--disable
select 'ALTER TABLE ' || owner || '."' || table_name ||
       '" DISABLE CONSTRAINT "'|| constraint_name || '";'
from
    dba_constraints
where
   table_name in(
   'COBRANCA') AND OWNER='SUR';


SELECT 'alter table '||c.owner||'.'||c.table_name|| ' disable constraint '||c.constraint_name||';'       
 FROM dba_constraints p       JOIN dba_constraints c ON(p.constraint_name=c.r_constraint_name)       
 WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U')       
 AND c.constraint_type = 'R'       
 AND p.table_name IN('COMPOSICAO_MENSALIDADE')
AND P.OWNER='SIA';

--enable
  SELECT 'alter table '||c.owner||'.'||c.table_name|| ' enable novalidate constraint '||c.constraint_name||';'       
 FROM dba_constraints p       JOIN dba_constraints c ON(p.constraint_name=c.r_constraint_name)       
 WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U')       
 AND c.constraint_type = 'R'       
 AND p.table_name IN('TDW_CONTA')
AND P.OWNER='PRD01_BI_DW';



select 'ALTER TABLE ' || owner || '."' || table_name ||
       '" ENABLE NOVALIDATE CONSTRAINT "'|| constraint_name || '";'
from
    dba_constraints
where
   table_name in('TDW_CONTA') AND OWNER='PRD01_BI_DW';



--disable triggers

SELECT 'ALTER TRIGGER '||OWNER||'.'||TRIGGER_NAME||' DISABLE;' FROM DBA_TRIGGERS WHERE TRIGGER_NAME IN('CARNE','') WHERE OWNER='SIA' AND STATUS='ENABLE';


SELECT 'ALTER TRIGGER '||OWNER||'.'||TRIGGER_NAME||' ENABLE;' FROM DBA_TRIGGERS WHERE TRIGGER_NAME IN('CARNE','') WHERE OWNER='SIA' AND STATUS='ENABLE';


--COPIA DAS TABELAS

Vamos editar o SP_refresh_tables_faltantes_homologacao.sh

CARNE

CHAMAR A PROCEDURE ORASTATUS.SP_REFRESH_P4




Att

Fabio Alves
UOL DIVEO  - DBA Sr
Rua Barão de Limeira 425 1º andar B 
Campos Elíseos - São Paulo – SP – CEP 01202-000 
Telefone: 2540-4098  Celular: 11 9-8676-1026 - www.uol.com.br

