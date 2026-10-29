select inst_id, address, hash_value, child_number, id, lpad(operation,length(operation)+id) operation
from (select inst_id, address, hash_value, child_number, id,
             operation||' '||object_type||' '||options||' '||object_owner||nvl2(object_name,'.',null)||object_name operation
      from gv$sql_plan
      where sql_id = '&SQL_ID')
order by inst_id, hash_value, child_number, id;
