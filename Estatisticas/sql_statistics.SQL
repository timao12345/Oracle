select c.SID, c.OSUSER, c.MACHINE, b.OPERATION, b.OPTIONS, count(1)
  from sys.v_$sql a,
       sys.v_$sql_plan b,
       sys.V_$SESSION c
 where a.ADDRESS = b.ADDRESS
   and a.HASH_VALUE = b.HASH_VALUE
   and c.SQL_ADDRESS = a.ADDRESS
   and c.SQL_HASH_VALUE = a.HASH_VALUE
   and b.OPTIONS is not null
group by c.SID, c.OSUSER, c.MACHINE, b.OPERATION, b.OPTIONS
