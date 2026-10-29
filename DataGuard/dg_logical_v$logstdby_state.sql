-- Verificar o status de execu��o do processo de replica��o:
set lines 300 pages 10000
 col state form a27
 col statedesc form a62
 select session_id, state,
         case STATE
           when 'INITIALIZING' then 'Sessão de logminer criada e inicio do COORDINATOR'
           when 'LOADING DICTIONARY' then 'SQL Apply carregando dicion�rio'
           when 'WAITING ON GAP'     then 'SQL Apply aguardando logs do primary'
           when 'APPLYING'            then 'SQL Apply fazendo o mining e aplicando transa��es'
           when 'WAITING FOR DICTIONARY LOGS' then 'SQL Apply aguardando recebimento de archives com os logminers'
           when 'IDLE'   then 'SQL Apply aplicou todas as mudanças recebidas'
           when 'SQL APPLY NOT ON'  then 'aplicação parada' end AS StateDesc  
     from v$logstdby_state;