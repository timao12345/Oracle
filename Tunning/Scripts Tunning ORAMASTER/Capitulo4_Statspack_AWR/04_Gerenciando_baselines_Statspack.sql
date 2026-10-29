-- criar baseline (snapshots nunca serao apagados por rotinas de purge):
declare
    v_num_snaps number;
begin
    v_num_snaps := statspack.make_baseline(&bsnapid, &esnapid);
end;
       
-- excluir baseline por range de data:
exec statspack.clear_baseline(to_date('xx/xx/xx xx:xx','dd/mm/yyyy hh24:mi'), to_date('xx/xx/xx xx:xx','dd/mm/yyyy hh24:mi'));
  
-- excluir baseline por snapshotid:
exec statspack.clear_baseline(&bsnapid, &esnapid);

