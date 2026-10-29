/u02/oradata/ELADBG/datafiles
/u02/oradata/ELADBG/datafiles


run {
ALLOCATE CHANNEL c1 DEVICE TYPE 'SBT_TAPE' SEND 'NB_ORA_CLIENT=eladb05g.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos,NB_ORA_POLICY=GT_SHA_D_OR_ARC_DIA_08_00';
SET NEWNAME FOR DATAFILE 1 to '/u02/oradata/ELADBG/datafiles/system.278.816372191';
SET NEWNAME FOR DATAFILE 2 to '/u02/oradata/ELADBG/datafiles/undotbs1.260.816355925';
SET NEWNAME FOR DATAFILE 3 to '/u02/oradata/ELADBG/datafiles/sysaux.282.816355973';
SET NEWNAME FOR DATAFILE 4 to '/u02/oradata/ELADBG/datafiles/undotbs2.279.816364539';
SET NEWNAME FOR DATAFILE 5 to '/u02/oradata/ELADBG/datafiles/users.270.816363843';
SET NEWNAME FOR DATAFILE 6 to '/u02/oradata/ELADBG/datafiles/elancers.256.816364491';
SET NEWNAME FOR DATAFILE 7 to '/u02/oradata/ELADBG/datafiles/elancers.265.816355935';
SET NEWNAME FOR DATAFILE 8 to '/u02/oradata/ELADBG/datafiles/elancers.259.816364501';
SET NEWNAME FOR DATAFILE 9 to '/u02/oradata/ELADBG/datafiles/elancers_mviews.258.816364531';
SET NEWNAME FOR DATAFILE 10 to '/u02/oradata/ELADBG/datafiles/elancers_xemp_data.275.816371441';
SET NEWNAME FOR DATAFILE 11 to '/u02/oradata/ELADBG/datafiles/undotbs1.280.851102263';
SET NEWNAME FOR DATAFILE 14 to '/u02/oradata/ELADBG/datafiles/elancers_indx.259.816355953';
SET NEWNAME FOR DATAFILE 15 to '/u02/oradata/ELADBG/datafiles/elancers_indx.267.816364521';
SET NEWNAME FOR DATAFILE 16 to '/u02/oradata/ELADBG/datafiles/elancers_mviews_indx.274.816364375';
SET NEWNAME FOR DATAFILE 17 to '/u02/oradata/ELADBG/datafiles/elancers_xemp_indx.273.816361229';
SET NEWNAME FOR DATAFILE 20 to '/u02/oradata/ELADBG/datafiles/elancers';
SET NEWNAME FOR DATAFILE 21 to '/u02/oradata/ELADBG/datafiles/elancers_indx.264.816355963';
SET NEWNAME FOR DATAFILE 22 to '/u02/oradata/ELADBG/datafiles/elancers_indx';
SET NEWNAME FOR DATAFILE 23 to '/u02/oradata/ELADBG/datafiles/elancers_indx.256.816368753';
SET NEWNAME FOR DATAFILE 24 to '/u02/oradata/ELADBG/datafiles/elancers_indx.262.816359651';
SET NEWNAME FOR DATAFILE 25 to '/u02/oradata/ELADBG/datafiles/elancers_indx.263.816368465';
SET NEWNAME FOR DATAFILE 26 to '/u02/oradata/ELADBG/datafiles/elancers_indx.261.816364547';
SET NEWNAME FOR DATAFILE 27 to '/u02/oradata/ELADBG/datafiles/elancers.277.816362921';
SET NEWNAME FOR DATAFILE 28 to '/u02/oradata/ELADBG/datafiles/elancers_mviews.266.816364551';
SET NEWNAME FOR DATAFILE 29 to '/u02/oradata/ELADBG/datafiles/sysaux.274.816355979';
SET NEWNAME FOR DATAFILE 30 to '/u02/oradata/ELADBG/datafiles/elancers.281.816361435';
SET NEWNAME FOR DATAFILE 31 to '/u02/oradata/ELADBG/datafiles/elancers.271.816364511';
SET NEWNAME FOR DATAFILE 32 to '/u02/oradata/ELADBG/datafiles/elancers.257.816363885';
SET NEWNAME FOR DATAFILE 33 to '/u02/oradata/ELADBG/datafiles/tbs_staspack.273.817495539';
SET NEWNAME FOR DATAFILE 34 to '/u02/oradata/ELADBG/datafiles/tbs_uolqa.267.818701087';
SET NEWNAME FOR DATAFILE 35 to '/u02/oradata/ELADBG/datafiles/ela_logmv.283.821447863';
SET NEWNAME FOR DATAFILE 36 to '/u02/oradata/ELADBG/datafiles/elancers.299.840566485';
SET NEWNAME FOR DATAFILE 37 to '/u02/oradata/ELADBG/datafiles/elancers.268.845028293';
SET NEWNAME FOR DATAFILE 38 to '/u02/oradata/ELADBG/datafiles/elancers.272.847669837';
SET NEWNAME FOR DATAFILE 39 to '/u02/oradata/ELADBG/datafiles/elancers.269.849477043';
SET NEWNAME FOR TEMPFILE 4 to '+ORADATA/eladbg/tempfile/temp.300.844881967';
SET NEWNAME FOR TEMPFILE 5 to '+ORADATA/eladbg/tempfile/temp.301.844882039';
set until time "to_date('19-10-2014 23:00:00','dd-mm-yyyy hh24:mi:ss')";
restore database SKIP TABLESPACE USERS,ELANCERS_MVIEWS,ELANCERS_XEMP_DATA,ELANCERS_INDX,ELANCERS_MVIEWS_INDX,ELANCERS_XEMP_INDX,TBS_STASPACK,TBS_UOLQA,ELA_LOGMV;
switch datafile all;
switch tempfile all;
release CHANNEL c1;
}




SET NEWNAME FOR DATAFILE 1 to '+ORADATA/eladbg/datafile/system.278.816372191';
SET NEWNAME FOR DATAFILE 2 to '+ORADATA/eladbg/datafile/undotbs1.260.816355925';
SET NEWNAME FOR DATAFILE 3 to '+ORADATA/eladbg/datafile/sysaux.282.816355973';
SET NEWNAME FOR DATAFILE 4 to '+ORADATA/eladbg/datafile/undotbs2.279.816364539';
SET NEWNAME FOR DATAFILE 6 to '+ORADATA/eladbg/datafile/elancers.256.816364491';
SET NEWNAME FOR DATAFILE 7 to '+ORADATA/eladbg/datafile/elancers.265.816355935';
SET NEWNAME FOR DATAFILE 8 to '+ORADATA/eladbg/datafile/elancers.259.816364501';
SET NEWNAME FOR DATAFILE 11 to '+ORADATA/eladbg/datafile/undotbs1.280.851102263';
SET NEWNAME FOR DATAFILE 20 to '+ORADATA/eladbg/datafile/elancers';
SET NEWNAME FOR DATAFILE 27 to '+ORADATA/eladbg/datafile/elancers.277.816362921';
SET NEWNAME FOR DATAFILE 29 to '+ORADATA/eladbg/datafile/sysaux.274.816355979';
SET NEWNAME FOR DATAFILE 30 to '+ORADATA/eladbg/datafile/elancers.281.816361435';
SET NEWNAME FOR DATAFILE 31 to '+ORADATA/eladbg/datafile/elancers.271.816364511';
SET NEWNAME FOR DATAFILE 32 to '+ORADATA/eladbg/datafile/elancers.257.816363885';
SET NEWNAME FOR DATAFILE 34 to '+ORADATA/eladbg/datafile/tbs_uolqa.267.818701087';
SET NEWNAME FOR DATAFILE 35 to '+ORADATA/eladbg/datafile/ela_logmv.283.821447863';
SET NEWNAME FOR DATAFILE 36 to '+ORADATA/eladbg/datafile/elancers.299.840566485';
SET NEWNAME FOR DATAFILE 37 to '+ORADATA/eladbg/datafile/elancers.268.845028293';
SET NEWNAME FOR DATAFILE 38 to '+ORADATA/eladbg/datafile/elancers.272.847669837';
SET NEWNAME FOR DATAFILE 39 to '+ORADATA/eladbg/datafile/elancers.269.849477043';
