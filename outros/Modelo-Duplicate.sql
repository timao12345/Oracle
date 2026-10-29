export NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS'
export ORACLE_SID=RHVIPARA
sqlplus "/as sysdba"
startup nomount pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA.ora';

rman target tmpduplica@RHVISUM auxiliary /

RUN {
        ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE'	PARMS 'ENV=(NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';
        ALLOCATE AUXILIARY CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'ENV=(NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';

RUN {
        ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE'	PARMS 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';
        ALLOCATE AUXILIARY CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';
        SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
		SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
		SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
		SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
		SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
		SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
		SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
		SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
		SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
		SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
		DUPLICATE TARGET DATABASE TO RHVIPARA
		LOGFILE
		GROUP 1 ('+DATA/rhvipara/onlinelog/group1.rdo') size 150M,
		GROUP 2 ('+DATA/rhvipara/onlinelog/group2.rdo') size 150M,
		GROUP 3 ('+DATA/rhvipara/onlinelog/group3.rdo') size 150M,
		GROUP 4 ('+DATA/rhvipara/onlinelog/group4.rdo') size 150M
		pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA.ora'
		until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
}

RUN {
        ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE'	PARMS 'ENV=(NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';
        ALLOCATE AUXILIARY CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'ENV=(NB_ORA_CLIENT=UOL-LOR-SRV01.gtservicos,NB_ORA_SERV=d1-netbackup21.uolcloud,NB_ORA_POLICY=GT_HIMIX_D_OR_DB_DIA_00_01)';
		SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
		SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
		SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
		SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
		SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
		SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
		SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
		SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
		SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
		SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
		DUPLICATE TARGET DATABASE TO RHVIPARA
		LOGFILE
		GROUP 1 ('+DATA/rhvipara/onlinelog/group1.rdo') size 150M,
		GROUP 2 ('+DATA/rhvipara/onlinelog/group2.rdo') size 150M,
		GROUP 3 ('+ARCH/rhvipara/onlinelog/group3.rdo') size 150M,
		GROUP 4 ('+ARCH/rhvipara/onlinelog/group4.rdo') size 150M
		pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA.ora'
		until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
}

RUN {
        ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE';
		SEND 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos)';
        ALLOCATE AUXILIARY CHANNEL c2 TYPE 'SBT_TAPE'; 
		SEND 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos,NB_ORA_SERV=d1-netbackup21.gtservicos)';
        SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
		SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
		SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
		SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
		SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
		SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
		SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
		SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
		SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
		SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
		DUPLICATE TARGET DATABASE TO RHVIPARA
		LOGFILE
		GROUP 1 ('+DATA/rhvipara/onlinelog/group1.rdo') size 150M,
		GROUP 2 ('+DATA/rhvipara/onlinelog/group2.rdo') size 150M,
		GROUP 3 ('+ARCH/rhvipara/onlinelog/group3.rdo') size 150M,
		GROUP 4 ('+ARCH/rhvipara/onlinelog/group4.rdo') size 150M
		pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA.ora'
		until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
}



RUN {
        ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE';
		SEND 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos)';
        ALLOCATE AUXILIARY CHANNEL c2 TYPE 'SBT_TAPE'; 
		SEND 'ENV=(NB_ORA_CLIENT=UOL-SAPPRD.gtservicos';
        SET NEWNAME FOR DATAFILE 1 to '+DATA/rhvipara/datafile/system.256.851772955';
		SET NEWNAME FOR DATAFILE 2 to '+DATA/rhvipara/datafile/sysaux.257.851772959';
		SET NEWNAME FOR DATAFILE 3 to '+DATA/rhvipara/datafile/undotbs1.258.851772961';
		SET NEWNAME FOR DATAFILE 4 to '+DATA/rhvipara/datafile/users.260.851772969';
		SET NEWNAME FOR DATAFILE 5 to '+DATA/rhvipara/datafile/rh_visum.264.851792453';
		SET NEWNAME FOR DATAFILE 6 to '+DATA/rhvipara/datafile/rh_visumindice.263.851792589';
		SET NEWNAME FOR DATAFILE 7 to '+DATA/rhvipara/datafile/rh_visum.262.851795553';
		SET NEWNAME FOR DATAFILE 8 to '+DATA/rhvipara/datafile/rh_visum.265.851795637';
		SET NEWNAME FOR DATAFILE 9 to '+DATA/rhvipara/datafile/rh_visumindice.266.851795777';
		SET NEWNAME FOR TEMPFILE 1 to '+DATA/rhvipara/tempfile/temp.259.851772963';
		DUPLICATE TARGET DATABASE TO RHVIPARA
		LOGFILE
		GROUP 1 ('+DATA/rhvipara/onlinelog/group1.rdo') size 150M,
		GROUP 2 ('+DATA/rhvipara/onlinelog/group2.rdo') size 150M,
		GROUP 3 ('+ARCH/rhvipara/onlinelog/group3.rdo') size 150M,
		GROUP 4 ('+ARCH/rhvipara/onlinelog/group4.rdo') size 150M
		pfile='/u01/app/oracle/product/11.2.0/db_1/dbs/initRHVIPARA.ora'
		until time "to_date('05/11/2014 23:00:00','dd/mm/yyyy hh24:mi:ss')";
}