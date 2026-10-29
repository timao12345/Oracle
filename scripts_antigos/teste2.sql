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
l_base number;
l_instac VARCHAR2(10);
l_user VARCHAR2(10);
l_pass VARCHAR2(10);
begin
l_user := 'TECH4B';
l_pass := 'xpto#01';
l_base := 0;
l_instac := null;
while l_base < 3
loop
	if l_base =0
	then l_instac := 'ASDB';
	else
		IF l_base = 1
		then l_instac := 'ELMA04';
		else
			IF l_base = 2
			then l_instac := 'ELMA06';
			END IF;
		END IF;
	END IF;
execute immediate 'connect l_user/l_pass@l_instac';
select sysdate, upper(instance_name) 
into l_date, l_inst
from v$instance;
dbms_output.put_line('* Check Workflow Notification Mailer - Data:'||l_date||' - Workflow '||l_inst||' *');
dbms_output.put_line('...');
l_base := l_base+1;
end loop;
end;
/
set feedback on
set serveroutput off
prompt
