begin
   for cur in( select owner, object_name, object_type from dba_objects where status='INVALID') loop
    begin
     if cur.object_type <> 'PACKAGE BODY' then
        execute immediate 'alter ' || cur.object_type || ' '|| cur.owner || '.'  || cur.object_name || ' compile';
     else
        execute immediate 'alter package ' || cur.owner || '.' || cur.object_name || ' compile body';
     end if;
   exception
   when others then null;
   end ;
   end loop;
end;
/
