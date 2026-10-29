kpvstby1.__data_transfer_cache_size=0
kpvstby2.__data_transfer_cache_size=0
kpvstby1.__db_cache_size=110595407872
kpvstby2.__db_cache_size=110595407872
kpvstby1.__inmemory_ext_roarea=0
kpvstby2.__inmemory_ext_roarea=0
kpvstby1.__inmemory_ext_rwarea=0
kpvstby2.__inmemory_ext_rwarea=0
kpvstby1.__java_pool_size=0
kpvstby2.__java_pool_size=0
kpvstby1.__large_pool_size=268435456
kpvstby2.__large_pool_size=268435456
kpvstby1.__oracle_base='/u02/app/oracle'#ORACLE_BASE set from environment
kpvstby2.__oracle_base='/u02/app/oracle'#ORACLE_BASE set from environment
kpvstby1.__pga_aggregate_target=42144366592
kpvstby2.__pga_aggregate_target=42144366592
kpvstby1.__sga_target=125896228864
kpvstby2.__sga_target=125896228864
kpvstby1.__shared_io_pool_size=268435456
kpvstby2.__shared_io_pool_size=268435456
kpvstby1.__shared_pool_size=13958643712
kpvstby2.__shared_pool_size=13958643712
kpvstby1.__streams_pool_size=0
kpvstby2.__streams_pool_size=0
kpvstby1.__unified_pga_pool_size=0
kpvstby2.__unified_pga_pool_size=0
*._assm_segment_repair_bg=FALSE
*._parallel_adaptive_max_users=2
*.audit_sys_operations=TRUE
*.audit_trail='DB'
*.cluster_database=false
kpvstby1.cluster_interconnects='100.107.8.1:100.107.8.2'
kpvstby2.cluster_interconnects='100.107.8.3:100.107.8.4'
*.compatible='19.0.0'
*.control_files='+DATAC1/KPVSTBY/CONTROLFILE/control_file_01.cf','+RECOC1/KPVSTBY/CONTROLFILE/control_file_02.cf'#Restore Controlfile
*.control_management_pack_access='DIAGNOSTIC+TUNING'
*.db_block_checking='OFF'
*.db_block_checksum='TYPICAL'
*.db_block_size=8192
*.db_create_file_dest='+DATAC1'
*.db_create_online_log_dest_1='+DATAC1'
*.db_domain='adcorp.intranet'
*.db_flashback_retention_target=1440
*.db_lost_write_protect='typical'
*.db_recovery_file_dest='+RECOC1'
*.db_recovery_file_dest_size=12076374294528
*.db_unique_name='kpvstby'
*.diagnostic_dest='/u02/app/oracle'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=kpvstbyXDB)'
*.distributed_lock_timeout=360
*.enable_ddl_logging=TRUE
*.fast_start_mttr_target=300
*.filesystemio_options='setall'
*.inmemory_force='cellmemory_level'
family:dw_helper.instance_mode='read-only'
kpvstby1.instance_number=1
kpvstby2.instance_number=2
*.local_listener='-oraagent-dummy-'
*.log_archive_format='%t_%s_%r.dbf'
*.log_buffer=268435456
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.os_authent_prefix=''
*.parallel_execution_message_size=16384
*.pga_aggregate_target=40000m
*.recyclebin='on'
*.remote_listener='exacc03-kpv-drs-scan:1521'
*.remote_login_passwordfile='exclusive'
*.sec_protocol_error_further_action='(DROP,3)'
*.sga_target=120000m
*.sql92_security=TRUE
*.tablespace_encryption='AUTO_ENABLE'
*.tde_configuration='keystore_configuration=FILE'
kpvstby2.thread=2
kpvstby1.thread=1
kpvstby1.undo_tablespace='UNDOTBS01'
kpvstby2.undo_tablespace='UNDOTBS2'
*.use_large_pages='ONLY'
*.wallet_root='/var/opt/oracle/dbaas_acfs/ORAKPV/wallet_root'
*.cursor_sharing='EXACT'
*.db_files=2000
*.db_name='ORAKPV'#Reset to original value by RMAN
*.encrypt_new_tablespaces='ALWAYS'
*.global_names=FALSE
*.inmemory_size=1520m
*.log_archive_config=''
*.log_archive_dest_10=''
*.log_archive_dest_1=''
*.log_archive_dest_2=''
*.log_archive_dest_state_1='ENABLE'
*.log_archive_dest_state_10='ENABLE'
*.log_archive_dest_state_2='RESET'
*.open_cursors=5000
*.parallel_max_servers=1440
*.parallel_min_servers=288
*.parallel_servers_target=576
*.parallel_threads_per_cpu=2
*.processes=4096
*.service_names='kpvstby.adcorp.intranet'
*.smtp_out_server='smtp.adcorp.intranet:25'
*.undo_retention=14400

Execução do duplicate / Restore / Recovery From Service (Creating a Physical Standby database using RMAN restore database from service (Doc ID 2283978.1)

Exemplo Recovery from service:
screen -S restore_SERVICE_DBNAME -L
. DBNAME.env
rman target /
startup nomount
restore standby controlfile from service 'DBNAME_origem';
alter database mount;
CONFIGURE DEFAULT DEVICE TYPE TO DISK;
CONFIGURE CHANNEL DEVICE TYPE SBT_TAPE CLEAR;
CONFIGURE DEVICE TYPE DISK PARALLELISM 12;
restore database AS ENCRYPTED from service 'DBNAME_origem' section size 64G;
switch database to copy;
exit;

Exemplo Duplicate:
run {
	set newname for tempfile 1 to '+DATAC1';
	set newname for database to '+DATAC1';
	ALLOCATE CHANNEL t01 DEVICE TYPE DISK;
	ALLOCATE CHANNEL t02 DEVICE TYPE DISK;
	allocate auxiliary channel stby4 type disk;
	duplicate target database
	for standby
	from active database
	spfile
	parameter_value_convert 'dbname1', 'dbname2', 'dbname3', 'dbname4'
	set db_file_name_convert '+DATAC5','+DATAC1'
	set log_file_name_convert '+DATAC5','+DATAC1','+RECO5','+RECO1'
	set db_name='dbname'
	set db_unique_name='dbunqname'
	set instance_number='1'
	set instance_name='dbinstancename'
	set control_files='+DATAC1','RECOC1'
	set fal_server='dbfailservername'
	set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST MANDATORY REOPEN=300 VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME='dbunqname'
	set log_archive_dest_2='service='dbnane LGWR SYNCNOAFFIRM valid_for=(ONLINE_LOGFILE,PRIMARY_ROLE) NET_TIMEOUT=30 db_unique_name='dbunqname'
	set undo_tablespace='UNDOTBS1'
	set service_names='dbname'
	set remote_listener='hostname.com.br:1521'
	set audit_file_dest='/u02/app/oracle/admin/dbname/adump'
	set db_create_online_log_dest_1='+DATAC1'
	set db_create_online_log_dest_2='+RECOC1'
	set db_create_file_dest='+DATAC1'
	set db_recovery_file_dest='+RECOC1'
	;
	}
	exit