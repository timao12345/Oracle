-- verificar se coleta automatica de snapshots esta habilitada no PDB, valor deve ser igual a true:
show parameter awr_pdb_autoflush_enabled

-- conecte-se no pdb desejado e execute: 
alter system set awr_pdb_autoflush_enabled = true;

alter session set container = pdbxe;

-- ver periodo de retencao (coluna awr_snapshot_retention_period) no formato dia:hora:minuto do CDB ou versoes antes do 12cr2:
SELECT  con_id,
        EXTRACT(day from retention) || ':' || EXTRACT(hour from retention) || ':' || EXTRACT (minute from retention) awr_snapshot_retention_period,
        EXTRACT (day from snap_interval) *24*60+ EXTRACT (hour from snap_interval) *60+ EXTRACT (minute from snap_interval) awr_snapshot_interval
FROM    dba_hist_wr_control;

alter session set container = cdb$root;

-- ver periodo de retencao (coluna awr_snapshot_retention_period) no formato dia:hora:minuto do(s) PDB(s):
SELECT  con_id,
        EXTRACT(day from retention) || ':' || EXTRACT(hour from retention) || ':' || EXTRACT (minute from retention) awr_snapshot_retention_period,
        EXTRACT (day from snap_interval) *24*60+ EXTRACT (hour from snap_interval) *60+ EXTRACT (minute from snap_interval) awr_snapshot_interval
FROM    cdb_hist_wr_control;