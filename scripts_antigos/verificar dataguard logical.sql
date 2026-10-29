/* 

ALTER DATABASE STOP LOGICAL STANDBY APPLY;

ALTER DATABASE START LOGICAL STANDBY APPLY;


ALTER DATABASE START LOGICAL STANDBY APPLY IMMEDIATE;

*/
--Verifica o gap entre o archive recebido e o aplicado
SELECT ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Ultima Sequencia Recebida", APPL.SEQUENCE# "Ultima Sequencia Aplicada", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Diferenca" 
FROM (SELECT THREAD# ,SEQUENCE# FROM V$ARCHIVED_LOG WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
      FROM V$ARCHIVED_LOG GROUP BY THREAD#)) ARCH, (SELECT THREAD# ,SEQUENCE# 
                                                    FROM V$LOG_HISTORY 
                                                    WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
                                                                                                      FROM V$LOG_HISTORY GROUP BY THREAD#)) APPL 
                                                                                                      WHERE ARCH.THREAD# = APPL.THREAD# ORDER BY 1;
-- // -- 
SELECT EVENT_TIME, STATUS, EVENT
FROM DBA_LOGSTDBY_EVENTS
where EVENT_TIME > sysdate -1
ORDER BY EVENT_TIMESTAMP, COMMIT_SCN, CURRENT_SCN;

set lines 300 pages 100 numw 15 timi on echo on
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
col state form a27
col statedesc form a62
select session_id, state,
    case STATE
        when 'INITIALIZING' then 'Sessão de logminer criada e inicio do COORDINATOR'
        when 'LOADING DICTIONARY' then 'SQL Apply carregando dicionário'
        when 'WAITING ON GAP'     then 'SQL Apply aguardando logs do primary'
        when 'APPLYING'            then 'SQL Apply fazendo o mining e aplicando transações'
        when 'WAITING FOR DICTIONARY LOGS' then 'SQL Apply aguardando recebimento de archives com os logminers'
        when 'IDLE'   then 'SQL Apply aplicou todas as mudanças recebidas'
        when 'SQL APPLY NOT ON'  then 'aplicacao parada' end AS StateDesc
from v$logstdby_state;

col serial# for 99999999
col logstdby_id for
col status for a70
col pid for 99999
col type for a15
col status_code for 99999999999
select * from v$logstdby;

SELECT APPLIED_SCN as "SCN APLICADO", APPLIED_TIME as "DATA APLICADA", LATEST_SCN as "PROXIMO SCN SER APLICADO" FROM V$LOGSTDBY_PROGRESS;

col file_name for a80
col seq# for 999999
col thr# for 9999
SELECT FILE_NAME, SEQUENCE# AS SEQ#, FIRST_CHANGE# AS FCHANGE#, NEXT_CHANGE# AS NCHANGE#, TIMESTAMP,THREAD# AS THR#,APPLIED
FROM DBA_LOGSTDBY_LOG
ORDER BY SEQUENCE#;

COLUMN STATUS FORMAT A50
COLUMN EVENT_TIME FORMAT A25
COLUMN EVENT FORMAT A70
col xidusn for 9999999
col xidsqn for 9999999999
col xidslt for 9999999
SELECT EVENT_TIME, STATUS, EVENT,XIDUSN,XIDSLT,XIDSQN
FROM DBA_LOGSTDBY_EVENTS
WHERE EVENT_TIME>SYSDATE-1
ORDER BY EVENT_TIMESTAMP, COMMIT_SCN, CURRENT_SCN;


set lines 180 pages 10000
col message form a80
select to_char(TIMESTAMP,'dd/mm/yyyy-hh24:mi') "DATE", MESSAGE 
from V$DATAGUARD_STATUS where TIMESTAMP>sysdate-1/12;

-- Ultimo caso 
-- Ler documentação https://docs.oracle.com/cd/B12037_01/server.101/b10823/manage_ls.htm

--Example Skipping a Table in a Logical Standby Database

-- Parar a replicação.
    ALTER DATABASE STOP LOGICAL STANDBY APPLY;

    EXECUTE DBMS_LOGSTDBY.SKIP('Tipo de Operação', 'Schema', 'objeto', NULL);
    EXECUTE DBMS_LOGSTDBY.SKIP('DML', 'ODB', 'CMP4$15929', NULL);

--Voltar replicação.
    ALTER DATABASE START LOGICAL STANDBY APPLY;



execute dbms_logstdby.skip(	stmt => 'dml', schema_name => 'odb', object_name => 'CMP4$15627');