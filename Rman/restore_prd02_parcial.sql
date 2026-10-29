### Restore teste na máquina de dr

### Colocar a máquina em outage no UIM

### Reduzir a sga da prd021 de 80gb para 2gb
### Reduzir a sga da prd011 de 40gb para 4gb
### Foram criados pfiles no /home/oracle, parar as instancias e inicializar fora do cluster com o pfile temporário
startup nomount pfile='/home/oracle/prd021_temp.ora'

startup nomount pfile='/home/oracle/prd011_temp.ora'

###


ALTER DATABASE MOUNT STANDBY DATABASE;
alter database recover managed standby database using current logfile disconnect;

	--primary
	alter system set log_archive_dest_state_2 = defer scope = memory sid='*';
	alter system set log_archive_dest_state_2 = enable scope = memory sid='*';

	
### Iniciando o restore após liberar 100gb de ram no servidor brcsfpora05


### Criar o dg de restore
CREATE DISKGROUP DG_RESTORE EXTERNAL REDUNDANCY DISK '/dev/rhdiskrac0507_58';
alter diskgroup DG_RESTORE add disk '/dev/rhdiskrac0507_59','/dev/rhdiskrac0507_60','/dev/rhdiskrac0507_61','/dev/rhdiskrac0507_62','/dev/rhdiskrac0507_63','/dev/rhdiskrac0507_64','/dev/rhdiskrac0507_65','/dev/rhdiskrac0507_66','/dev/rhdiskrac0507_67','/dev/rhdiskrac0507_68';


### Logar no asm e criar os diretórios
asmcmd -p
+ASM1
asmcmd -p
cd dg_restore
mkdir restore/controlfile 


### criar um init básico para subir a instancia
create pfile='/home/oracle/initprd02.ora' from memory;

### 
*.__db_cache_size=78G
*.__large_pool_size=512M
*.__oracle_base='/u01/app/oracle' # ORACLE_BASE set from environment
*.__pga_aggregate_target=8G
*.__sga_target=60G
*.__shared_io_pool_size=0
*.__streams_pool_size=4G
*._aggregation_optimization_settings=0
*._always_anti_join='CHOOSE'
*._always_semi_join='CHOOSE'
*._and_pruning_enabled=TRUE
*._b_tree_bitmap_plans=TRUE
*._bloom_filter_enabled=TRUE
*._bloom_folding_enabled=TRUE
*._bloom_pruning_enabled=TRUE
*._complex_view_merging=TRUE
*._compression_compatibility='11.2.0.3.0'
*._connect_by_use_union_all='TRUE'
*._convert_set_to_join=FALSE
*._cost_equality_semi_join=TRUE
*._cpu_to_io=0
*._dimension_skip_null=TRUE
*._eliminate_common_subexpr=TRUE
*._enable_type_dep_selectivity=TRUE
*._fast_full_scan_enabled=TRUE
*._first_k_rows_dynamic_proration=TRUE
*._gby_hash_aggregation_enabled=TRUE
*._generalized_pruning_enabled=TRUE
*._globalindex_pnum_filter_enabled=TRUE
*._gs_anti_semi_join_allowed=TRUE
*._improved_outerjoin_card=TRUE
*._improved_row_length_enabled=TRUE
*._index_join_enabled=TRUE
*._ksb_restart_policy_times='0'
*._ksb_restart_policy_times='60'
*._ksb_restart_policy_times='120'
*._ksb_restart_policy_times='240' # internal update to set default
*._ktb_debug_flags=8
*._left_nested_loops_random=TRUE
*._local_communication_costing_enabled=TRUE
*._minimal_stats_aggregation=TRUE
*._mmv_query_rewrite_enabled=TRUE
*._new_initial_join_orders=TRUE
*._new_sort_cost_estimate=TRUE
*._nlj_batching_enabled=1
*._optim_adjust_for_part_skews=TRUE
*._optim_enhance_nnull_detection=TRUE
*._optim_new_default_join_sel=TRUE
*._optim_peek_user_binds=TRUE
*._optimizer_adaptive_cursor_sharing=TRUE
*._optimizer_better_inlist_costing='ALL'
*._optimizer_cbqt_no_size_restriction=TRUE
*._optimizer_coalesce_subqueries=TRUE
*._optimizer_complex_pred_selectivity=TRUE
*._optimizer_compute_index_stats=TRUE
*._optimizer_connect_by_combine_sw=TRUE
*._optimizer_connect_by_cost_based=TRUE
*._optimizer_connect_by_elim_dups=TRUE
*._optimizer_correct_sq_selectivity=TRUE
*._optimizer_cost_based_transformation='LINEAR'
*._optimizer_cost_hjsmj_multimatch=TRUE
*._optimizer_cost_model='cpu'
*._optimizer_dim_subq_join_sel=TRUE
*._optimizer_distinct_agg_transform=TRUE
*._optimizer_distinct_elimination=TRUE
*._optimizer_distinct_placement=TRUE
*._optimizer_eliminate_filtering_join=TRUE
*._optimizer_enable_density_improvements=TRUE
*._optimizer_enable_extended_stats=TRUE
*._optimizer_enable_table_lookup_by_nl=TRUE
*._optimizer_enhanced_filter_push=TRUE
*._optimizer_extend_jppd_view_types=TRUE
*._optimizer_extended_cursor_sharing='UDO'
*._optimizer_extended_cursor_sharing_rel='SIMPLE'
*._optimizer_extended_stats_usage_control=192
*._optimizer_false_filter_pred_pullup=TRUE
*._optimizer_fast_access_pred_analysis=TRUE
*._optimizer_fast_pred_transitivity=TRUE
*._optimizer_filter_pred_pullup=TRUE
*._optimizer_fkr_index_cost_bias=10
*._optimizer_full_outer_join_to_outer=TRUE
*._optimizer_group_by_placement=TRUE
*._optimizer_improve_selectivity=TRUE
*._optimizer_interleave_jppd=TRUE
*._optimizer_join_elimination_enabled=TRUE
*._optimizer_join_factorization=TRUE
*._optimizer_join_order_control=3
*._optimizer_join_sel_sanity_check=TRUE
*._optimizer_max_permutations=2000
*._optimizer_mode_force=TRUE
*._optimizer_multi_level_push_pred=TRUE
*._optimizer_native_full_outer_join='FORCE'
*._optimizer_new_join_card_computation=TRUE
*._optimizer_null_aware_antijoin=TRUE
*._optimizer_or_expansion='DEPTH'
*._optimizer_order_by_elimination_enabled=TRUE
*._optimizer_outer_join_to_inner=TRUE
*._optimizer_outer_to_anti_enabled=TRUE
*._optimizer_push_down_distinct=0
*._optimizer_push_pred_cost_based=TRUE
*._optimizer_rownum_bind_default=10
*._optimizer_rownum_pred_based_fkr=TRUE
*._optimizer_skip_scan_enabled=TRUE
*._optimizer_sortmerge_join_inequality=TRUE
*._optimizer_squ_bottomup=TRUE
*._optimizer_star_tran_in_with_clause=TRUE
*._optimizer_system_stats_usage=TRUE
*._optimizer_table_expansion=TRUE
*._optimizer_transitivity_retain=TRUE
*._optimizer_try_st_before_jppd=TRUE
*._optimizer_undo_cost_change='11.2.0.3'
*._optimizer_unnest_corr_set_subq=TRUE
*._optimizer_unnest_disjunctive_subq=TRUE
*._optimizer_use_cbqt_star_transformation=TRUE
*._optimizer_use_feedback=TRUE
*._or_expand_nvl_predicate=TRUE
*._ordered_nested_loop=TRUE
*._parallel_broadcast_enabled=TRUE
*._partition_view_enabled=TRUE
*._pga_max_size=1677720K
*._pivot_implementation_method='CHOOSE'
*._pre_rewrite_push_pred=TRUE
*._pred_move_around=TRUE
*._push_join_predicate=TRUE
*._push_join_union_view=TRUE
*._push_join_union_view2=TRUE
*._px_minus_intersect=TRUE
*._px_partition_scan_enabled=TRUE
*._px_pwg_enabled=TRUE
*._px_ual_serial_input=TRUE
*._query_rewrite_setopgrw_enable=TRUE
*._remove_aggr_subquery=TRUE
*._replace_virtual_columns=TRUE
*._right_outer_hash_enable=TRUE
*._selfjoin_mv_duplicates=TRUE
*._smm_max_size=838860
*._smm_min_size=1024
*._smm_px_max_size=4194304
*._sql_model_unfold_forloops='RUN_TIME'
*._sqltune_category_parsed='DEFAULT' # parsed sqltune_category
*._subquery_pruning_enabled=TRUE
*._subquery_pruning_mv_enabled=FALSE
*._table_scan_cost_plus_one=TRUE
*._union_rewrite_for_gs='YES_GSET_MVS'
*._unnest_subquery=TRUE
*._use_column_stats_for_function=TRUE
*.audit_file_dest='/u01/app/oracle/admin/restore/adump'
*.audit_sys_operations=TRUE
*.audit_trail='NONE'
*.background_dump_dest='/u01/app/oracle/diag/rdbms/restore/restore/trace' #Deprecate parameter
*.cluster_database=FALSE
*.compatible='11.2.0.3.0'
*.control_files='+DG_RESTORE/restore/controlfile/current.ctl'
*.db_block_size=8192
*.db_cache_size=50G
*.db_create_file_dest='+DG_RESTORE'
*.db_domain=''
*.db_name='prd02'
*.db_recovery_file_dest_size=500G
*.diagnostic_dest='/u01/app/oracle'
*.fast_start_parallel_rollback='HIGH'
*.job_queue_processes=1000
*.log_archive_dest=''
*.log_archive_dest_1='LOCATION=+DG_RESTORE'
*.log_archive_dest_state_2='ENABLE'
*.log_archive_duplex_dest=''
*.log_buffer=7585792 # log buffer update
*.open_cursors=1000
*.optimizer_dynamic_sampling=2
*.optimizer_mode='ALL_ROWS'
*.parallel_degree_policy='MANUAL'
*.parallel_max_servers=6
*.parallel_min_servers=2
*.parallel_servers_target=8
*.parallel_servers_target=1
*.parallel_threads_per_cpu=10
*.pga_aggregate_target=8G
*.plsql_warnings='DISABLE:ALL' # PL/SQL warnings at init.ora
*.processes=2000
*.query_rewrite_enabled='TRUE'
*.remote_login_passwordfile='EXCLUSIVE'
*.resource_limit=TRUE
*.resource_manager_plan=''
*.result_cache_max_size=135680K
*.sec_case_sensitive_logon=FALSE
*.sessions=3072
*.sga_max_size=142G # internally adjusted
*.sga_target=110G
*.shared_pool_size=10G
*.skip_unusable_indexes=TRUE
*.standby_file_management='AUTO'
*.streams_pool_size=4G
*.undo_tablespace='UNDOTBS1'
*.user_dump_dest='/u01/app/oracle/diag/rdbms/restore/restore/trace' #Deprecate parameter


### no pora05
oracle@BRCSFHORA02::/home/oracle> mkdir -p /u01/app/oracle/diag/rdbms/restore/cdump
oracle@BRCSFHORA02::/home/oracle> mkdir -p /u01/app/oracle/admin/restore/adump
oracle@BRCSFHORA02::/home/oracle> mkdir -p /u01/app/oracle/diag/rdbms/restore/trace

### em prod, caso exista, puxar o dbid
15:21:40 prd021 > SELECT DBID FROM V$DATABASE;

      DBID
----------
1755682647


### na base que será restaurada

rman target /
set dbid =1755682647;
startup nomount pfile='/home/oracle/initrestore.ora';

### localizar o controlfile no arquivos restaurados
### Opção A: consulta no rman de produção
export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'
rman target /
list backup of controlfile completed between "19/08/2026 12:00:00" and "19/08/2026 17:00:00";

/*
RMAN> list backup of controlfile completed between "08/09/2018 20:00:00" and "09/09/2018 20:00:00";

using target database control file instead of recovery catalog

List of Backup Sets
===================


BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
85077   Incr 0  10.66M     DISK        00:00:03     09/09/2018 08:07:29
        BP Key: 360327   Status: AVAILABLE  Compressed: YES  Tag: DATABASE FULL
        Piece Name: /stage/prd02/full/df_PRD02_355195_1_rrtcllhu.rman   <<<<<<<<<<<<<<<<<<<<<<<<<<
  Control File Included: Ckp SCN: 3731372639170   Ckp time: 09/09/2018 08:07:26

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
85082   Full    116.36M    DISK        00:00:02     09/09/2018 08:08:57
        BP Key: 360338   Status: AVAILABLE  Compressed: NO  Tag: CONTROL_FILE
        Piece Name: /stage/prd02/full/cf_PRD02_355199_1_rvtcllkn.rman
  Control File Included: Ckp SCN: 3731372666860   Ckp time: 09/09/2018 08:08:55

BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ -------------------
85083   Full    116.36M    DISK        00:00:02     09/09/2018 08:09:00
        BP Key: 360339   Status: AVAILABLE  Compressed: NO  Tag: STANDBY
        Piece Name: /stage/prd02/full/cf_PRD02_355200_1_s0tcllkq.rman
  Standby Control File Included: Ckp SCN: 3731372667908   Ckp time: 09/09/2018 08:08:58

  */
  




restore controlfile from '/stage/prd02/full/df_PRD02_355195_1_rrtcllhu.rman';
startup mount;

/*
RMAN> restore controlfile from '/stage/prd02/full/cf_PRD02_355199_1_rvtcllkn.rman';

Starting restore at 17-SEP-18
using target database control file instead of recovery catalog
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=1600 device type=DISK

channel ORA_DISK_1: restoring control file
channel ORA_DISK_1: restore complete, elapsed time: 00:00:01
output file name=+DG_RESTORE/restore/controlfile/current.ctl
Finished restore at 17-SEP-18
*/

export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss' --formato da data para efetuar listagens no catálogo

list backup of controlfile completed between "08/09/2018 20:00:00" and "09/09/2018 20:00:00";
list backup of database completed between "08/09/2018 18:00:00" and "09/09/2018 20:00:00";
list backup of database summary completed between "08/09/2018 18:00:00" and "09/09/2018 20:00:00";
list backup of archivelog all completed between "08/09/2018 20:00:00" and "09/09/2018 20:00:00";
list backup of archivelog all summary completed between "08/09/2018 20:00:00" and "09/09/2018 20:00:00";


/*
### catalogar o bkp
### Não foi feito nesse exemplo, pois os pieces foram restaurados no local de origem que foram criados
run
{
catalog start with '/stage/prd02/full/' noprompt;
}

run
{
catalog start with '/stage/prd02/archive/' noprompt;
}
*/




### Identificar o id das tablespaces que serão restauradas
rman target /
report schema

RMAN> report schema
2> ;

RMAN-06139: WARNING: control file is not current for REPORT SCHEMA
Report of database schema for database with db_unique_name PRD02

List of Permanent Datafiles
===========================
File Size(MB) Tablespace           RB segs Datafile Name
---- -------- -------------------- ------- ------------------------
1    0        SYSTEM               ***     +DATA/prd02/datafile/system.256.848423319
2    0        SYSAUX               ***     +DATA/prd02/datafile/sysaux.257.848423319
3    0        TS_SMS_DAT01         ***     +DATA1/prd02/datafile/ts_sms_dat01.768.896651161
4    0        USERS                ***     +DATA/prd02/datafile/users.259.848423321
5    0        TS_SMS_IDX01         ***     +DATA1/prd02/datafile/ts_sms_idx01.769.896651477
6    0        TS_FINPACD_DAT01     ***     +DATA1/prd02/datafile/ts_finpacd_dat01.256.848435341
7    0        TS_FINPACI_IDX01     ***     +DATA1/prd02/datafile/ts_finpaci_idx01.257.848435353
8    0        TS_SDBANCO_DAT01     ***     +DATA1/prd02/datafile/ts_sdbanco_dat01.258.848435415
9    0        TS_SDBANCO_IDX01     ***     +DATA1/prd02/datafile/ts_sdbanco_idx01.259.848435593
10   0        TS_SDIMIOD_DAT01     ***     +DATA1/prd02/datafile/ts_sdimiod_dat01.260.848435901
11   0        TS_SDIMIOI_IDX01     ***     +DATA1/prd02/datafile/ts_sdimioi_idx01.261.848435907
12   0        TS_RSKCTR_DAT01      ***     +DATA1/prd02/datafile/ts_riskcenter_temp.263.857080803
13   0        TS_RSKCTR_IDX01      ***     +DATA1/prd02/datafile/ts_riskcenter_temp_idx.329.857080815
14   0        UNDOTBS1             ***     +DATA1/prd02/datafile/undotbs1.280.856883855
15   0        UNDOTBS2             ***     +DATA1/prd02/datafile/undotbs2.377.856884199
16   0        TS_ITSM_DAT01        ***     +DATA1/prd02/datafile/ts_itsm_dat01.483.970006727
17   0        TS_CSFTDS_IDX01      ***     +DATA1/prd02/datafile/ts_csftds_idx01.275.850034753
18   0        TS_CSFTDS_DAT01      ***     +DATA1/prd02/datafile/ts_csftds_dat01.276.850034755
19   0        TS_ITSM_IDX01        ***     +DATA1/prd02/datafile/ts_itsm_idx01.711.970007677
20   0        TS_INTEGRADOR_DAT01  ***     +DATA1/prd02/datafile/ts_integrador_dat01.335.928343819
21   0        TBS_SERV_LIF_DATA01  ***     +DATA1/prd02/datafile/tbs_serv_lif_data01.897.906847311
22   0        TS_INTEGRADOR_IDX01  ***     +DATA1/prd02/datafile/ts_integrador_idx01.294.928343819
23   0        TS_DEBREC_DAT01_MOVE ***     +DATA1/prd02/datafile/ts_debrec_dat01_move.296.850049429
24   0        TS_DEBREC_IDX01      ***     +DATA1/prd02/datafile/ts_debrec_idx01.297.850050005
25   0        TS_CLRSALE_DAT01     ***     +DATA1/prd02/datafile/ts_clrsale_dat02.405.879462219
26   0        TS_CLRSALE_IDX01     ***     +DATA1/prd02/datafile/ts_clrsale_idx02.287.879462533
27   0        TS_PLD_DAT01         ***     +DATA1/prd02/datafile/ts_pld_dat01.579.966118271
28   0        TS_PLD_IDX01         ***     +DATA1/prd02/datafile/ts_pld_idx01.458.966118679
29   0        TS_CDCGF_DAT01       ***     +DATA1/prd02/datafile/ts_cdcgf_dat01.300.850488675
30   0        TS_CONCIL_DAT01      ***     +DATA1/prd02/datafile/ts_concil_dat01.307.850489573
31   0        TS_CONCIL_IDX01      ***     +DATA1/prd02/datafile/ts_concil_idx01.289.850490743
32   0        TS_LIFERAY_IDX01     ***     +DATA/prd02/datafile/ts_liferay_idx01.271.850569827
33   0        TS_LIFERAY_DAT01     ***     +DATA1/prd02/datafile/ts_liferay_dat01.293.850570947
34   0        TS_SERVCORE_DAT01    ***     +DATA1/prd02/datafile/ts_servcore_dat01.312.850570971
35   0        TBS_SERV_LIF_IDX01   ***     +DATA1/prd02/datafile/tbs_serv_lif_idx01.932.906847327
36   0        TS_SERVCORE_IDX01    ***     +DATA1/prd02/datafile/ts_servcore_idx01.302.850602291
37   0        TS_DATACARE_IDX01    ***     +DATA1/prd02/datafile/ts_datacare_idx01.308.850756933
38   0        TS_CREDITO_DAT01     ***     +DATA1/prd02/datafile/ts_credito_dat01.291.850756933
39   0        TS_CP_IDX01          ***     +DATA1/prd02/datafile/ts_cp_idx01.288.850756935
40   0        TS_PROJJUD_IDX01     ***     +DATA1/prd02/datafile/ts_projjud_idx01.310.850756937
41   0        TS_DATACARE_DAT01    ***     +DATA1/prd02/datafile/ts_datacare_dat01.309.850756939
42   0        TBS_EXTREL_DATA      ***     +DATA1/prd02/datafile/tbs_extrel_data.299.850756939
43   0        TS_LUMISDA_DAT01     ***     +DATA1/prd02/datafile/ts_lumisda_dat01.285.850756943
44   0        TBS_EXTREL_IDX       ***     +DATA1/prd02/datafile/tbs_extrel_idx.301.850756945
45   0        TS_PROJJUD_DAT01     ***     +DATA1/prd02/datafile/ts_projjud_dat01.290.850756963
46   0        TS_CREDITO_IDX01     ***     +DATA1/prd02/datafile/ts_credito_idx01.305.850756971
47   0        TS_CP_DAT01          ***     +DATA1/prd02/datafile/ts_cp_dat01.295.850756973
48   0        TS_PNLOG_DAT01       ***     +DATA1/prd02/datafile/ts_pnlog_dat01.303.850756975
49   0        TS_PNLOG_IDX01       ***     +DATA1/prd02/datafile/ts_pnlog_idx01.292.850756977
50   0        TS_MYABCM_DAT01      ***     +DATA1/prd02/datafile/ts_myabcm_dat01.311.850756983
51   0        TS_LUMISIN_IDX01     ***     +DATA1/prd02/datafile/ts_lumisin_idx01.313.850756983
52   0        TS_MYABCM_IDX01      ***     +DATA1/prd02/datafile/ts_myabcm_idx01.314.850756987
53   0        TS_IIC_DAT01         ***     +DATA1/prd02/datafile/ts_iic_dat01.315.850756987
54   0        TS_IIC_IDX01         ***     +DATA1/prd02/datafile/ts_iic_idx01.316.850756987
55   0        TS_ITGTRUST_DAT01    ***     +DATA1/prd02/datafile/ts_itgtrust_dat01.349.850946831
56   0        TS_PORTCART_IDX01    ***     +DATA/prd02/datafile/ts_portcart_idx01.270.850947241
57   0        TS_PORTCART_DAT01    ***     +DATA/prd02/datafile/ts_portcart_dat01.268.850947245
58   0        TS_LOJIS_INDEX_2     ***     +DATA/prd02/datafile/ts_lojis_index_2.269.850947251
59   0        TS_ITGTRUST_IDX01    ***     +DATA/prd02/datafile/ts_itgtrust_idx01.266.850947403
60   0        TS_LOJIS_DATA_2      ***     +DATA/prd02/datafile/ts_lojis_data_2.265.850948205
61   0        TS_SYSAUDIT_DAT01    ***     +DATA1/prd02/datafile/ts_sysaudit_dat01.371.851631645
62   0        TS_WFBUILD_DAT01     ***     +DATA1/prd02/datafile/ts_wfbuild_dat02.581.918654499
63   0        TS_WFBUILD_IDX01     ***     +DATA1/prd02/datafile/ts_wfbuild_idx02.872.918654831
64   0        TS_BRIT_DAT01        ***     +DATA1/prd02/datafile/ts_brit_dat01.866.924127797
65   0        TS_BRIT_IDX01        ***     +DATA1/prd02/datafile/ts_brit_idx01.880.924128533
66   0        SYSAUX               ***     +DATA1/prd02/datafile/sysaux.893.969694537
67   0        CTMUSER_TBS          ***     +DATA1/prd02/datafile/ctmuser_tbs.912.936099415
68   0        EMUSER_TBS           ***     +DATA1/prd02/datafile/emuser_tbs.438.936099509
69   0        TS_CRIVODA_DAT01     ***     +DATA1/prd02/datafile/ts_crivoda_dat01_aux.326.969913701
70   0        TS_CRIVOIN_IDX01     ***     +DATA1/prd02/datafile/ts_crivoin_idx01_aux.888.969913795
71   0        TS_PCLI_DAT01        ***     +DATA1/prd02/datafile/ts_pcli_dat01.298.976308445
72   0        TS_PCLI_IDX01        ***     +DATA1/prd02/datafile/ts_pcli_idx01.829.976308551
73   0        TS_UOLDIVEODBA       ***     +DATA1/prd02/datafile/ts_uoldiveodba.435.976892983
74   0        TS_CRIVO_DAT01       ***     +DATA1/prd02/datafile/ts_crivo_dat01.318.977302851
75   0        TS_CRIVO_IDX01       ***     +DATA1/prd02/datafile/ts_crivo_idx01.875.977302857
76   0        TS_CRIVORPT_DAT01    ***     +DATA1/prd02/datafile/ts_crivorpt_dat01.339.977302883
77   0        TS_CRIVORPT_IDX01    ***     +DATA1/prd02/datafile/ts_crivorpt_idx01.865.977302887

List of Temporary Files
=======================
File Size(MB) Tablespace           Maxsize(MB) Tempfile Name
---- -------- -------------------- ----------- --------------------
1    102400   TEMP                 102400      +DATA1/prd02/tempfile/temp.343.853608683

### Nesse exemplo, iremos restaurar as tablespaces:
'UNDOTBS1',       
'UNDOTBS2',       
'TS_LIFERAY_DAT01', 
'TS_LIFERAY_IDX01',
'SYSAUX',            
'SYSTEM',            
'TS_SYSAUDIT_DAT01', 
'USERS'

### Caso a base principal esteja no ar, faça esse select
select file_id, tablespace_name
FROM dba_data_files 
WHERE TABLESPACE_NAME IN (
'UNDOTBS1',       
'UNDOTBS2',       
'TS_LIFERAY_DAT01', 
'TS_LIFERAY_IDX01',
'SYSAUX',            
'SYSTEM',            
'TS_SYSAUDIT_DAT01', 
'USERS') order by file_id; 


### Montar o comando de restore, conforme exemplo abaixo

### montar o comando de set newname para os datafile e altera o path do name para o local de destino, nesse exemplo é : +DG_RESTORE/restore/datafile/
select 'set newname for datafile '||file#||' to '''||name||''';' from v$datafile where file# in(1,2,4,14,15,32,33,61,66) order by 1;

### Criar o arquivo: restore_prd02_skip.sh
rman log=restore_skip.log nocatalog <<EOF
connect target /


run
{ set until time "to_date('09/09/2018 08:48:29','DD/MM/YYYY HH24:MI:SS')";
    allocate channel ch01 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch02 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch03 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch04 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch05 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch06 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch07 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch08 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
set newname for datafile 1 to  '+DG_RESTORE/prd02/datafile/system.256.848423319';
set newname for datafile 14 to '+DG_RESTORE/prd02/datafile/undotbs1.280.856883855';
set newname for datafile 15 to '+DG_RESTORE/prd02/datafile/undotbs2.377.856884199';
set newname for datafile 2 to  '+DG_RESTORE/prd02/datafile/sysaux.257.848423319';
set newname for datafile 32 to '+DG_RESTORE/prd02/datafile/ts_liferay_idx01.271.850569827';
set newname for datafile 33 to '+DG_RESTORE/prd02/datafile/ts_liferay_dat01.293.850570947';
set newname for datafile 4 to  '+DG_RESTORE/prd02/datafile/users.259.848423321';
set newname for datafile 61 to '+DG_RESTORE/prd02/datafile/ts_sysaudit_dat01.371.851631645';
set newname for datafile 66 to '+DG_RESTORE/prd02/datafile/sysaux.893.969694537';
restore datafile 1,2,4,14,15,32,33,61,66 ;
}
EOF


Once I had the datafiles in place, I cataloged them and updated the controlfile with switch datafile … to copy command.
No alert_log, validar o nome dos datafiles restaurados

catalog datafilecopy '+DG_RESTORE/prd02/datafile/system.264.987335543';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/undotbs1.263.987335541';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/undotbs2.258.987335541';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/sysaux.261.987335543';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/ts_liferay_idx01.265.987335543';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/ts_liferay_dat01.262.987335543';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/users.257.987336227';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/ts_sysaudit_dat01.260.987335541';
catalog datafilecopy '+DG_RESTORE/prd02/datafile/sysaux.266.987335543';


RMAN> switch datafile 1,2,4,14,15,32,33,61,66 to copy;

### After successfully restore of the datafiles, we need to restore the archive logs in order to perform consistent recovery.
### Since this was RAC database, I had to specify the sequences for each thread [1/2].
### The sequence numbers I’ve previously identified from list backup of archivelog all command.
### Lista os archives para pegar o intervalo de sequence
list backup of archivelog all completed between "08/09/2018 20:00:00" and "09/09/2018 20:00:00";

/*
BS Key  Size       Device Type Elapsed Time Completion Time
------- ---------- ----------- ------------ -------------------
85118   870.02M    DISK        00:00:00     09/09/2018 18:00:33
        BP Key: 360380   Status: AVAILABLE  Compressed: YES  Tag: ARCHIVE_LOG
        Piece Name: /stage/prd02/archive/af_PRD02_355209_1_s9tcmoa1.rman

  List of Archived Logs in backup set 85118
  Thrd Seq     Low SCN    Low Time            Next SCN   Next Time
  ---- ------- ---------- ------------------- ---------- ---------
  1    24576   3731425185657 09/09/2018 16:00:06 3731428637958 09/09/2018 18:00:07

BS Key  Size       Device Type Elapsed Time Completion Time
------- ---------- ----------- ------------ -------------------
85119   2.84G      DISK        00:00:00     09/09/2018 18:00:33
        BP Key: 360381   Status: AVAILABLE  Compressed: YES  Tag: ARCHIVE_LOG
        Piece Name: /stage/prd02/archive/af_PRD02_355210_1_satcmoa1.rman

  List of Archived Logs in backup set 85119
  Thrd Seq     Low SCN    Low Time            Next SCN   Next Time
  ---- ------- ---------- ------------------- ---------- ---------
  2    22402   3731425186789 09/09/2018 16:00:09 3731428637909 09/09/2018 18:00:07

*/

### Criar o arquivo: restore_archive_prd02.sh
rman log=restore_archive_prd02.log nocatalog <<EOF
connect target /

run {set until time "to_date('09/09/2018 08:48:29','DD/MM/YYYY HH24:MI:SS')";
    allocate channel ch01 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch02 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch03 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch04 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch05 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch06 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch07 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    allocate channel ch08 type disk format '/stage/prd02/full/df_%d_%s_%p_%u.rman';
    set archivelog destination to '/stage/prd02/full';
    restore archivelog sequence between 24564 and 24576 thread 1;
    restore archivelog sequence between 22390 and 22402 thread 2;
}
EOF
### The tricky part in this process was to run the recover database command with SKIP FOREVER TABLESPACE.
### query do skip das tbs (REMOVER A TBS A SER RESTAURADA)

col tablespace_name for a100
SELECT listagg(tablespace_name,''',''')within group (ORDER BY tablespace_name)
FROM dba_data_files 
WHERE TABLESPACE_NAME NOT IN (
'UNDOTBS1',       
'UNDOTBS2',       
'TS_LIFERAY_DAT01', 
'TS_LIFERAY_IDX01',
'SYSAUX',            
'SYSTEM',            
'TS_SYSAUDIT_DAT01', 
'USERS');       

### Criar o arquivo: recover_prd02_skip_.sh
rman log=recover_skip.log nocatalog <<EOF
connect target /
run {
    allocate channel c1 type disk;
    recover database skip forever tablespace 'CTMUSER_TBS','EMUSER_TBS','TBS_EXTREL_DATA','TBS_EXTREL_IDX','TBS_SERV_LIF_DATA01','TBS_SERV_LIF_IDX01','TS_BRIT_DAT01','TS_BRIT_IDX01','TS_CDCGF_DAT01','TS_CLRSALE_DAT01','TS_CLRSALE_IDX01','TS_CONCIL_DAT01','TS_CONCIL_IDX01','TS_CP_DAT01','TS_CP_IDX01','TS_CREDITO_DAT01','TS_CREDITO_IDX01','TS_CRIVODA_DAT01','TS_CRIVOIN_IDX01','TS_CRIVORPT_DAT01','TS_CRIVORPT_IDX01','TS_CRIVO_DAT01','TS_CRIVO_IDX01','TS_CSFTDS_DAT01','TS_CSFTDS_IDX01','TS_DATACARE_DAT01','TS_DATACARE_IDX01','TS_DEBREC_DAT01_MOVE','TS_DEBREC_IDX01','TS_FINPACD_DAT01','TS_FINPACI_IDX01','TS_IIC_DAT01','TS_IIC_IDX01','TS_INTEGRADOR_DAT01','TS_INTEGRADOR_IDX01','TS_ITGTRUST_DAT01','TS_ITGTRUST_IDX01','TS_ITSM_DAT01','TS_ITSM_IDX01','TS_LOJIS_DATA_2','TS_LOJIS_INDEX_2','TS_LUMISDA_DAT01','TS_LUMISIN_IDX01','TS_MYABCM_DAT01','TS_MYABCM_IDX01','TS_PCLI_DAT01','TS_PCLI_IDX01','TS_PLD_DAT01','TS_PLD_IDX01','TS_PNLOG_DAT01','TS_PNLOG_IDX01','TS_PORTCART_DAT01','TS_PORTCART_IDX01','TS_PROJJUD_DAT01','TS_PROJJUD_IDX01','TS_RSKCTR_DAT01','TS_RSKCTR_IDX01','TS_SDBANCO_DAT01','TS_SDBANCO_IDX01','TS_SDIMIOD_DAT01','TS_SDIMIOI_IDX01','TS_SERVCORE_DAT01','TS_SERVCORE_IDX01','TS_SMS_DAT01','TS_SMS_IDX01','TS_UOLDIVEODBA','TS_WFBUILD_DAT01','TS_WFBUILD_IDX01';
	}
EOF	

/*	
    set until sequence 24664 thread 1;
    set until sequence 22487 thread 2;
*/


### After successful recover don’t forget to update the redo log files definition.
### I’ve dropped some redo log groups leaving the database with minimum of (2 groups) two redo log file members per group (to save on space).

select 'alter database rename file  '''||member||''' to '''||member||''';' from v$logfile;

alter database rename file  '+DATA1/prd02/onlinelog/group_9.264.848437495' to  '+DG_RESTORE/restore/group_9.264.848437495';
alter database rename file  '+DATA1/prd02/onlinelog/group_10.266.848437537' to '+DG_RESTORE/restore/group_10.266.848437537';
alter database rename file  '+DATA1/prd02/onlinelog/group_1.446.870112265' to  '+DG_RESTORE/restore/group_1.446.870112265';
alter database rename file  '+DATA1/prd02/onlinelog/group_11.267.848437583' to '+DG_RESTORE/restore/group_11.267.848437583';
alter database rename file  '+DATA1/prd02/onlinelog/group_12.268.848437627' to '+DG_RESTORE/restore/group_12.268.848437627';
alter database rename file  '+DATA1/prd02/onlinelog/group_13.269.848437671' to '+DG_RESTORE/restore/group_13.269.848437671';
alter database rename file  '+DATA1/prd02/onlinelog/group_14.270.848437715' to '+DG_RESTORE/restore/group_14.270.848437715';
alter database rename file  '+DATA1/prd02/onlinelog/group_15.271.848437761' to '+DG_RESTORE/restore/group_15.271.848437761';
alter database rename file  '+DATA1/prd02/onlinelog/group_16.272.848437803' to '+DG_RESTORE/restore/group_16.272.848437803';
alter database rename file  '+DATA1/prd02/onlinelog/group_2.459.870112301' to '+DG_RESTORE/restore/group_2.459.870112301';
alter database rename file  '+DATA1/prd02/onlinelog/group_3.363.870112343' to '+DG_RESTORE/restore/group_3.363.870112343';
alter database rename file  '+DATA1/prd02/onlinelog/group_4.454.870112499' to '+DG_RESTORE/restore/group_4.454.870112499';
alter database rename file  '+DATA1/prd02/onlinelog/group_5.341.870112551' to '+DG_RESTORE/restore/group_5.341.870112551';
alter database rename file  '+DATA1/prd02/onlinelog/group_6.317.870112601' to '+DG_RESTORE/restore/group_6.317.870112601';
alter database rename file  '+DATA1/prd02/onlinelog/group_7.325.870112655' to '+DG_RESTORE/restore/group_7.325.870112655';
alter database rename file  '+DATA1/prd02/onlinelog/group_8.322.870112691' to '+DG_RESTORE/restore/group_8.322.870112691';


select name from v$tempfile order by 1;

select 'alter database rename file  '||name||' to '''||name||''';' from v$tempfile;

alter database rename file  '+DATA1/prd02/tempfile/temp.343.853608683' to '+DG_RESTORE/restore/temp.343.853608683';

alter database disable block change tracking;

alter database open resetlogs;

      




