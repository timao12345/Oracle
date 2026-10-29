set serverout on size 100000
declare
l_objList dbms_stats.objecttab;
begin
dbms_stats.gather_database_stats ( options => 'LIST STALE', objlist => l_objlist );
  for i in 1 .. l_objlist.count
   loop
      dbms_output.put_line( l_objlist(i).objname );
   end loop;
dbms_output.put_line(' ');
dbms_output.put_line('TOTAL :'|| l_objlist.count);
dbms_output.put_line(' ');
end;
/
