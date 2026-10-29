4ymabqvkudz01

DECLARE RET_VAL VARCHAR2(4000);
BEGIN 
RET_VAL:=DBMS_SQLTUNE.CREATE_TUNING_TASK(SQL_ID=>'4ymabqvkudz01', SCOPE=>
DBMS_SQLTUNE.SCOPE_COMPREHENSIVE, TIME_LIMIT=>180, TASK_NAME=>'PERSONATA2_4ymabqvkudz01',
DESCRIPTION=>'PERSONATA2_4ymabqvkudz01');
END;
/

SET LONG 9000
BEGIN DBMS_SQLTUNE.EXECUTE_TUNING_TASK('PERSONATA2_4ymabqvkudz01'); 
END; 
/

SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('PERSONATA2_4ymabqvkudz01') RECOMMENDATION FROM DUAL;


SELECT 
a.name
--,b.comp_data
FROM dba_sql_profiles	a ,dbmshsxp_sql_profile_attr b
WHERE a.name = b.profile_name;


Shared Memory Manager � ASMM (Gerenciador Autom�tico de Mem�ria Compartilhada). Este recurso faz com que o Oracle realize ajustes de acordo com o �workload� (carga de trabalho) do banco de dadossele


execute dbms_sqltune.create_sql_plan_baseline(task_name => 'PERSONATA2_4ymabqvkudz01', owner_name => 'SYS', plan_hash_value => 4082864796);

