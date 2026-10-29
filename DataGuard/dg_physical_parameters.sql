undef inst_id
set pages 80 lines 200
col name for a30
col value for a110
select 
	inst_id,
	name, 
	value, 
	issys_modifiable
from gv$parameter
--where isdefault = 'FALSE'
--order by 1
where name in ('db_name','db_unique_name','log_archive_config', 'log_archive_dest_1','log_archive_dest_2','log_archive_dest_3',
               'log_archive_dest_state_1','log_archive_dest_state_2','log_archive_dest_state_3', 'remote_login_passwordfile',
               'log_archive_format','log_archive_max_processes','fal_server','fal_client','db_file_name_convert',
               'log_file_name_convert', 'standby_file_management','archive_lag_target')
and inst_id=&inst_id
order by 2,1;