
1) -criar um init.ora :

*.audit_file_dest='D:\oracle\admin\ORCLRES\adump'
*.background_dump_dest='D:\oracle\admin\ORCLRES\bdump'
*.compatible='10.2.0.3.0'
*.control_files='G:\oradata\ORCLRES\control01.ctl','G:\oradata\ORCLRES\control02.ctl','G:\oradata\ORCLRES\control03.ctl'
*.core_dump_dest='D:\oracle\admin\ORCLRES\cdump'
*.db_block_size=8192
*.db_domain=''
*.db_file_multiblock_read_count=16
*.db_name='orclres'
*.db_recovery_file_dest_size=107374182400
*.db_recovery_file_dest='T:\oracle\flash_recovery_area'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=orclresXDB)'
*.job_queue_processes=0
*.open_cursors=300
*.pga_aggregate_target=524288000
*.processes=450
*.remote_login_passwordfile='EXCLUSIVE'
*.sessions=340
*.sga_max_size=1073741824
*.sga_target=1073741824
*.undo_management='AUTO'
*.undo_retention=1800
*.undo_tablespace='UNDOTBS1'
*.user_dump_dest='D:\oracle\admin\ORCLRES\udump'
db_file_name_convert =(D:\ORACLE\ORADATA\ORCL, G:\oradata\ORCLRES, F:\ORACLE\ORADATA\ORCL, G:\oradata\ORCLRES, T:\ORACLE\ORADATA\ORCL, G:\oradata\ORCLRES)
log_file_name_convert=(D:\ORACLE\ORADATA\ORCL, G:\oradata\ORCLRES)





2) - subir instância em nomount


3) - rodar o duplicate - não esquecer de passar o init como parâmetro do comando pra evitar problema

RUN {
	ALLOCATE AUXILIARY CHANNEL t1 TYPE 'SBT_TAPE';

	DUPLICATE TARGET DATABASE TO ORCLRES 
	LOGFILE 
		GROUP 1 ('G:\oradata\ORCLRES\redo01a.ctl','G:\oradata\ORCLRES\redo01b.ctl') SIZE 50M,
		GROUP 2 ('G:\oradata\ORCLRES\redo02a.ctl','G:\oradata\ORCLRES\redo02b.ctl') SIZE 50M,
		GROUP 3 ('G:\oradata\ORCLRES\redo03a.ctl','G:\oradata\ORCLRES\redo03b.ctl') SIZE 50M
	PFILE='D:\oracle\app\product\10.2.0\db_1\database\initORCLRES.ora' 
	UNTIL TIME "TO_DATE('06-05-2011 04:00:00','DD-MM-YYYY HH24:MI:SS')"
	;
}
