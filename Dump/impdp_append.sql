expdp userid=" '/ as sysdba'" directory=dir_dp dumpfile=EMPLOYEES_2.dmp logfile=EMPLOYEES_2.log tables=HR.EMPLOYEES
impdp userid=" '/ as sysdba'" TABLE_EXISTS_ACTION=REPLACE tables=HR.OXFORD directory=dir_dp dumpfile=OXFORD.dmp logfile=IMP_OXFORD.log




expdp userid=" '/ as sysdba'" directory=DIR_DMP dumpfile=EMPLOYEES_2.dmp logfile=EMPLOYEES_2.log tables=HR.EMPLOYEES


expdp userid=" '/ as sysdba'" directory=DIR_DMP schemas=BI_DW include=TABLE:"IN(\'DM_CLASSIFICADO'\,\'DM_INSCRITO'\,\'GRR_DOF_IDF_TABLE'\)" dumpfile=C416588.dmp logfile=C416588..log
