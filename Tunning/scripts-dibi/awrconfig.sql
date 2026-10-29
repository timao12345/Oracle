set linesize 200
col dbid format 99999999999999
col snap_interval format a30
col retention format a30
col topnsql format a10
col src_dbname format a30
select * from dba_hist_wr_control;

-- modificar o intervalod de geração para 15 minutos e retenção para 90
exec dbms_workload_repository.modify_snapshot_settings (interval => &intervalo_minutos, retention => &retencao_dias*(24*60));
Enter value for intervalo_minutos: 15
Enter value for retencao_dias: 90


-- modificar quantidade de SQL no TOP de cada sessão do relatório
exec dbms_workload_repository.modify_snapshot_settings (topnsql => 50);
