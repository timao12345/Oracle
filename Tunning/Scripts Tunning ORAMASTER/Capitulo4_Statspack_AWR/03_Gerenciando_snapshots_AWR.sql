-- consultar snapshots no cdb ou versoes antes do 12cr2:
SELECT    CON_ID, snap_id, begin_interval_time, end_interval_time 
FROM      dba_hist_snapshot 
ORDER BY  2;

-- consultar snapshots no(s) pdb(s):
SELECT    snap_id, begin_interval_time, end_interval_time 
FROM      awr_pdb_snapshot 
ORDER BY  1;

-- criar snapshots:
EXEC dbms_workload_repository.create_snapshot;

-- APAGAR SNAPSHOTS:
exec dbms_workload_repository.drop_snapshot_range(x,y);

-- consulta snapshots filtrando por dias
SELECT    snap_id, begin_interval_time, end_interval_time 
FROM      dba_hist_snapshot where BEGIN_INTERVAL_TIME > sysdate-2
ORDER BY  2;

122316 122505