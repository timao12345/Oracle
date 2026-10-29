-- execute o script @?/rdbms/admin/addmrpt.sql
	@?/rdbms/admin/addmrpt.sql

-- ou

-- execute a package DBMS_ADDM (a partir do Oracle Database 11g R2) 
SET SERVEROUTPUT ON
DECLARE
	task_name varchar2(30);
BEGIN
	DBMS_ADDM.ANALYZE_DB(task_name, &snapid_inicio, &snapid_fim);  -- INFORMAR snapshots id inicio e fim
	DBMS_OUTPUT.PUT_LINE(task_name);
END;

SELECT DBMS_ADDM.GET_REPORT('&TAREFA') FROM DUAL;

addmrpt_1_72508_72520.txt