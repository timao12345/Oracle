set feedback off
set serveroutput on
set linesize 300
alter session set nls_date_format='dd/mm/yy:hh24:mi:ss';
declare
l_return number(10);
l_error  varchar2(200);
l_id number;
l_stats  varchar2(40);
l_date date;
l_inst varchar2(20);
begin
select sysdate, upper(instance_name) 
into l_date, l_inst
from v$instance;
dbms_output.put_line('* Check Workflow Notification Mailer - Data:'||l_date||' - Workflow '||l_inst||' *');
dbms_output.put_line('...');
select component_id, component_status
into l_id, l_stats
from FND_SVC_COMPONENTS
where COMPONENT_TYPE = 'WF_MAILER';
	if l_stats IN ('DEACTIVATED_SYSTEM', 'STOPPED_ERROR')
	then
	dbms_output.put_line('Status Atual: '||l_stats);
	dbms_output.put_line('Workflow Down!!! O Serviço será iniciado...');
	FND_SVC_COMPONENT.Start_Component(l_id,l_return, l_error);
	commit;
	if l_return <> 0
	then
	dbms_output.put_line(l_return);
	dbms_output.put_line(l_error);
	end if;
	select component_id, component_status
	into l_id, l_stats
	from FND_SVC_COMPONENTS
	where COMPONENT_TYPE = 'WF_MAILER';
	end if;
	if l_stats = 'STARTING'
	THEN
	dbms_output.put_line('...');
	dbms_output.put_line('--> Processo sendo Iniciado, execute novamente o script!');
	dbms_output.put_line('...');
	end if;
dbms_output.put_line('Status Workflow Mailer: '||l_stats);
end;
/
set feedback on
set serveroutput off
prompt
undef base
