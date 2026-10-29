-- Diferença dos archives aplicados

SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Ultima Sequencia Recebida", APPL.SEQUENCE# "Ultima Sequencia Aplicada", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Diferenca" 
FROM (SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
      FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH, (SELECT THREAD# ,SEQUENCE# 
                                                    FROM V$LOG_HISTORY 
                                                    WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
                                                                                                      FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL 
                                                                                                      WHERE ARCH.THREAD# = APPL.THREAD# ORDER BY 1;

col STATUS for a50
SELECT EVENT_TIME, STATUS, EVENT
FROM DBA_LOGSTDBY_EVENTS
where EVENT_TIME > sysdate -1
ORDER BY EVENT_TIMESTAMP, COMMIT_SCN, CURRENT_SCN;


set lines 300 pages 10000
 col state form a27
 col statedesc form a62
 select session_id, state,
         case STATE
           when 'INITIALIZING' then 'Sessão de logminer criada e inicio do COORDINATOR'
           when 'LOADING DICTIONARY' then 'SQL Apply carregando dicionário'
           when 'WAITING ON GAP'     then 'SQL Apply aguardando logs do primary'
           when 'APPLYING'            then 'SQL Apply fazendo o mining e aplicando transações'
           when 'WAITING FOR DICTIONARY LOGS' then 'SQL Apply aguardando recebimento de archives com os logminers'
           when 'IDLE'   then 'SQL Apply aplicou todas as mudancas recebidas'
           when 'SQL APPLY NOT ON'  then 'aplicaçãoo parada' end AS StateDesc  
     from v$logstdby_state;

-- Verificar a data aplicada no banco atrav�s do SCN
-- Executar Standby database 
col "PROXIMO SCN SER APLICADO" for 99999999999999999999999
col "SCN APLICADO" for 99999999999999999999999
Alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
SELECT APPLIED_SCN as "SCN APLICADO", APPLIED_TIME as "DATA APLICADA", LATEST_SCN as "PROXIMO SCN SER APLICADO" FROM V$LOGSTDBY_PROGRESS;

--Executar database primário

select to_char(scn_to_timestamp('&SCN_DO_STANDBY'),'DD/MM/YYYY HH24:MI:SS') from dual;
Enter value for scn_do_standby: 628853656


--Verificar posição onde encontra-se a ultima sequência

col FILE_NAME for a80
SELECT FILE_NAME, SEQUENCE# AS SEQ#, FIRST_CHANGE# AS FCHANGE#, NEXT_CHANGE# AS NCHANGE#, TIMESTAMP,THREAD# AS THR#,APPLIED
FROM DBA_LOGSTDBY_LOG
ORDER BY SEQUENCE#;

-- verifica serviço
set lines 220
set pages 50000
col status for a10
SELECT PROCESS,
STATUS,
THREAD#,
SEQUENCE#,
BLOCK#,
BLOCKS
FROM V$MANAGED_STANDBY;

-- Verificar erros

set lines 180 pages 10000
col message form a80
select to_char(TIMESTAMP,'dd/mm/yyyy-hh24:mi') "DATE", MESSAGE 
from V$DATAGUARD_STATUS where TIMESTAMP>sysdate-1/12;


--AJUSTE DE DATA/HORA
alter session set nls_date_format='DD/MM/YY HH24:MI:SS';
--VERIFICA O ULTIMO ARCHIVE ARMAZENADO 
select thread#, max(sequence#) from v$archived_log group by thread#;


--VERIFICA O STATUS DO APLICA��O DA REPLICA��O  *SERVIDOR DE DR
select thread#, sequence#, first_time, completion_time, applied from v$archived_log where first_time > sysdate -2 order by 2;

ALTER DATABASE START LOGICAL STANDBY APPLY  IMMEDIATE;


