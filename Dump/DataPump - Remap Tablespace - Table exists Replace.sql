select owner, segment_name, sum(bytes)/1024/1024/1024 object_size 
from dba_segments 
where segment_name in('NIMBI_REQUISICAO',
'NIMBI_PEDIDO_RESUMIDO',
'ORCAMENTO_TRAVA',
'SAP_COEP',
'SAP_COOI',
'SAP_CSKS',
'TAB_CONTAS_PACOT_TRV_ORC',
'DE_PARA_CENTRO_CUSTO') 
group by owner,segment_name; 
 

 
select owner, object_name, created from dba_objects 
where object_name in('NIMBI_REQUISICAO',
'NIMBI_PEDIDO_RESUMIDO',
'ORCAMENTO_TRAVA',
'SAP_COEP',
'SAP_COOI',
'SAP_CSKS',
'TAB_CONTAS_PACOT_TRV_ORC',
'DE_PARA_CENTRO_CUSTO');  

--SCHEMAS=EDOCS 

nohup expdp \'/as sysdba \'  DIRECTORY=C7328566 dumpfile=T7326545_full.dmp logfile=LOG_T7326545.log full=Y &

nohup expdp '"/ as sysdba"' directory=RS00568969 dumpfile=RS00568969_sabre_full_%U.dmp logfile=RS00568969_sabre_full.log filesize=10G full=Y &


-- &

nohup impdp \'/as sysdba \' directory=EXP dumpfile=RS00571265_biprddat.dmp LOGFILE=LOG_import_RS00571265_biprddat.log TABLE_EXISTS_ACTION=REPLACE REMAP_TABLESPACE=BI_ODS_I_01:ODS_I_01 TABLES=BI_ODS.NIMBI_REQUISICAO,BI_ODS.NIMBI_PEDIDO_RESUMIDO,BI_ODS.ORCAMENTO_TRAVA,BI_ODS.SAP_COEP,BI_ODS.SAP_COOI,BI_ODS.SAP_CSKS,BI_ODS.TAB_CONTAS_PACOT_TRV_ORC,BI_ODS.DE_PARA_CENTRO_CUSTO &


impdp hr TABLES=employees DIRECTORY=dpump_dir1 DUMPFILE=expfull.dmp TABLE_EXISTS_ACTION=REPLACE


nohup sqlplus "/ as sysdba" @teste.sql


begin
    execute immediate ""
end

execute immediate "select INSTANCE_NUMBER,INSTANCE_NAME,HOST_NAME,TO_CHAR(STARTUP_TIME, 'DD/MM/YYYY HH24:MI:SS') as STARTUP,STATUS,DATABASE_STATUS,ARCHIVER from v$instance"