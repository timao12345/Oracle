/*Oracle Flashback Database
Procedimento (passo-a-passo)
Essa feature é utilizada como alternativa rápida à um recover incompleto.*/

--1 - Como habilitar o Flashback Database na base de dados:

--Conectar como SYSDBA no SQL*Plus
> conn / as sysdba

--Verificar se a base de dados está em ARCHIVELOG MODE
select log_mode from v$database;

--Habilitar ARCHIVELOG MODE na base de dados se não estiver ativado
shutdown immediate;

startup mount;

alter database archivelog;

alter database open;

--Habilitar o Flashback Database na base de dados
alter database flashback on;

/*A retenção padrão dos logs de flashback é de 24 horas e pode ser configurada através do parâmetro db_flashback_retention_target*/

/*2 - Realizar Flashback Database até um ponto no passado*/
--Conectar como SYSDBA no SQL*Plus
conn / as sysdba

--Verificar a data mais distante até onde é possível retroceder a base de dados
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
col oldest_flashback_scn for 9999999999999999999999;
select oldest_flashback_scn, oldest_flashback_time from v$flashback_database_log;

--Realizar o Flashback Database até a data escolhida
shutdown immediate;

startup mount exclusive;

flashback database to timestamp to_timestamp('2016-07-13 11:00:00','yyyy-mm-dd hh24:mi:ss');

--A data/hora deve ser alterada de acordo com a necessidade

--É possível acompanhar o processo de Flashback Database através da view v$session_longops em outra sessão na base de dados
select sid, serial#, message from v$session_longops where sofar <> totalwork;

select log#, thread#, sequence#, bytes, type, first_time from v$flashback_database_logfile;
--Após o fim do processo de Flashback Database, deve abrir a base de dados com resetlogs
alter database open resetlogs;