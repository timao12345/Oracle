

SCD ----------

- verificar no banco standby onde ele parou !
select current_scn from v$database;


- realizar o backup incremental na base origem 

BACKUP INCREMENTAL FROM SCN 82963220911   <--- esse valor � obtido na query anterior !!!
DATABASE FORMAT '/ora/backup/ForStandby_%d_%U' tag 'FORSTANDBY' ;
- backup do controlfile


backup device type disk current controlfile for standby format '/ora/backup/ForStandbyControl.bkp' ;

- transmitir os backups para maquina standby
scp ForStan* root@192.168.249.179:/ora/.

-- Standby

- parar a replicação
  alter database recover managed standby database cancel;

- catalogar backuppieces -- esse comando abaixo é GAMBIs, por causa de um BUG do oracle na hora de catalogar os backuppieces (10.2.0.3)
  alter system set optimizer_secure_view_merging =false;

catalog backuppiece '/ora/ForStandby_SPSCD_klne0i4l_1_1';                                                                                                         
catalog backuppiece '/ora/ForStandby_SPSCD_kmne0i4m_1_1'; 
catalog backuppiece '/ora/ForStandby_SPSCD_kkne0i4l_1_1';
catalog backuppiece '/ora/ForStandby_SPSCD_knne0i4m_1_1';                                                                                                         
catalog backuppiece '/ora/ForStandby_SPSCD_kone0jud_1_1';                                                                                                         
catalog backuppiece '/ora/ForStandby_SPSCD_kpne0jv1_1_1';

- voltar o parametro da GAMBIS para valor original
 alter system set optimizer_secure_view_merging =true;
                                                        
 
- aplicar o refresh
RMAN> recover database noredo;



- ANTES de restaurar o controlfile, salvar os NOMES dos datafiles no banco Standby
select FILE#,name from v$datafile ;

- restaurar o controlfile
 shutdown immediate ;
 startup nomount ;
 restore controlfile from '/ora/ForStandbyControl.bkp';
 alter database mount ;

 
Alter system set standby_file_management=manual;  <-- para poder renomear os datafiles ou recriar os standby redo logs

- dropar os standby redo logs antigos (que vieram no controlfile do banco original) 

alter database drop logfile group 5 ;
alter database drop logfile group 6 ;
alter database drop logfile group 7 ;
alter database drop logfile group 8 ;
alter database drop logfile group 9 ;

- recriar os standby logfiles 

alter database add standby logfile group 5 ('+REDO01', '+REDO02') size 500M ;
alter database add standby logfile group 6 ('+REDO01', '+REDO02') size 500M ;
alter database add standby logfile group 7 ('+REDO01', '+REDO02') size 500M ;
alter database add standby logfile group 8 ('+REDO01', '+REDO02') size 500M ;
alter database add standby logfile group 9 ('+REDO01', '+REDO02') size 500M ;

- se necessario, remomear os datafiles

select 'alter database rename file '''||name||''''  || 'to ;' from v$datafile ;

NAME
--------------------------------------------------------------------------------
alter database rename file '+DATA/spscd/datafile/system.266.753572833'  TO '+DATA/spscd_std/datafile/system.293.777866519';
alter database rename file '+DATA/spscd/datafile/undotbs1.258.753571533'  TO '+DATA/spscd_std/datafile/undotbs1.291.777866517';
alter database rename file '+DATA/spscd/datafile/sysaux.265.753572817'  TO '+DATA/spscd_std/datafile/sysaux.292.777866519';
alter database rename file '+DATA/spscd/datafile/users.267.753572849'  TO '+DATA/spscd_std/datafile/users.294.777866519';
alter database rename file '+DATA/spscd/datafile/drsys.270.753572855'  TO '+DATA/spscd_std/datafile/drsys.296.777866519';
alter database rename file '+DATA/spscd/datafile/indx.271.753572857'  TO '+DATA/spscd_std/datafile/indx.383.777866519';
alter database rename file '+DATA/spscd/datafile/tools.273.753572857'  TO '+DATA/spscd_std/datafile/tools.372.777872129';
alter database rename file '+DATA/spscd/datafile/xdb.274.753572857'  TO '+DATA/spscd_std/datafile/xdb.371.777872129';
alter database rename file '+DATA/spscd/datafile/sptransdata.281.753570687'  TO '+DATA/spscd_std/datafile/sptransdata.287.777866513';
alter database rename file '+DATA/spscd/datafile/sptransdata.280.753570687'  TO '+DATA/spscd_std/datafile/sptransdata.286.777866513';
alter database rename file '+DATA/spscd/datafile/sptransdata.256.753571533'  TO '+DATA/spscd_std/datafile/sptransdata.289.777866515';
alter database rename file '+DATA/spscd/datafile/sptransindex.260.753571537'  TO '+DATA/spscd_std/datafile/sptransindex.375.777872125';
alter database rename file '+DATA/spscd/datafile/sptransindex.259.753571537'  TO '+DATA/spscd_std/datafile/sptransindex.288.777866515';
alter database rename file '+DATA/spscd/datafile/sptransindex.268.753572233'  TO '+DATA/spscd_std/datafile/sptransindex.381.777871351';
alter database rename file '+DATA/spscd/datafile/logmnrts.284.753572859'  TO '+DATA/spscd_std/datafile/logmnrts.379.777871353';
alter database rename file '+DATA/spscd/datafile/sptransindex.261.753572233'  TO '+DATA/spscd_std/datafile/sptransindex.374.777872127';
alter database rename file '+DATA/spscd/datafile/sptransdata.282.753570687'  TO '+DATA/spscd_std/datafile/sptransdata.382.777871349';
alter database rename file '+DATA/spscd/datafile/sptransindex.262.753572233'  TO '+DATA/spscd_std/datafile/sptransindex.380.777871353';
alter database rename file '+DATA/spscd/datafile/sptransdata.279.753570691'  TO '+DATA/spscd_std/datafile/sptransdata.376.777872125';
alter database rename file '+DATA/spscd/datafile/sptransdata.263.753572339'  TO '+DATA/spscd_std/datafile/sptransdata.290.777866517';
alter database rename file '+DATA/spscd/datafile/sptransindex.264.753572815'  TO '+DATA/spscd_std/datafile/sptransindex.373.777872129';
alter database rename file '+DATA/spscd/datafile/expurgo.292.776772983'  TO '+DATA/spscd_std/datafile/expurgo.295.777866519';

Alter system set standby_file_management=auto; <-- voltar ao default depois de renomear os datafiles ou criar os standby redos

- reiniciar a inst�ncia
  shutdown immediate;
  startup mount ;
  
- colocar novamente em modo de aplicação de archives
alter database recover managed standby database disconnect from session;

- validar se ainda existe algum GAP !

SQL> select * from v$archive_gap ;

no rows selected


alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-686.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-686.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-687.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-687.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-688.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-688.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-689.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-689.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-690.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-690.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-691.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-691.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-692.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-692.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-693.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-693.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-694.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-694.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-695.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-695.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-696.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-696.dbf';
alter database create datafile '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-697.dbf' as '+DATAC1/KPVSTBY/DATAFILE/prd_data_d-orakpv_ts-kiprev_data1_fno-697.dbf';

 1150|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-685.dbf
 1151|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-686.dbf
 1152|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-687.dbf
 1153|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-688.dbf
 1154|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-689.dbf
 1155|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-690.dbf
 1156|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-691.dbf
 1157|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-692.dbf
 1158|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-693.dbf
 1159|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-694.dbf
 1160|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-695.dbf
 1161|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-696.dbf
 1162|+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-697.dbf


run {
allocate channel c1 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c2 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c3 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c4 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c5 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c6 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c7 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c8 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c9 type disk format  '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c10 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c11 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c12 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c13 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c14 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
allocate channel c15 type disk format '/backup_acfs/bkp_kpvprd_dr/bkp_kpvstby_%U.rman';
  set newname for datafile 1151 to '+DATAC1/KPVPRD/prd_data_d-orakpv_ts-kiprev_data1_fno-686.dbf';
  restore datafile 1151;
  switch datafile 1151;

}


  recover datafile 1150;



  
