Vinicius,

Como quando utiliza SQL Developer, cai no grupo de resource manager de desenvolvedor, o que impossibilita análise, pode-se mudar “on the fly” alterando sua sessão que utiliza SQL Developer para o grupo sys-group.

Segue:

1.       
select sid, serial#, inst_id, username, machine, program, RESOURCE_CONSUMER_GROUP from gv$session where username = 'UOL_VCALIXTO';

2.       
BEGIN
                DBMS_RESOURCE_MANAGER.SWITCH_CONSUMER_GROUP_FOR_SESS ('&sid', '&serial', 'SYS_GROUP');
END;
/
