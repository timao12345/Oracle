select 'grant select on REDEDES.'||table_name||' to CLAUDEMIROFREITAS;' from dba_tables where owner = 'REDEDES';

select 'grant select on CONSINCO.'||object_name||' to ETCCOM;' from dba_objects where owner = 'CONSINCO' and object_type in ('VIEW');

-- loop para fazer grant de select em views e tabelas
set serverout on;
begin
    for i in (select object_name from dba_objects where owner = 'CONSINCO' and object_type in ('TABLE'))
    loop

        execute immediate 'grant select on CONSINCO.'||i.object_name||' to INTEGRADOR';
        dbms_output.put_line('Grant select Suceffuly ' || i.object_name);
    end loop;
end;
/



grant execute on consincomonitor.fun_pegasegprinc to INTEGRADOR;