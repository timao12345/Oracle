-- Execution Plan
col Plano format a100
select decode(depth,0,chr(10))||trim(depth) ||'. '||lpad(' ',depth -1) ||operation||' '||options||' on '||object_name plano,
cost "Cost",
cardinality "Rows",
bytes "Bytes"
from v$sql_plan
where sql_id = '&SQL_ID'
order by child_address,id
--order by address, hash_value, parent_id, id
/