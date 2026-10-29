select file_name from sys.DBA_DATA_FILES
union
select file_name from sys.DBA_TEMP_FILES
union
select member from sys.v_$logfile
union
Select name From SYS.V_$CONTROLFILE
