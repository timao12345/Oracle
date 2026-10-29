select 'grant select on TEKNISA.'||table_name||' to MATHEUS_GOES;' from dba_tables where owner = 'TEKNISA';



select 'grant select on TEKNISA.'||object_name||' to MATHEUS_GOES;' from dba_objects where owner = 'MM_ODS' and object_type='VIEW';


