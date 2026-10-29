-- drop as tabelas automatico a partir e um owner digitado e um tipo de objeto digitado
set serveroutput on;
begin
for i in (select owner, object_name ,object_type from dba_objects where owner='&owner' and  object_type='&tipo_de_objeto')
   loop

    execute immediate  'drop ' || i.object_type || ' ' || i.owner||'.'|| i.object_name || ' cascade';

  end loop;
end;
/


-- cria o comando para dropar tabelas a partir de um owner digitado e um tipo de objeto digitado
set serveroutput on;
begin
for i in (select owner, object_name, object_type from dba_objects where owner='&owner' and object_type='&tipo_de_objeto')
   loop
        case
            when i.object_type = 'TABLE' then dbms_output.put_line ('drop table ' || i.owner||'.'|| i.object_name || ' cascade;');

            when i.object_type = 'PROCEDURE' then dbms_output.put_line ('drop procedure ' || i.owner||'.'|| i.object_name || ';');

            when i.object_type = 'TRIGGER' then dbms_output.put_line ('drop trigger ' || i.owner||'.'|| i.object_name || ';');

            when i.object_type = 'INDEX' then dbms_output.put_line ('drop index ' || i.owner||'.'|| i.object_name || ';');

            when i.object_type = 'VIEW' then dbms_output.put_line ('drop view ' || i.owner||'.'|| i.object_name || ';');

            when i.object_type = 'FUNCTION' then dbms_output.put_line ('drop function ' || i.owner||'.'|| i.object_name || ';');
    end loop;
end;
/






begin
  for i in (select owner, object_name, object_type from dba_objects where owner='TESTE' and object_type='TABLE')
    loop

        execute immediate  'DROP ' || i.object_type || ' ' || i.OWNER||'.'|| i.object_name || ' CASCADE';

    end loop;
end;
/


select owner, object_type, object_name from dba_objects where owner='TESTE';

DBMS_OUTPUT.PUT_LINE ('DROP ' || object_type || '.'||object_name || ' CASCADE;') 

drop teste.tabela cascade;

select owner, object_type ,count (object_name)   from dba_objects where owner='SANKHYA' group by owner,object_type ORDER BY object_type;

SANKHYA
set serveroutput on;
begin
for i in (select owner, object_name, object_type from dba_objects where owner='TESTE' and object_type='PROCEUDRE')
   loop

      DBMS_OUTPUT.PUT_LINE ('DROP ' || i.object_type || ' ' || i.OWNER||'.'|| i.object_name || ';');

  end loop;
end;
/
