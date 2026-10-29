-- executar no sqlplus o script $ORACLE_HOME/rdbms/admin/ashrpt.sql:
	SQL > @?/rdbms/admin/ashrpt.sql

-- verificar dados mais antigos no ASH no cdb ou versoes anteriores ao 12cR2:
	SELECT min(sample_time) FROM dba_hist_active_sess_history;
	
-- verificar dados mais antigos no ASH no(s) pdb(s):
	SELECT min(sample_time) FROM awr_pdb_active_sess_history;