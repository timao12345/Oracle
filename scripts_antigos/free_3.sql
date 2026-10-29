--
-- Consulta espaço livre nos tablespaces
--
-- Metricas observadas:
--       +-------------------------------------------------------------------+
--       | Category         Size (mb)         Critical     Major      Minor  |
--       +----------+-----------------------+----------+----------+----------+
--       | petty    | 0.000.000 - 0.000.999 |  >= 50%  |  >= 40%  |  >= 25%  |
--       | small    | 0.001.000 - 0.049.999 |  >= 92%  |  >= 88%  |  >= 84%  |
--       | medium   | 0.050.000 - 0.249.999 |  >= 94%  |  >= 91%  |  >= 88%  |
--       | large    | 0.250.000 - 0.749.999 |  >= 96%  |  >= 93%  |  >= 92%  |
--       | huge     | 0.750.000 - x.xxx.xxx |  >= 98%  |  >= 96%  |  >= 94%  |
--       +----------+-----------------------+----------+----------+----------+
--
-- historico de versoes
-- 2014.06.10  Script desevolvido por Romolo Alves
--
set linesize 200 pagesize 4000
column pct_used_graf format a23
column used  format a7
column crit  format a4
column major format a5
column minor format a5
column chk   format a3
compute sum of mbused on report
compute sum of mballoc on report
compute sum of mballocfree on report
compute sum of mbmax on report
compute sum of mbfree on report
compute sum of mbtotal on report
break on report
select f.tbs_name                          tablespace_name  
     , f.autext                            aex
     , to_number(f.mb_used)                mbused
     , to_number(f.mb_alloc)               mballoc
     , to_number(f.mb_alloc_free)          mballocfree
     , to_number(f.mb_max)                 mbmax
     , to_number(f.mb_free)                mbfree
     , to_number(f.mb_tot)                 mbtotal
     , f.category                          category
     , to_char(f.pct_used,'00D00')||'%'    used
     , to_char(
        decode(f.severity
              , 'critical', f.threshold_critical
              , ' major  ', f.threshold_major
              , '  minor ', f.threshold_minor
              , '   clear', f.threshold_minor
              )
       )||'%'
       chk
     , f.severity                          severity
     , '['||decode( round( f.mb_used / f.mb_tot * 100, 2)
                  , 0 ,'XXXXXXXXXXXXXXXXXXXX'
                  , nvl(rpad(lpad('X',TRUNC(round( f.mb_used / f.mb_tot * 100, 2)/5),'X'),20,'-')
                       ,'--------------------'
                       )
                  )||']' pct_used_graf
     , to_char(f.threshold_critical)||'%'  crit
     , to_char(f.threshold_major)||'%'     major
     , to_char(f.threshold_minor)||'%'     minor
  from ( select e.*
              , decode( e.pct_used
                   , 0, '   clear'
                   , decode ( trunc(e.threshold_critical / e.pct_used) , 0               , 'critical'
                            , decode ( trunc(e.threshold_major / e.pct_used) , 0         , ' major  '
                                     , decode ( trunc(e.threshold_minor / e.pct_used) , 0, '  minor '
                                                                                         , '   clear'
                                              )
                                     )
                            )
                   )
                 severity
         from ( select c.*
                 , decode( c.category
                         , 'petty' , d.p_critical
                         , 'small' , d.s_critical
                         , 'medium', d.m_critical
                         , 'large' , d.l_critical
                         , 'huge'  , d.h_critical
                         ) threshold_critical
                 , decode( c.category
                         , 'petty' , d.p_major
                         , 'small' , d.s_major
                         , 'medium', d.m_major
                         , 'large' , d.l_major
                         , 'huge'  , d.h_major
                         ) threshold_major
                 , decode( c.category
                         , 'petty' , d.p_minor
                         , 'small' , d.s_minor
                         , 'medium', d.m_minor
                         , 'large' , d.l_minor
                         , 'huge'  , d.h_minor
                         ) threshold_minor
              from ( select a.tbs_name
                            , a.mb_alloc - b.mb_free mb_used
                            , a.mb_alloc
                            , b.mb_free mb_alloc_free
                            , ( b.mb_free + ( a.mb_max - a.mb_alloc ) ) mb_free
                            , a.autext
                            , a.mb_max
                            , a.mb_tot
                            , round(( a.mb_alloc - b.mb_free ) / a.mb_tot * 100, 2) 
                              pct_used
                            , decode( trunc( a.mb_tot / 1000 )
                                      , 0, 'petty'
                                      , decode( trunc( a.mb_tot / 50000 )
                                              , 0, 'small'
                                              , decode( trunc( a.mb_tot / 250000 )
                                                      , 0, 'medium'
                                                      , decode( trunc( a.mb_tot / 750000 )
                                                              , 0, 'large'
                                                              , 'huge'
                                                              )
                                                      )
                                              )
                                    )
                              category
                         from ( select tablespace_name tbs_name
                                     , max(autoextensible) autext
                                     , sum(mb_max) mb_max
                                     , sum(mb_alloc) mb_alloc
                                     , decode( trunc(sum(mb_max) / sum(mb_alloc)) 
                                             , 0, sum(mb_alloc)
                                             , sum(mb_max)
                                             ) mb_tot
                                  from ( select tablespace_name
                                              , autoextensible
                                              , bytes/1024/1024 mb_alloc
                                              , decode( autoextensible
                                                      , 'YES', maxbytes
                                                      , bytes
                                                      ) /1024/1024 mb_max
                                           from ( select tablespace_name, bytes, maxbytes, autoextensible from dba_data_files
                                                  union all 
                                                  select tablespace_name, bytes, maxbytes, autoextensible from dba_temp_files
                                                )
                                       )
                                  group by tablespace_name
                              )
                              a
                              inner join
                              ( select tablespace_name tbs_name
                                     , sum(bytes)/1024/1024 mb_free
                                  from dba_free_space
                                 group by tablespace_name
                              ) 
                              b
                              on a.tbs_name = b.tbs_name
                   ) c
                 , ( select 50 p_critical , 40 p_major , 25 p_minor
                          , 92 s_critical , 88 s_major , 84 s_minor
                          , 94 m_critical , 91 m_major , 88 m_minor
                          , 96 l_critical , 93 l_major , 92 l_minor
                          , 98 h_critical , 96 h_major , 94 h_minor
                     from dual
                   ) d
          ) e
       ) f
 order by severity, pct_used desc;