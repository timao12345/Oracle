select 'ALTER ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
from dba_objects
where status ='INVALID';
and owner='SYSTEM';
order by 2;

select owner,object_name, object_type, status, last_ddl_time
from dba_objects
where status ='INVALID';

-- Via bloco anonimo
Begin
for c in (select owner,object_name, decode(object_type,'PACKAGE BODY','PACKAGE',object_type) as object_type, status, decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') as types
from dba_objects
where status ='INVALID') 
loop
dbms_output.put_line('ALTER ' || c.object_type || ' ' ||c.owner || '.' || c.object_name || c.types);
end loop;
end;
/
--backup via bloco anonimo

-- Faz backup DDL de objetos que estão invalidos
set serveroutput on
set linesize 200;
set pagesize 10000;
set long 9999999;
set ECHO off;
set FEED off;
set HEAD off;
set time off;
set timi off;
COLUMN DDL FORMAT a9999;
set wrap on
 
spool gera_bkp_invalidos.sql
set serveroutput on;
Declare
cursor 
gera_bkp_invalidos
is
select owner,object_name, decode(object_type,'PACKAGE BODY','PACKAGE',object_type) as object_type, status
from dba_objects
where status ='INVALID';
Begin
    dbms_output.put_line('set linesize 200');
    dbms_output.put_line('set pagesize 10000');
    dbms_output.put_line('set long 9999999');
    dbms_output.put_line('set ECHO off');
    dbms_output.put_line('set FEED off');
    dbms_output.put_line('set time off');
    dbms_output.put_line('set timi off');
    dbms_output.put_line('set heading off');
    dbms_output.put_line('undef object_type');
    dbms_output.put_line('undef object_name');
    dbms_output.put_line('undef owner');
    dbms_output.put_line('set trims on');
    dbms_output.put_line('column COLUMN DDL FORMAT a9999');
  for linha in gera_bkp_invalidos
  loop
    dbms_output.put_line('spool '||linha.owner||'-'||linha.object_name||'.txt');
    dbms_output.put_line('SELECT dbms_metadata.get_ddl('''||linha.object_type||''','''||linha.object_name||''','''||linha.owner||''') DDL from dual;');
    dbms_output.put_line('spool off;');
  end loop;
end;
/
spool off;

--- // ---


for c1 in (SELECT distinct platform_name FROM sys.GV_$DATABASE 
where dbid = &DBID
and rownum = 1)
loop
dbms_output.put_line(rpad('!PLATFORM_NAME',l_pad_length)||' '||c1.platform_name);
end loop;



select 'ALTER ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
from dba_objects
where status ='INVALID' ;

and last_ddl_time > TO_DATE(TO_CHAR(sysdate,'DD/MM/YYYY') || ' '|| ' &data.','DD/MM/YYYY HH:MI:SS');


select owner, count(table_name) as QTDTB from dba_tables where owner like '%MG%' group by owner;

select OWNER, count(OBJECT_NAME) as QTD from dba_objects where status ='INVALID' group by owner order by owner asc;

select OWNER,object_type, count(OBJECT_NAME) as QTD 
from dba_objects
where owner='ASSISTE' and status ='INVALID' group by owner,object_type order by owner asc;

-- Para os SYNONYM o ideal caso não compile é recrialo
set heading off
set feedback off
set linesize 80
set pagesize 50000
select 'create or replace public synonym '||object_name||chr(10)||' for '||table_owner||'.'||object_name||';' as SYM
from dba_objects a
join dba_synonyms b on a.object_name = b.synonym_name 
where a.status = 'INVALID' 
and a.object_type = 'SYNONYM'
and a.owner = 'PUBLIC'
;


spool 'compile_now.sql';

;


select 'select dbms_metadata.get_ddl(''' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ''','''|| object_name || ''','''|| owner|| ''')'
from dba_objects
where status ='INVALID';


