ACCEPT data PROMPT 'Horario de execu�ao da RDM. Por favor, usar formato HH:MI:SS';
PROMPT
 
select 'ALTER ' || decode(object_type,'PACKAGE BODY','PACKAGE',object_type) || ' ' ||
    owner || '.' || object_name || decode(object_type,'PACKAGE BODY',' COMPILE BODY;',' COMPILE;') COMANDO
    from dba_objects
      where status like 'INVALID'
      and last_ddl_time > TO_DATE(TO_CHAR(sysdate,'DD/MM/YYYY') || ' '|| ' &data.','DD/MM/YYYY HH:MI:SS');i