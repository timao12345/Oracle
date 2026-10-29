col TABLE_NAME for a65
set lines 750 pages 5000
select table_name,total_phys_io
    from ( select owner||'.'||object_name as table_name,
                  sum(value) as total_phys_io
           from   v$segment_statistics
           where  owner!='SYS' and object_type='TABLE'
     and  statistic_name in ('physical reads','physical reads direct',
                           'physical writes','physical writes direct')
           group by owner||'.'||object_name
           order by total_phys_io desc)
  where rownum <=20;
  

TABLE_NAME                                                        TOTAL_PHYS_IO
----------------------------------------------------------------- -------------
RMS.AA3CTBRG                                                           21357653
RMS.AG1IENSA                                                            8764086
RMS.AA3MESTQ                                                            8690295
RMS.AG2TRBIT                                                            6220242
RMS.AA1CFISC                                                            6082421
RMS.AA2MESTQ                                                            5306983
RMS.CAD_LGPD_LOG                                                        4007541
RMS.AG3VNFCI_202203                                                     3504075
RMS.CAPCUPOM                                                            3328229
RMS.AGG_VDA_PROD_MES                                                    2093621
RMS.AA3CLPRC                                                            1815272
RMS.AG1PDVCC                                                            1805733
RMS.AA2CESTQ                                                            1690373
RMS.AG1PAGCP                                                            1545960
RMS.AGG_MVTO_PROD_MES                                                   1454559
RMS.AG1PDVCI                                                             747701
RMS.AA1DITEM                                                             680637
RMS.AG2VMCOF                                                             655230
RMS.AGG_ESTQ_PROD                                                        631692
RMS.AG3VNFCI_202202                                                      541775