How to Use AWR Reports to Diagnose Database Performance Issues (Doc ID 1359094.1)

Habilita ou desabilita o AWR.
CONTROL_MANAGEMENT_PACK_ACCESS

select instance, what from dba_jobs;

create tablespace "PERFSTAT" datafile '+ORADATA' size 5g;



Instalação
$ sqlplus / AS SYSDBA
SQL> @$ORACLE_HOME/rdbms/admin/spcreate.sql
Enter value for perfstat_password: Nerv2014
Enter value for default_tablespace: SYSAUX
Enter value for temporary_tablespace: TEMP

ob de Coleta de Snapshots
$ sqlplus PERFSTAT/Nerv2014
SQL> @$ORACLE_HOME/rdbms/admin/spauto.sql

Snapshots avulsos
$ sqlplus PERFSTAT/Nerv2014
SQL> EXECUTE STATSPACK.SNAP;

Extração do Relatório Statspack
$ sqlplus PERFSTAT/Nerv2014
SQL> @$ORACLE_HOME/rdbms/admin/spreport.sql
Enter value for begin_snap: 3
Enter value for end_snap: 4
Enter value for report_name: Teste01
$ vi Teste01.lst

Remoção de Snapshots
$ sqlplus PERFSTAT/Nerv2014
SQL> @$ORACLE_HOME/rdbms/admin/sppurge.sql
Enter value for losnapid: 3
Enter value for hisnapid: 4

Desinstalação
$ sqlplus / AS SYSDBA
SQL> @$ORACLE_HOME/rdbms/admin/spdrop.sql



Para o AWR esta funcionando deve estar o parametro CONTROL_MANAGEMENT_PACK_ACCESS com as informações abaixo, em NONE não gera.

DIAGNOSTIC
(AWR, ADDM, etc.)
DIAGNOSTIC+TUNING
(SQL Tuning Advisor, SQLAccess Advisor, etc)
DEFAULT



Snapshot avulso
$ sqlplus / AS SYSDBA
BEGIN
DBMS_WORKLOAD_REPOSITORY.CREATE_SNAPSHOT();
END;
/

Alteração de intervalo de coleta e retenção em minutos (60 dias)
$ sqlplus / AS SYSDBA
BEGIN
DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS
(retention => 43200,
Interval => 30,
topnsql => 100);
END;
/


Quando mudar de maquina, comparar antes e depois da migração do servidor.
Ou 
Antes de fazer um alteração drastica sistema.

Verica o snapshot na view abaixo
SQL> select snap_id from dba_hist_snapshot;

Criação de Baseline
$ sqlplus / AS SYSDBA
BEGIN
DBMS_WORKLOAD_REPOSITORY.CREATE_BASELINE (
start_snap_id => 25,
end_snap_id => 26,
baseline_name => 'Before Migration',
expiration => 365);
END;
/


Remoção de Baseline
$ sqlplus / AS SYSDBA
BEGIN
DBMS_WORKLOAD_REPOSITORY.DROP_BASELINE
(baseline_name => 'Before Migration',
cascade => FALSE);
END;
/

Para estudar fazer select em todas estas views.

Periodo de coleta, mostra todos os parametros do AWR.
DBA_HIST_WR_CONTROL

DBA_HIST_SNAPSHOT
DBA_HIST_DATABASE_INSTANCE

Mostra o os resizes de memoria do cache, se esta sofrendo pressão por outra area de memoria.
 
DBA_HIST_DB_CACHE_ADVICE
DBA_HIST_DYN_REMASTER_STATS
DBA_HIST_IOSTAT_DETAIL

Armazena os planos de execução.

DBA_HIST_SQL_PLAN

DBA_HIST_ACTIVE_SESS_HISTORY
V$ACTIVE_SESSION_HISTORY
DBA_HIST_DISPATCH
DBA_HIST_SHARED_SERVER_SUMMARY
DBA_HIST_BASELINE
DBA_HIST_BASELINE_DETAILS
DBA_HIST_BASELINE_TEMPLATE



@$ORACLE_HOME/rdbms/admin/awrrpt.sql
Enter value for report_type: html
Enter value for num_days: 1
Enter value for begin_snap: 40
Enter value for end_snap: 41
Enter value for report_name: AWR_01.html

AWR Report (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/awrrpti.sql

Oracle RAC AWR Report
@$ORACLE_HOME/rdbms/admin/awrgrpt.sql
Oracle RAC AWR Report (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/awrgrpti.sql

Compara periodos diferentes, compara dias diferentes tambem.
tira o periodo mais velho e depois operido mais novo
Quando for analisar o o wait event a coluna %dif deve ser analisada.

AWR Compare Periods Report (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/awrddrpi.sql
Oracle RAC AWR Compare Periods Report

@$ORACLE_HOME/rdbms/admin/awrgdrpt.sql
Oracle RAC AWR Compare Periods Report (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/awrgdrpi.sql


Gera o AWR por sql_id, gera plano de execução da query.

SQL Statement
@$ORACLE_HOME/rdbms/admin/awrsqrpt.sql
Enter value for report_type: html
Enter value for num_days: 1
Enter value for begin_snap: 40
Enter value for end_snap: 41
Enter value for sql_id: 062savj8zgzut
Enter value for report_name: AWR_SQL_01.html

Quando tem mais de uma instancia
SQL Statement (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/awrsqrpi.sql


Quando tem lentidão mais não sabe sobre o que e qual o horario , é mais efeicaz que o AWR.

Automatic Database Diagnostic Monitor (ADDM)
$ export NLS_LANG="BRAZILIAN PORTUGUESE_BRAZIL.WE8ISO8859P1"
SQL> SET PAGESIZE 1000
SQL> SET LINESIZE 300
SQL> @$ORACLE_HOME/rdbms/admin/addmrpt.sql
Enter value for begin_snap: 51
Enter value for end_snap: 52
Enter value for report_name: ADDM_01.txt

Quando quero olhar um perido pequeno, exemplo 15 muinutos para tras

Neste caso o problema aconteceu a 30 minutos atras e durou 10 minutos.
Bom para ver um lock ou uma query.
Verifica o Top Sessions

Active Session History Reports
@$ORACLE_HOME/rdbms/admin/ashrpt.sql
Enter value for report_type: html
Enter value for begin_time: -30
Enter value for duration: 10
Enter value for report_name: ASH_01.html
Oracle RAC Active Session History Reports
@$ORACLE_HOME/rdbms/admin/ashrpti.sql

Da a opção de analisar por id, conforme o id da tp session do procedimento anterior.

Active Session History Reports (Specific Database Instance)
@$ORACLE_HOME/rdbms/admin/ashrpti.sql
Enter value for report_type: html
Enter value for dbid: 1383175475
Enter value for inst_num: 1
Enter value for begin_time:
Enter value for begin_time: -30
Enter value for duration: 10
Enter value for slot_width: 30
Enter value for target_session_id:
Enter value for target_sql_id:
Enter value for target_wait_class:
Enter value for target_service_hash:
Enter value for target_module_name:
Enter value for target_action_name:
Enter value for target_client_id:
Enter value for target_plsql_entry:
Enter value for target_container:
Enter value for report_name: ASH_SID666_01.html

#############################

DB time acima do Elapse , tem problema no banco, caso contrario não tem problema.
 
Primeira coisa a anaisar é Time Model, fazer CPU menos (-) a wait que esta acima dele, será o valor de percentual de wait no banco, se a CPU estiver em primeiro, não existe wait, ai vai direto para qeurys de CPU. 
Depois Foreground Wait Events, relacionado a eventos do usuário
Depois Background Wait Events, relacionados a processos de background
Sempre ir para a sessão relacionada ao maior %DB time, exemplo db file sequential read posso usar o advisor de memoria e querys de SQL ordered by Gets. 

%DB time, analisar por esta coluna.
ROI é de acordo o percentual do %DB time dobreo dbtime do top do relatorio.

Analisar todas as querys
Shared poll muito alta
AlmeNtar shared server, esta muito alta.
Vericar querys que estão con execução igual a 0 e tempo muito alto
parametro force gera o bin com SYS.


cell single block physical read ---> db file sequential  ---> advisor de memoria e querys de SQL ordered by Gets ou SQL ordered by Physical Reads
cell multiblock physical read ---> db file scattered read --> sempre querys order SQL ordered by Physical Reads



