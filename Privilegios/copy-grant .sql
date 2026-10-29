
select 'grant EXECUTE on CONSINCO.'||object_name||' to SAERJ;' from dba_objects where owner = 'CONSINCO' and object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');

select 'grant SELECT  on CONSINCO.' ||object_name || ' to SAERJ;' from dba_objects where owner='CONSINCO' and object_type in ('VIEW','TABLE');

grant UPDATE on consinco.map_famdivcateg to SAERJ;
grant UPDATE on consinco.map_produto to SAERJ;
grant UPDATE on consinco.map_familia to SAERJ;
grant UPDATE on consinco.map_famdivisao to SAERJ;
grant UPDATE on consinco.map_prodcodigo to SAERJ;
grant UPDATE on consinco.map_tributacaouf to SAERJ; 

-- GRANT EM PROC FUNC PACKAGE E PACKAGE BODY
set serveroutput on

declare
    v_sql varchar2(200);
begin 
    for i in (select object_name from dba_objects where owner = 'CONSINCO' and object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY')) 
    loop
        v_sql:= 'grant select on consinco.' || i.object_name || ' to saerj;';
        
        dbms_output.put_line (v_sql);

        execute immediate v_sql;

        dbms_output.put_line ('GRAN SELECT SUCCESSFULLY');
        
    end loop;
end;
/

-- GRANT EM TABLES E VIEWS
set serveroutput on
begin 
    for i in (select object_name from dba_objects where owner = 'CONSINCO' and object_type in ('VIEW','TABLE')) 
    loop
        execute immediate 'grant select on consinco.' || i.object_name || ' to saerj;';
        dbms_output.put_line ('GRAN SELECT SUCCESSFULLY');
    end loop;
end;
/