-- verifica conigurações do RMAN
select * from v$rman_configuration;

     CONF# NAME                                                              VALUE                                                            CON_ID
---------- ----------------------------------------------------------------- ------------------------------------------------------------ ----------
         1 RETENTION POLICY                                                  TO REDUNDANCY 15                                                      0
         2 DEVICE TYPE                                                       DISK PARALLELISM 10 BACKUP TYPE TO BACKUPSET                          0
         4 BACKUP OPTIMIZATION                                               OFF                                                                   0
         5 DEFAULT DEVICE TYPE TO                                            'DISK'                                                                0
         6 CONTROLFILE AUTOBACKUP                                            OFF                                                                   0
         7 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     DISK TO '/tmp/%F'                                                     0
         8 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     'SBT_TAPE' TO '%F'                                                    0
         9 DEVICE TYPE                                                       'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1          0
        10 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            DISK TO 1                                                             0
        11 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            'SBT_TAPE' TO 1                                                       0
        12 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          DISK TO 1                                                             0
        13 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          'SBT_TAPE' TO 1                                                       0
        14 MAXSETSIZE TO                                                     32 G                                                                  0
        15 ENCRYPTION FOR DATABASE                                           OFF                                                                   0
        16 ENCRYPTION ALGORITHM                                              'AES128'                                                              0
        17 COMPRESSION ALGORITHM                                             'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE                0
        18 RMAN OUTPUT                                                       TO KEEP FOR 7 DAYS                                                    0
        19 ARCHIVELOG DELETION POLICY                                        TO NONE                                                               0


-- altera o parametro desejado, nesse caso é o TO REDUNDANCY.
DECLARE
x NUMBER;
BEGIN
x := dbms_backup_restore.setconfig('RETENTION POLICY','TO REDUNDANCY 120');
dbms_output.put_line('setconfig returned ' || x);
END;
/

-- apos alteração.
     CONF# NAME                                                              VALUE                                                            CON_ID
---------- ----------------------------------------------------------------- ------------------------------------------------------------ ----------
         1 RETENTION POLICY                                                  TO REDUNDANCY 15                                                      0
         2 DEVICE TYPE                                                       DISK PARALLELISM 10 BACKUP TYPE TO BACKUPSET                          0
         3 RETENTION POLICY                                                  TO REDUNDANCY 120                                                     0
         4 BACKUP OPTIMIZATION                                               OFF                                                                   0
         5 DEFAULT DEVICE TYPE TO                                            'DISK'                                                                0
         6 CONTROLFILE AUTOBACKUP                                            OFF                                                                   0
         7 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     DISK TO '/tmp/%F'                                                     0
         8 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     'SBT_TAPE' TO '%F'                                                    0
         9 DEVICE TYPE                                                       'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1          0
        10 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            DISK TO 1                                                             0
        11 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            'SBT_TAPE' TO 1                                                       0
        12 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          DISK TO 1                                                             0
        13 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          'SBT_TAPE' TO 1                                                       0
        14 MAXSETSIZE TO                                                     32 G                                                                  0
        15 ENCRYPTION FOR DATABASE                                           OFF                                                                   0
        16 ENCRYPTION ALGORITHM                                              'AES128'                                                              0
        17 COMPRESSION ALGORITHM                                             'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE                0
        18 RMAN OUTPUT                                                       TO KEEP FOR 7 DAYS                                                    0
        19 ARCHIVELOG DELETION POLICY                                        TO NONE                                                               0


-- como a configuração já existe provavel que vai precisar deletar a antiga para não gerar erro no rman

exec DBMS_BACKUP_RESTORE.DELETECONFIG(1);

-- apos delete fica a nova configuração.
     CONF# NAME                                                              VALUE                                                            CON_ID
---------- ----------------------------------------------------------------- ------------------------------------------------------------ ----------
         2 DEVICE TYPE                                                       DISK PARALLELISM 10 BACKUP TYPE TO BACKUPSET                          0
         3 RETENTION POLICY                                                  TO REDUNDANCY 120                                                     0
         4 BACKUP OPTIMIZATION                                               OFF                                                                   0
         5 DEFAULT DEVICE TYPE TO                                            'DISK'                                                                0
         6 CONTROLFILE AUTOBACKUP                                            OFF                                                                   0
         7 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     DISK TO '/tmp/%F'                                                     0
         8 CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE                     'SBT_TAPE' TO '%F'                                                    0
         9 DEVICE TYPE                                                       'SBT_TAPE' BACKUP TYPE TO COMPRESSED BACKUPSET PARALLELISM 1          0
        10 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            DISK TO 1                                                             0
        11 DATAFILE BACKUP COPIES FOR DEVICE TYPE                            'SBT_TAPE' TO 1                                                       0
        12 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          DISK TO 1                                                             0
        13 ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE                          'SBT_TAPE' TO 1                                                       0
        14 MAXSETSIZE TO                                                     32 G                                                                  0
        15 ENCRYPTION FOR DATABASE                                           OFF                                                                   0
        16 ENCRYPTION ALGORITHM                                              'AES128'                                                              0
        17 COMPRESSION ALGORITHM                                             'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE                0
        18 RMAN OUTPUT                                                       TO KEEP FOR 7 DAYS                                                    0
        19 ARCHIVELOG DELETION POLICY                                        TO NONE                                                               0

-- dentro do rman

show all

CONFIGURE RETENTION POLICY TO REDUNDANCY 120;
CONFIGURE BACKUP OPTIMIZATION OFF;
CONFIGURE DEFAULT DEVICE TYPE TO 'DISK';
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
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
CONFIGURE ENCRYPTION ALGORITHM 'AES128';
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE;
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS;