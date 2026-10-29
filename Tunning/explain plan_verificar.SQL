select a.STATEMENT_ID, a.ID,
       a.OPTIMIZER || lpad( a.OPERATION || ' ' || a.OPTIONS, 5*parent_id+30 )
                   ||'  '|| object_name plano, a.COST
from plan_table a
where a.STATEMENT_ID = 'QRY1'
connect by id = parent_id


SELECT * FROM TABLE(dbms_xplan.display) --> tem opção de passar o statement_id

select * from table(dbms_xplan.display_cursor('&sql_id',0))