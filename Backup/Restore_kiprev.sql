run
{
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
SET NEWNAME FOR DATAFILE 1    TO '+DATAC1/KPVPPRD/DATAFILE/prd_data_d-orakpv_ts-system_fno-1';
SWITCH DATAFILE ALL;
sql 'alter session set nls_date_format="YYYY-MM-DD HH24:MI:SS"';
recover database until time '2024-11-12 13:00:00';
}

run{
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t11 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t16 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t17 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t18 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t19 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t20 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t21 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t22 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t23 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t24 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t25 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t26 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t27 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t28 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t29 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t31 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t32 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t33 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t34 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t35 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t36 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t37 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t38 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t39 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
ALLOCATE CHANNEL t40 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
RESTORE datafile 3;
RESTORE datafile 16;
RESTORE datafile 1366;
RESTORE datafile 1367;
RESTORE datafile 1368;
RESTORE datafile 1369;
RESTORE datafile 1370;
RESTORE datafile 1371;
RESTORE datafile 1372;
RESTORE datafile 1373;
RESTORE datafile 1374;
RESTORE datafile 1375;
RESTORE datafile 1376;
RESTORE datafile 1377;
RESTORE datafile 1378;
RESTORE datafile 1379;
RESTORE datafile 1380;
RESTORE datafile 1381;
RESTORE datafile 1382;
RESTORE datafile 1383;
RESTORE datafile 1384;
RESTORE datafile 1385;
RESTORE datafile 1386;
RESTORE datafile 1387;
RESTORE datafile 1388;
RESTORE datafile 1389;
RESTORE datafile 1390;
RESTORE datafile 1391;
RESTORE datafile 1392;
RESTORE datafile 1393;
RESTORE datafile 1394;
RESTORE datafile 1395;
RESTORE datafile 1396;
RESTORE datafile 1397;
RESTORE datafile 1398;
RESTORE datafile 1399;
RESTORE datafile 1400;
RESTORE datafile 1401;
SWITCH DATAFILE ALL;
}

------------
run {
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
sql 'alter session set nls_date_format="YYYY-MM-DD HH24:MI:SS"';
recover database until time '2025-03-20 05:00:00';
}

recover database until time ="to_date('12/11/2024 10:00:00','DD/MM/YYYY HH24:MI:SS')";

run {
allocate channel c1 type disk;
allocate channel c2 type disk;
allocate channel c3 type disk;
allocate channel c4 type disk;
allocate channel c5 type disk;
allocate channel c6 type disk;
allocate channel c7 type disk;
allocate channel c8 type disk;
allocate channel c9 type disk;
allocate channel c10 type disk;
recover database 
}


run {
ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
restore databasee;
}

-- backup controlfile para fita
RUN {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
BACKUP CURRENT CONTROLFILE;
release channel c1;
}



-- testar no ambiente de DEV antes do restore


rman target / catalog CVP_KPV_PRD@DBRMAN

-- HOMOLOGAÇÃO
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_KPV_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
    restore controlfile to '/u02/control_file_01.bak' from TAG=ORA_CVP_KPV_HML;
    release channel c1;
} 


    restore controlfile to '/tmp/control_file_01.bak' from TAG=ORA_CVP_KPV_HML;



run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-hom-db01)';
    restore controlfile to '/tmp/control_file_01.bak' from '/c-626870544-20250624-00';
    release channel c1;
} 


    restore controlfile to '/tmp/control_file_01.bak' from '/bk_dORAKPVHM_uev3rrpil_s13791_p1_t1203627605';


-- PRODUÇÃO
run
{
    ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
    BACKUP CURRENT CONTROLFILE for standby TAG='CRTL_STBY_KPV_260725';
    RELEASE CHANNEL t1 ;
}


run
{
    ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORA_CVP_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
    restore controlfile to '/tmp/ctrl_teste_01.bak' from '/c-3325602173-20250820-19';
    RELEASE CHANNEL ch1;
}

run
{
    allocate channel t1 device type disk;
    BACKUP CURRENT CONTROLFILE for standby TAG='CRTL_STBY_ECC_131025' FORMAT '/backup_acfs_sap/ECC/control_file_ECC.bak';
    RELEASE CHANNEL t1 ;
}

-- orarcu
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=orarcu1,NB_ORA_POLICY=ORA_CVP_ORARCU_PROD_EX10,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=orarcu_55b_gru_4284662918)';
    restore controlfile to '/tmp/*' from '/arch_dORARCU_u0u3tl909_s30_p1_t1205511177';    
    release channel c1;
}
--
restore controlfile to '/tmp/control_file_01.bak' from 'ctrl_dORAKPV_uhf3au52j_s1186351_p1_t1185879123';
restore controlfile to '/tmp/control_file_01.bak' from TAG=TAG20241122T133021;

-- sap prd 
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exasapprdbkp1)';
    restore controlfile to '/tmp/controlfile.bkp' from '/ctrl_dECC_uur44g1jv_s6177755_p1_t1212679807';
    release channel c1;
} 

-- restore do controlfile direto para o local que está configurado o pfile ou spfile'
run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
    restore controlfile from '/ctrl_dECC_uch44kr0j_s6181265_p1_t1212836883';
    release channel c1;
} 

--bkp sap controlfile for standby
run
{
    ALLOCATE CHANNEL t1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=ECC001,NB_ORA_POLICY=ORA_CVP_SAP_PROD_ECC,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=ecc_1235991203)';
    BACKUP CURRENT CONTROLFILE for standby TAG='CRTL_STBY_KPV_260725';
    RELEASE CHANNEL t1 ;
}


run {
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
    ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
    BACKUP CURRENT CONTROLFILE TAG='DIARIO_INC' FORMAT 'CONTROL_%d_%T_%s_%p.rman';
    release channel c1;
}

crosscheck copy;
-- teste restore arch para DEV - ORCL funcional
run {
    set DBID=1713322190
    ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=orcl,NB_ORA_POLICY=ORA_CVP_DEV,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=vmlnxdev002.adcorp.intranet)';
    restore controlfile to '/tmp/control_file_01.bak' from TAG=TAG20241121T092448;
    release channel c1;
} 

run {
set controlfile autobackup format for device type DISK to '/tmp/%F';
    ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64, 
    ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
restore controlfile from autobackup MAXSEQ 5 MAXDAYS 1;
release channel ch1;
}

restore controlfile to '/tmp/control_file_01.bak' from TAG=TAG20241121T092448;
restore controlfile to '/u04/control_file_01.cf' from '/c-3325602173-20241121-0c';
from TAG=TAG20241121T092448;


446, 13724 e 1556, 13782
 
-- novo
100.70.52.10 cvpnbuprimary01.adcorp.intranet
100.70.52.11 cvpnbumedia01.adcorp.intranet
100.70.52.12 cvpnbuworm01.adcorp.intranet

--antigo
10.100.1.138 lnxprd145
10.100.1.139 lnxprd146
10.100.1.140 msdp01.rootbrasil.intranet
10.100.1.141 msdp02.rootbrasil.intranet
10.100.1.202 msdp03.rootbrasil.intranet
 

run{
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML, NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
change backuppiece tag TAG20241121T132816 crosscheck;
}

set DBID=3325602173
set DBID=1713322190
set dbid 1713322190;


run {
allocate channel ch01 device type disk;
crosscheck backup tag TAG20241121T132816;
delete noprompt expired backup;
crosscheck copy;
delete noprompt expired copy;
release channel ch01;
}

restore controlfile to '/tmp/control_file_01.bak' from TAG=TAG20241121T132816;

-- crosscheck
run {
ALLOCATE CHANNEL t1  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t2  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t3  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t4  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t5  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t6  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t7  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t8  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t9  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t16 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t17 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t18 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t19 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';
ALLOCATE CHANNEL t20 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-7jrgw1.rootbrasil.intranet)';

crosscheck backup;
crosscheck archivelog all;
delete expired archivelog all;
delete expired backup;
}

run {
ALLOCATE CHANNEL c1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c11 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL c15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
DELETE OBSOLETE;
}

DELETE OBSOLETE;
crosscheck copy;
crosscheck backup;
crosscheck archivelog all;

-- crosscheck
run {
allocate channel for maintenance type 'SBT_TAPE';
crosscheck backupset of database;
}

run {
crosscheck archivelog all;
delete expired archivelog all;
}

-- config padrão do exadata KIPREV PRD
CONFIGURE RETENTION POLICY TO REDUNDANCY 15;
CONFIGURE BACKUP OPTIMIZATION OFF;
CONFIGURE DEFAULT DEVICE TYPE TO 'DISK';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/tmp/%F';
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE 'SBT_TAPE' TO '%F';
CONFIGURE DEVICE TYPE DISK PARALLELISM 10 BACKUP TYPE TO BACKUPSET;
CONFIGURE DEVICE TYPE 'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1;
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE 'SBT_TAPE' TO 1;
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE 'SBT_TAPE' TO 1;
CONFIGURE MAXSETSIZE TO 32 G;
CONFIGURE ENCRYPTION FOR DATABASE OFF;
CONFIGURE ENCRYPTION ALGORITHM 'AES256';
CONFIGURE COMPRESSION ALGORITHM 'LOW' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE;
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS;
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+DATAC1/kpvprd/controlfile/snapcf_kpvprd.f';


CONFIGURE RETENTION POLICY TO NONE;

ALLOCATE CHANNEL t1  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,
ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';


run {
ALLOCATE CHANNEL t1  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t2  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t3  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t4  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t5  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t6  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t7  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t8  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t9  TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t12 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t13 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t14 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t15 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t16 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t17 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t18 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t19 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
ALLOCATE CHANNEL t20 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=orakpvhm1,NB_ORA_POLICY=ORA_CVP_HML,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=exacc01-kpv-prd-db01)';
crosscheck backup;
crosscheck archivelog all;
delete expired archivelog all;
delete expired backup;
}


ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';



run {
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch2 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch3 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch4 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch5 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch6 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch7 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch8 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch9 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
ALLOCATE CHANNEL ch10 TYPE 'SBT_TAPE' PARMS 'SBT_LIBRARY=/usr/openv/netbackup/bin/libobk.so64,ENV=(NB_ORA_SID=kpvprd1,NB_ORA_POLICY=ORAC_CPV_KIPREV_PROD,NB_ORA_SERV=cvpnbuprimary01.adcorp.intranet,NB_ORA_CLIENT=kpvprd_3325602173)';
restore archivelog from logseq=147241 until logseq=147425 thread 1;
restore archivelog from logseq=240692 until logseq=240969 thread 2;
release channel c1;
}


-- backup full + archivelog para disco,
run
{
allocate channel c1 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c2 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c3 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c4 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c5 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c6 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c7 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c8 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c9 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c10 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c11 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c12 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c13 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c14 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c15 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c16 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c17 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c18 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c19 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';
allocate channel c20 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_archivelog_kpv_%U.rman';

sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE for standby;
backup as compressed backupset incremental level 0 database format '/backup_acfs/bkp_kpvprd_dr/BKP_FULL_%d_%u_%s_%T.rman' tag BKP_FULL_KPV;
sql 'alter system switch logfile';
sql 'alter system checkpoint';
sql 'alter system archive log current';
BACKUP FORMAT '/backup_acfs/bkp_kpvprd_dr/BKP_CONTROLFILE_%d_%u_%s_%T.rman' tag BKP_CONTROLFILE_KPVPRD CURRENT CONTROLFILE for standby
spfile format '/backup_acfs/bkp_kpvprd_dr/BKP_SPFILE_%d_%u_%s_%T.rman' tag BKP_SPFILE_KPV
plus archivelog format '/backup_acfs/bkp_kpvprd_dr/BKP_ARCH_%d_%u_%s_%T.rman' tag BKP_ARCH_KPV;
}
