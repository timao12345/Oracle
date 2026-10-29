select table_name,total_phys_io
    from ( select owner||'.'||object_name as table_name,
                  sum(value) as total_phys_io
           from   v$segment_statistics
           where  owner!='SYS' and object_type='TABLE'
     and  statistic_name in ('physical reads','physical reads direct',
                           'physical writes','physical writes direct')
           group by owner||'.'||object_name
           order by total_phys_io desc)
  where rownum <=10