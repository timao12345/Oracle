-- *** VALIDAR ANTES SE O SISTEMA OPERACIONAL ESTA COM SUPORTE DE I/O ASSINCRONO HABILITADO ***

show parameter FILESYSTEMIO_OPTIONS

-- Verifique se os datafiles estao com escrita assincrona habilitada. Se nao estiverem, verifique alem do FILESYSTEMIO_OPTIONS se o valor de disk_asynshow ch_io esta igual a FALSE (o padrao eh TRUE).
SELECT  name, asynch_io 
FROM    v$datafile f,v$iostat_file i
WHERE   f.file#        = i.file_no
AND     filetype_name  = 'Data File';

-- mudar para o cdb:
alter session set container=cdb$root;

-- ver antes de I/O assincrono esta habilitado (disk_asynch_io=true):
show parameter disk_asynch_io

-- ************** NAO CONFIGURE ISSO AGORA, DEIXE PARA FAZER DURANTE OS EXERCICIOS DO FINAL DO CAPITULO **************

-- para habilitar a escrita assincrona configure filesystemio_options com valor igual a ASYNCH ou SETALL (assync + direct I/O)
ALTER SYSTEM SET FILESYSTEMIO_OPTIONS=SETALL SCOPE=SPFILE;

-- reinicie o BD:
SQL>    shut immediate;
SQL>    startup

-- Verifique se os datafiles ja estao com escrita assincrona habilitada. Se nao estiverem, verifique se o valor de disk_asynch_io esta igual a FALSE (o padrao eh TRUE).
SELECT  name, asynch_io 
FROM    v$datafile f,v$iostat_file i
WHERE   f.file#        = i.file_no
AND     filetype_name  = 'Data File';

/* Para ver se o SO Linux esta habilitado com I/O assync:
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/5/html/Tuning_and_Optimizing_Red_Hat_Enterprise_Linux_for_Oracle_9i_and_10g_Databases/sect-Oracle_9i_and_10g_Tuning_Guide-Enabling_Asynchronous_IO_and_Direct_IO_Support-Verifying_Asynchronous_IO_Usage.html
*/