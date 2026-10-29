-- vendo o uso do AWR:
SELECT  name,
        detected_usages,
        currently_used,
        TO_CHAR(last_sample_date,'DD-MM-YYYY:HH24:MI') last_sample
FROM    dba_feature_usage_statistics
WHERE   name = 'AWR Report' ;

-- executar no sqlplus os scripts abaixo, fornecendo os valores de entrada solicitados: 
-- 		tipo de relatorio (texto ou html), qtde de dias p/ escolher snapshots, snapshots inicial e final e nome do relatorio

-- AWR Report
	SQL > @?/rdbms/admin/awrrpt.sql
	-- ou (substituir xxx pelo id do bd q consta na v$database ou v$pdb, bid e eid pelo snapshot inicial e final)
	SQL >   SELECT  dbms_workload_repository.awr_report_text(l_dbid=>xxx,l_inst_num=>1,l_bid=>y,l_eid=>z) 
			FROM dual;
	
	
-- AWR RAC Report (inclui dados de todas as instancias do RAC):
	SQL > @?/rdbms/admin/awrgrpt.sql
	

-- AWR Compare Report (compara somente periodos iguais):
-- Obs.: Informe primeiro os snapshots correspondentes ao baseline
	SQL > @?/rdbms/admin/awrddrpt.sql
    
    
-- Dica: para efetuar comparacao com um baseline, recupere os snapshots IDs dele.    