execute dbms_stats.gather_system_stats();
execute dbms_stats.gather_system_stats('start');
execute dbms_stats.gather_system_stats('stop');
execute dbms_stats.gather_system_stats('interval', 90);

select pname, pval1 from sys.aux_stats$ where sname='SYSSTATS_MAIN';

DBMS_STATS.GATHER_DICTIONARY