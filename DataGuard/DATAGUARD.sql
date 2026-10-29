--VERIFICA O STATUS DO BANCO

SET SQLBLANKLINES ON
SET COLSEP '|'
COL STARTUP_TIME     FOR A20
COL INSTANCE_NAME    FOR A15
COL HOST_NAME        FOR A10
COL SYSDATE          FOR A30
COL "NOME_SERVIDOR"  FOR A30
COL "BANCO_INICIADO" FOR A20
COL "DATA_E_HORA"    FOR A20
SET LINES 900 PAGES 500 TRIMS ON
SET TIME ON
SELECT DISTINCT INSTANCE_NAME NOME_BANCO, I.HOST_NAME NOME_SERVIDOR, TO_CHAR(STARTUP_TIME,'DD/MM/YYYY HH24:MI:SS') BANCO_INICIADO,
D.LOG_MODE, I.STATUS, I.LOGINS, D.OPEN_MODE, TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') DATA_E_HORA
FROM GV$INSTANCE I, GV$DATABASE D;


--AP�S
select database_role from v$database;



--RODAR NO SERVIDOR PRIMARIO PARA VALIDA��O DOS ARQUIVES ENVIADOS PARA O DR

col thread# for 9999999
col dest_id for 9999999
col destination for a15
col sequence for 999999999
col delay for 999999
select a.thread#,
       a.dest_id, a.destination, a.sequence, a.next_time,
       b.dest_id, b.destination, b.sequence, b.next_time,
       a.sequence - b.sequence delay
  from (select thread#, dest_id, 'LOCAL' destination, max(sequence#) sequence, max(next_time) next_time
          from v$archived_log join v$archive_dest using (dest_id)
         where applied = 'NO'
           and standby_dest = 'NO'
                                  and v$archive_dest.status <> 'INACTIVE' 
           and resetlogs_time = (select resetlogs_time from v$database)
         group by thread#, dest_id) a, 
       (select thread#, dest_id,
               upper (decode (regexp_instr (destination, '[(]INSTANCE_NAME[=][a-zA-Z|_]*',1), 0, destination,
                              substr (regexp_substr (destination, '[(]INSTANCE_NAME[=][a-zA-Z|_]*'),
                                      instr(regexp_substr (destination, '[(]INSTANCE_NAME[=][a-zA-Z|_]*'),'=')+1))) destination,
               max(sequence#) sequence, max(next_time) next_time
          from v$archived_log join v$archive_dest using (dest_id)
         where applied = 'YES'
           and standby_dest = 'YES'
                                  and v$archive_dest.status <> 'INACTIVE'
           and resetlogs_time = (select resetlogs_time from v$database)
         group by thread#, dest_id, destination) b
where a.thread# = b.thread#(+)
order by a.thread#, b.dest_id;


--AJUSTE DE DATA/HORA
alter session set nls_date_format='DD/MM/YY HH24:MI:SS';


--VERIFICA O ULTIMO ARCHIVE ARMAZENADO 
select thread#, max(sequence#) from v$archived_log group by thread#;



--VERIFICAR STATUS DA REPLICA��O  *SERVIDOR DE DR
select * from V$DATAGUARD_STATUS order by 7 desc;


--VERIFICA O STATUS DO APLICA��O DA REPLICA��O  *SERVIDOR DE DR
select thread#, sequence#, first_time, completion_time, applied from v$archived_log where first_time > sysdate -2 order by 2;

select thread#, sequence#, first_time, completion_time, applied from v$archived_log order by 2;


--VERIFICA A ULTIMA SEQUENCIA RECEBIDA E A ULTIMA SEQUENCIA APLICADA NO SERVIDOR DE DR

SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Ultima Sequencia Recebida", APPL.SEQUENCE# "Ultima Sequencia Aplicada", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Diferenca" FROM (SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH, (SELECT THREAD# ,SEQUENCE# FROM V$LOG_HISTORY WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL WHERE ARCH.THREAD# = APPL.THREAD# ORDER BY 1;



--VERIFICA O ULTIMO ARCHIVE GERADO NO SERVIDOR PRIMARIO

SELECT THREAD# "Thread",SEQUENCE# "Ultima Sequencia Gerada" FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) FROM V$ARCHIVED_LOG GROUP BY THREAD#) ORDER BY 1;



--GERA UMA NOVA SEQUENCIA DE ARCHIVE NO SERVIDOR PRIMARIO
alter system switch logfile;




--Desativar O Processo De Aplica��o De Archive No Servidor: Orafdboi578a
alter database recover managed standby database cancel;



--Ativar O Processo De Aplica��o De Archive No Servidor: Orafdboi578a
alter database recover managed standby database using current logfile disconnect;
--From <https://confluence.intranet.uol.com.br/confluence/pages/viewpage.action?pageId=49092939> 

