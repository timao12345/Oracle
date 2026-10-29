-- ASH
Estrutura engloba: 
    top events, load profile, top sql, top pl/sql procedure, top java workload, top sessions, top objects/file/latches, Activity over time.
    é executado com o comando $ORACLE_HOME/rdbms/admin/ashrpt.sql ou dentro do BD @?/rdbms/admin/ashrpt.sql ou ashrpti.sql
    views: v$active_session_history, dba_hist_db_cache_advice, dba_hist_dispatcher, dba_hist_dyn_remaster_stats, dba_hist_iostat_detail, dba_hist_shared_server_summary.


-- SQL Statement processing phases  - fazes de execução de um codigo SQL

open                             close
  |                               /|\
 \|/                               |
parse --> bind --> execute -->   feth ]]
 /|\       /|\         |_________| | |
  |         |______________________| |
  |__________________________________|


 -- Parse --
É o processo quando fazemos uma consulta no BD aonde sempre que faça uma execução o parse é executado fazendo uma busca na SGA precisamente na library cache que fica dentro da shared pool, podendo ser um hard parse ou soft parse.
são 3 etapas: Verificação da Sintaxe, Semantica e Hash da consulta, As três tarefas mencionadas anteriormente são executadas todas as vezes, mesmo quando a consulta é executada na mesma sessão N vezes.
    hard parse - Quando a Verificação das 3 etapas do parse não correspondem, por exemplo quando um usuario executor nao tem acesso a uma tabela ou objeto, sintax errada ou hash inexistente na library cache. 
    soft parse - Se o valores das 3 etapas forem validados e existirem na Library Cache a declaração é considerada como já executada assim sendo considerada como Soft Parsed

Oracle usa a library cache e Shared SQL Area para guardar consultas e blocos PL/SQL 
quanto mais bind variables existirem tende a ser feito mais soft parse.
Quando as isntruções / SQLs são guardados in cache (library cache e Shared SQL Area) : 
    reduz a instrução ao valor numérico da tabela ASCll text, 
    Um cursor é setado para a instrução SQL .
o Hash value não é valor unico, diversas intruções SQL podem usar o mesmo hash, o contexto do cursor para esta instrução são todos guardados no mesmo hash chain.
Oracle checa a library cache para determinar se a mesma instrução teve mais de 3 requests de parse, se o cursor tiver fechado 3 vezes o BD assume que a sessão do cursor associado a instrução deve ser colocado
    em cache e movido o cursor para dentro da "session cursor cache".

Physical reads são leituras em disco, Logical reads são leituras nos blocos já existentes na database buffer cache.

-- buffer gets
É o nome dado ao processo em que o oracle pesquisa e acha um bloco de dados na buffer cache (mémoria), caso o bloco não for encontrado na buffer cache ele irá trazer o bloco do disco fisico para a buffer cache primeiro esse proceso se chamad "disk read".
"buffer get" is logical I/O enquanto "disk read" is physical I/O

-- SQL Access Advisor
Gera recomendação de adicionar ou dropar indices .

-- Trace
0 - No trace. Like switching sql_trace off.
2 - The equivalent of regular sql_trace.
4 - The same as 2, but with the addition of bind variable values.
8 - The same as 2, but with the addition of wait events.
12 - The same as 2, but with both bind variable values and wait events.

Comum e padrão usar nivel de coleta em 8, o nivel 12 também é utilizado porem devemos ter cuidado devido a conter dados das variaveis bind.