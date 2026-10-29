--- Recover table com RMAN
recover table KIPREV.PA_FAIXA_DETALHE
UNTIL TIME "to_date('10/09/2026 22:00:00','DD/MM/YYYY hh24:mi:ss')"
AUXILIARY DESTINATION '/acfs_backup/recover_tabela'
DATAPUMP DESTINATION '/acfs_backup/restore_tabela'
DUMP FILE 'restore_table_PA_FAIXA_DETALHE.dmp'
NOTABLEIMPORT;

-- caso necessário exportar os dados databela atual antes.
expdp \'/ as sysdba \' directory=DUMP DUMPFILE=restore_table_PA_FAIXA_DETALHE.dmp LOGFILE=expdp_table.log
TABLES=KIPREV.PA_FAIXA_DETALHE
TO_DATE('260520','ddmmyy')  

-- fazer o import do dump gerado pelo rman, para isso usar o comando abaixo:
impdp \'/ as sysdba \' directory=DUMP DUMPFILE=restore_table_PA_FAIXA_DETALHE.dmp LOGFILE=impdp_table_PA_FAIXA_DETALHE.log 
remap table kiprev.pa_faixa_detalhe:kiprev.pa_faixa_detalhe ; 

