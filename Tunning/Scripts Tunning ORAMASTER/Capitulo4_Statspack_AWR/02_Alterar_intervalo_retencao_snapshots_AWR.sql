-- Conectado no CDB$ROOT OU EM UM PDB EXECUTE os sqls abaixo
alter session set container = pdbxe;

-- MODIFICAR RETENCAO E INTERVALO (PARAMETROS EM MINUTOS) P/ 30 DIAS E 30 MINUTOS  (cdb e pdb podem ter configuracoes diferentes)
exec DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(retention=>43200, interval=>30);

-- MODIFICAR QTDE TOP SQLs a serem analisados:
exec DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(topnsql => 100);

-- alterar PARA RETENCAO ILIMITADA:     
exec DBMS_WORKLOAD_REPOSITORY.MODIFY_SNAPSHOT_SETTINGS(retention=>0);
     
-- RETENCAO RECOMENDADA: 30 OU 45 DIAS

-- ver espaco utilizado pelo AWR no tablespace SYSAUX (para decidir melhor qual a retencao apropriada):
select      OCCUPANT_NAME , OCCUPANT_DESC, SCHEMA_NAME, 
            MOVE_PROCEDURE, MOVE_PROCEDURE_DESC, 
            space_usage_kbytes / 1024 as space_usage_mb 
from        V$SYSAUX_OCCUPANTS 
where       occupant_name = 'SM/AWR'
order by    space_usage_mb desc;