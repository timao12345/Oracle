-- Procedimento para habilitar trace na sessão

-- 1. Através do SQL PLUS, conectar-se ao Oracle com usuário e senha de DBA;

-- 2. Executar o seguinte SELECT para identificar a sessão corrente:

SELECT SID, SERIAL#, MACHINE, PROGRAM FROM V$SESSION;

set lines 220
SELECT SID, SERIAL#, MACHINE, PROGRAM
FROM GV$SESSION
WHERE AUDSID = Sys_Context('USERENV', 'SESSIONID')
   AND SID = Sys_Context('USERENV', 'SID');
   
-- 3. Com o resultado do select anterior, identificar o SID e SERIAL da sessão correspondente.

-- 4. Executar o seguinte comando:
EXEC DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION(&SID,&SERIAL,TRUE);

-- 5. Rodar dentro do módulo a rotina com problemas de performance.

-- 6. Rodar o seguinte SELECT para verificar o diretório e o trace gerado

SELECT S.USERNAME,
       S.AUDSID,
       S.SID,
       S.SERIAL#,
       PA.VALUE || chr(47) || (SYS_CONTEXT('USERENV', 'INSTANCE_NAME')) ||
       '_ora_' || P.SPID || '.trc' AS TRACE_FILE
  FROM V$SESSION S, V$PROCESS P, V$PARAMETER PA
 WHERE S.PADDR = P.ADDR
   AND UPPER(PA.NAME) = 'USER_DUMP_DEST'
   AND S.SID = '&sid'
   AND S.SERIAL# = '&serial';

-- 7. Ao término da execução da rotina, executar o seguinte comando:
EXEC DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION(&SID,&SERIAL,FALSE);

/* 8. Com o resultado do select, procurar no servidor, o local indicado pelo select.
Obs.: %ORACLE_HOME% equivale ao diretório no servidor onde o Oracle foi instalado (Ex.: c:\orant ).*/

-- 9. No prompt do DOS, executar o seguinte comando:

TKPROF <nome do arquivo gerado pelo trace> <arquivo> EXPLAIN=<usuário>/<senha>@<banco>

/*Onde:
Arquivo = nome do arquivo gerado pelo processo de TRACE (você deve definir um nome significativo)
Usuário = usuário com acesso de DBA
Senha = senha conexão deste usuário no banco do MASTERSAF
*/
