*.audit_file_dest='/u02/app/oracle/admin/ELADBG/adump'
*.cluster_database=FALSE
*.compatible='11.2.0'
*.control_files='/u02/oradata/ELADBG/controlfile/control01.ctl'
*.db_block_size=8192
*.db_name='ELADBG'
##*.db_recovery_file_dest='+ORAFLASH'
##*.db_recovery_file_dest_size=214748364800
*.diagnostic_dest='/u02/app/oracle'
##ELADBG2.instance_number=2
ELADBG.instance_number=1
##*.job_queue_processes=10
ELADBG1.large_pool_size=134217728
ELADBG2.thread=2
ELADBG1.thread=1
*.undo_management='AUTO'
*.undo_retention=600
##ELADBG2.undo_tablespace='UNDOTBS2'
ELADBG1.undo_tablespace='UNDOTBS1'


adump  bdump  cdump  dpdump  udump

mkdir -p /u02/app/oracle/admin/ELADBG/bdump
mkdir -p /u02/app/oracle/admin/ELADBG/cdump
mkdir -p /u02/app/oracle/admin/ELADBG/dpdump
mkdir -p /u02/app/oracle/admin/ELADBG/udump
