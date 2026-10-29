clear columns
column first_time format 'DD-MM-AA'
column next_time format 'DD-MM-AA'
set lines 200 pages 100
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
select * from v$log;


-- Irei criar a trigger de sistema que irá capturar os erros gerados pela sessões
create or replace trigger trg_captura_erros
after servererror on database
declare
    sql_text ora_name_list_t;
    msg_erro     varchar2(4000) := null;
    stmt_erro    varchar2(4000) := null;
begin
    for depth in 1 .. ora_server_error_depth loop
    msg_erro := msg_erro || ora_server_error_msg(depth);
    end loop;

    for i in 1 .. ora_sql_txt(sql_text) loop
    stmt_erro := stmt_erro || sql_text(i);
    end loop;

insert into erros_sql values (sysdate,ora_login_user,msg_erro,stmt_erro);
end;

clear columns

col is_recovery_dest_file for a25
col member for a60
set lines 200 pages 100
select * from v$logfile;