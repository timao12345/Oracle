select 'SET NEWNAME FOR DATAFILE '||file_name||' to '|| chr(39) || name || chr(39)||';' from dba_data_files where tablespace_name not in ('USERS','ELANCERS_MVIEWS','ELANCERS_XEMP_DATA','ELANCERS_INDX','ELANCERS_MVIEWS_INDX','ELANCERS_XEMP_INDX','TBS_STASPACK','TBS_UOLQA,ELA_LOGMV');

select 'SET NEWNAME FOR DATAFILE '||file_id||' to '|| chr(39) || file_name || chr(39)||';' from dba_data_files where tablespace_name not in ('USERS','ELANCERS_MVIEWS','ELANCERS_XEMP_DATA','ELANCERS_INDX','ELANCERS_MVIEWS_INDX','ELANCERS_XEMP_INDX','TBS_STASPACK','TBS_UOLQA,ELA_LOGMV'); order by file_id;

select 'SET NEWNAME FOR DATAFILE '||file_id||' to '|| chr(39) || file_name || chr(39)||';' from dba_data_files where tablespace_name not in ('USERS','ELANCERS_MVIEWS','ELANCERS_XEMP_DATA','ELANCERS_INDX','ELANCERS_MVIEWS_INDX','ELANCERS_XEMP_INDX','TBS_STASPACK','TBS_UOLQA,ELA_LOGMV') order by file_id;

select 'SET NEWNAME FOR DATAFILE '||file_id||' to '|| chr(39) || file_name || chr(39)||';' from dba_data_files where tablespace_name not in ('USERS','ELANCERS_MVIEWS','ELANCERS_XEMP_DATA','ELANCERS_INDX','ELANCERS_MVIEWS_INDX','ELANCERS_XEMP_INDX','TBS_STASPACK','TBS_UOLQA,ELA_LOGMV') order by file_id;