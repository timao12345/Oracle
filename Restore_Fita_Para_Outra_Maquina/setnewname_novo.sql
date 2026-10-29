

/u02/oradata/ELADBG/datafiles

run
{
SET NEWNAME FOR DATAFILE 1 to '/u02/oradata/ELADBG/datafiles/system.278.816372191';
SET NEWNAME FOR DATAFILE 2 to '/u02/oradata/ELADBG/datafiles/undotbs1.260.816355925';
SET NEWNAME FOR DATAFILE 3 to '/u02/oradata/ELADBG/datafiles/sysaux.282.816355973';
SET NEWNAME FOR DATAFILE 4 to '/u02/oradata/ELADBG/datafiles/undotbs2.279.816364539';
SET NEWNAME FOR DATAFILE 6 to '/u02/oradata/ELADBG/datafiles/elancers.256.816364491';
SET NEWNAME FOR DATAFILE 7 to '/u02/oradata/ELADBG/datafiles/elancers.265.816355935';
SET NEWNAME FOR DATAFILE 8 to '/u02/oradata/ELADBG/datafiles/elancers.259.816364501';
SET NEWNAME FOR DATAFILE 11 to '/u02/oradata/ELADBG/datafiles/undotbs1.280.851102263';
SET NEWNAME FOR DATAFILE 20 to '/u02/oradata/ELADBG/datafiles/elancers';
SET NEWNAME FOR DATAFILE 27 to '/u02/oradata/ELADBG/datafiles/elancers.277.816362921';
SET NEWNAME FOR DATAFILE 29 to '/u02/oradata/ELADBG/datafiles/sysaux.274.816355979';
SET NEWNAME FOR DATAFILE 30 to '/u02/oradata/ELADBG/datafiles/elancers.281.816361435';
SET NEWNAME FOR DATAFILE 31 to '/u02/oradata/ELADBG/datafiles/elancers.271.816364511';
SET NEWNAME FOR DATAFILE 32 to '/u02/oradata/ELADBG/datafiles/elancers.257.816363885';
SET NEWNAME FOR DATAFILE 36 to '/u02/oradata/ELADBG/datafiles/elancers.299.840566485';
SET NEWNAME FOR DATAFILE 37 to '/u02/oradata/ELADBG/datafiles/elancers.268.845028293';
SET NEWNAME FOR DATAFILE 38 to '/u02/oradata/ELADBG/datafiles/elancers.272.847669837';
SET NEWNAME FOR DATAFILE 39 to '/u02/oradata/ELADBG/datafiles/elancers.269.849477043';
switch datafile all;
switch tempfile all;
release CHANNEL c1;
}

SET NEWNAME FOR DATAFILE 34 to '/u02/oradata/ELADBG/datafiles/tbs_uolqa.267.818701087';
SET NEWNAME FOR DATAFILE 35 to '/u02/oradata/ELADBG/datafiles/ela_logmv.283.821447863';