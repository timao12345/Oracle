
-- drop scheduler
exec DBMS_SCHEDULER.DROP_JOB (job_name => 'sys.kill_lock_inativa2', force => TRUE);

-- rodar scheduler
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'DOVEMAIL.DBMS_JOB$_650',
    USE_CURRENT_SESSION => FALSE);
END;
/

-- Run job.
BEGIN
  DBMS_SCHEDULER.run_job (job_name=> 'SYS.KILL_LOCK_INATIVA', use_current_session=> FALSE); 
END;
/

BEGIN
  DBMS_SCHEDULER.run_job (job_name=> 'SYS.KILL_LOCK_INATIVA2'); 
END;
/

KILL_LOCK_INATIVA2
KILL_LOCK_INATIVA

-- STOP SCHEDULER.
begin
  DBMS_SCHEDULER.stop_job (job_name => 'KPVCUST04.MV_RF$J_0_S_69602', force => TRUE);
end;
/
--DBMS_SCHEDULER.stop_job (job_name => 'SYS.ORA$AT_SA_SPC_SY_50138', force => TRUE);
                             

exec sys.dbms_scheduler.stop_job(job_name=>'SYS.KILL_LOCK_INATIVA', force=>true);

-- ativar scheduler

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY HH24:MI';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-RR HH24:MI';
exec DBMS_SCHEDULER.enable ('AJURI.JOB_ATUALIZA_RETORNO_SGD');

-- desabilitar scheduler 
ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY HH24:MI';
exec DBMS_SCHEDULER.disable ('SYS.KILL_LOCK_INATIVA');

exec DBMS_SCHEDULER.enable ('SYS.KILL_LOCK_INATIVA');
KILL_USER_OCIOSO
KILL_LOCK_INATIVA

-- copiar scheduler 
exec dbms_scheduler.copy_job('DBSKYONE_IMPDP.DBMS_JOB$_122','CONSINCO.DBMS_JOB$_122');

SELECT OWNER,OBJECT_NAME, OBJECT_TYPE FROM DBA_OBJECTS WHERE OBJECT_NAME LIKE '%ATUALIZA_PRECO_TLV%';

select OWNER, TABLE_NAME from ALL_TABLES where table_name in ('DWT_ITENS_MERC','DWT_DOCTO_FISCAL','DWT_ITENS_SERV')and owner = 'USRMSAF';

-- JOBS SCHEDULER
set lines 900 pages 5000
clear columns
col owner			    for a15
col job_name 			for a30
col start_date			for a25
col last_start_date		for a10
col next_run_date		for a35
col last_run_duration 	for 10
set colsep '|'
SELECT OWNER
  ,INSTANCE_ID
	,JOB_NAME
	,SCHEDULE_TYPE
  ,to_char(START_DATE,'DD/MM/YY HH24:MI') as "START"
	,ENABLED
	,STATE
	,to_char(LAST_START_DATE,'DD/MM/YY HH24:MI')LAST_START
	,to_char(NEXT_RUN_DATE,'DD/MM/YY HH24:MI')NEXT_RUN
  ,to_char(end_date,'DD/MM/YY HH24:MI')END_DATE
	,to_char(LAST_RUN_DURATION,'HH24:MI')LAST_RUN_DURATION
	,FAILURE_COUNT
FROM DBA_SCHEDULER_JOBS
where job_name like 'MV_RF$J_0_S_69602';
where owner ='RDWMS17CON';

KILL_USER_OCIOSO
KILL_LOCK_INATIVA

SELECT --OWNER
	JOB_NAME
	,JOB_CREATOR
	--,PROGRAM_NAME
	,JOB_ACTION
	,STATE
  ,to_char(START_DATE,'DD/MM/YY HH24:MI') as "START"
	--,REPEAT_INTERVAL
	,ENABLED
	--,RUN_COUNT
	--,to_char(LAST_START_DATE,'DD/MM/YY HH24:MI') as LAST_START_DATE
  --,to_char(NEXT_RUN_DATE,'DD/MM/YY HH24:MI') as NEX_DATE
	--,COMMENTS
	--,LAST_RUN_DURATION
	--FAILURE_COUNT
	--,MAX_FAILURES
FROM DBA_SCHEDULER_JOBS
where job_name ='KILL_USER_OCIOSO';

SELECT --OWNER
	JOB_NAME
	,JOB_CREATOR
	,PROGRAM_NAME
	,JOB_ACTION
	,STATE
  ,to_char(START_DATE,'DD/MM/YY HH24:MI') as "START"
	--,REPEAT_INTERVAL
	,ENABLED
	--,RUN_COUNT
	--,to_char(LAST_START_DATE,'DD/MM/YY HH24:MI') as LAST_START_DATE
  --,to_char(NEXT_RUN_DATE,'DD/MM/YY HH24:MI') as NEX_DATE
	,COMMENTS
	--,LAST_RUN_DURATION
	--FAILURE_COUNT
	--,MAX_FAILURES
FROM DBA_SCHEDULER_JOBS
where job_name like 'MV_RF$J_0_S_69602%';

-- scheduler running
col owner for a25
col JOB_NAME for a35
select OWNER,JOB_NAME,SESSION_ID,to_char(ELAPSED_TIME,'HH24:MI'),SLAVE_PROCESS_ID,SLAVE_OS_PROCESS_ID
from  DBA_SCHEDULER_RUNNING_JOBS t;
where JOB_NAME = 'KILL_LOCK_INATIVA';

-- historico do scheduler --
col job_name for a35
col job_class for a30
col OPERATION for a7
SELECT to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name,job_class, operation, status ,ADDITIONAL_INFO
FROM DBA_SCHEDULER_JOB_LOG
WHERE job_name like '%MV_RF$J_0_S_69602%' ORDER BY 1;
where log_date> sysdate -1 ORDER BY log_date;



col job_name for a25
col ADDITIONAL_INFO for a55
col status for a15
col RUN_DURATION for a10
col job_name for a35
SELECT owner,to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, to_char(RUN_DURATION, 'HH24:MI:SS') Duration,job_name, status,additional_info
FROM dba_scheduler_job_run_details 
where  log_date> sysdate - 1/24
and job_name like 'KILL_LOCK_INATIVA2%' 
ORDER BY log_date;

KILL_USER_OCIOSO
KILL_LOCK_INATIVA

-- scheduler status failed
col job_name for a30
col ADDITIONAL_INFO for a55
col status for a10
col owner for a20
set lines 750 pages 50000
SELECT owner,to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status,additional_info
FROM dba_scheduler_job_run_details 
where status !='SUCCEEDED' AND log_date> sysdate -1
and job_name like '%KILL_LOCK_INATIVA%'
ORDER BY log_date;

KILL_USER_OCIOSO

col job_name for a30
col ADDITIONAL_INFO for a55 
col status for a10
col owner for a20
set lines 750 pages 50000
SELECT owner,to_char(log_date, 'DD-MON-YY HH24:MI:SS') TIMESTAMP, job_name, status,additional_info
FROM dba_scheduler_job_run_details 
where log_date> sysdate -10
and job_name ='KILL_LOCK_INATIVA2'
order by 2;

KILL_LOCK_INATIVA
KILL_USER_OCIOSO

-- scheduler agruparmento por quantidade de falhas
col job_name for a30
col ADDITIONAL_INFO for a55
col status for a10
col owner for a20
set lines 750 pages 50000
SELECT owner, job_name, status, count(job_name) QTD_Fail, additional_info
FROM dba_scheduler_job_run_details 
where status ='FAILED' AND log_date> sysdate -2
group by owner,job_name,status,additional_info
ORDER BY log_date;
--and job_name like '%JOB_INTEGRACAO_CONTABIL_MAMBO%' 
-- Verifica se está schedulado
SELECT * FROM DBA_SCHEDULER_JOBS WHERE JOB_NAME = 'JOB_MONITORAMENTO';

-- DDL DO SCHEDULLER JOB
set pagesize 2999
set lines 850
set long 999
col DDL for a5000p
select dbms_metadata.get_ddl('PROCOBJ','JOB_MONITOR_TAB_SAP','VIMERSON') as DDL from dual;

RDWMS17CONJob:
/* PURGE_ARCHIVE_MANH_TABLES_JOB */
begin wm_archive_pkg.ui_purge(p_purge_config_ids => '50, 51, 52, 53, 54, 55, 56, 57, 58, 59');end;/

begin                                   
   wm_archive_pkg.ui_purge(p_purge_config_ids => '21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,122,142,143,144,145');      
end;                                    

BEGIN
dbms_scheduler.create_job('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS"',
job_type=>'PLSQL_BLOCK', 
job_action=>'P_CASA_CLIENTE_DADOS_TECNICOS_TT11957;', 
number_of_arguments=>0,
start_date=>TO_TIMESTAMP_TZ('29-NOV-2022 08.20.00.000000000 PM ETC/GMT+3','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), 
repeat_interval=>'FREQ=HOURLY;INTERVAL=1;BYMINUTE=20', 
end_date=>NULL,
job_class=>'"DEFAULT_JOB_CLASS"', 
enabled=>FALSE, 
auto_drop=>TRUE,
comments=>'Update Offline Tables For Casa Cliente. Every 60 minutes!'
);
sys.dbms_scheduler.set_attribute('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS"','NLS_ENV
','NLS_LANGUAGE=''AMERICAN'' NLS_TERRITORY=''AMERICA'' NLS_CURRENCY=''$''NLS_ISO
_CURRENCY=''AMERICA''NLS_NUMERIC_CHARACTERS=''.,'' NLS_CALENDAR=''GREGORIAN''NLS
_DATE_FORMAT=''DD-MON-RR'' NLS_DATE_LANGUAGE=''AMERICAN'' NLS_SORT=''BINARY''NLS
_TIME_FORMAT=''HH.MI.SSXFF AM'' NLS_TIMESTAMP_FORMAT=''DD-MON-RR HH.MI.SSXFFAM''
 NLS_TIME_TZ_FORMAT=''HH.MI.SSXFF AM TZR'' NLS_TIMESTAMP_TZ_FORMAT'


set pagesize 299
set long 999
select dbms_metadata.get_ddl('PACKAGE','PKG_GERENCIALPDV','DEPLOY') from dual;

-- alterar o intervalo freq pode ser daily, hour, minutely, exemplo abaixo job alterado para executar a cada 10 minutos
begin
dbms_scheduler.set_attribute (
name               =>  'AUDITORIA.JOB_USER_OCIOSO',
attribute          =>  'repeat_interval',
value              =>  'freq=MINUTELY; interval=10');
end;
/

--Altera inicio do job
begin
dbms_scheduler.set_attribute (
name               =>  'AUDITORIA.JOB_USER_OCIOSO',
attribute          =>  'start_date',
value              =>  '10-JUL-24 10.40.00 AM');
end;
/

-- criar schedulers.

alter session set current_schema=OWNER;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';

begin
DBMS_SCHEDULER.create_job (
    job_name        => 'CONSINCO.JOB_TELEVENDAS',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'Codigo pl-sql',
    start_date      => '09-JUL-21 05.00.00 AM',
    repeat_interval => 'freq=daily; byhour=5;',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'JOB Televendas solicitado pelo cliente ticket 528493');
end;
/

alter session set current_schema = GSRETAIL;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YY HH24:MI:SS';
begin
DBMS_SCHEDULER.create_job (
    job_name        => 'GSRETAIL.TESTE01_LS',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'exec gs_pkg_integracao_gerencial.integrarMovimentoDia;',
    start_date      => '04-JUL-22 12.00.00 PM',
    repeat_interval => 'freq=daily; byhour=5;',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => 'Execucao diaria 30 em 30 min');
end;
/

BYMINUTE=30

repeat_interval => 'freq=MINUTELY;interval=30',

---- // ----
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';

begin
DBMS_SCHEDULER.create_job (
    job_name        => 'CONSINCO.DBMS_JOB$_201',
    job_type        => 'PLSQL_BLOCK',
    job_action      => 'begin
      for t in (select DISTINCT a.nroempresa, a.dtamovimento
                  from PDVV_CUPOMFISCAL a
                  where A.indexportacaofisci = ''I''
                  and a.dtamovimento > ''01-sep-2016''
                  group by a.nroempresa, a.dtamovimento)
      loop
        pkg_adm_integracao.sp_gera_c5corp_tribute_ecf(t.nroempresa,t.dtamovimento,null);
      end loop;
      commit;
      FOR T IN (SELECT * FROM rf_auxcupomeletronico x)
          LOOP
                pkg_rfintegracaocupomeletr.rfp_integrar(t.seqcupom,''I'',T.NROEMPRESA, ''01-jan-2000'',''31-dec-2999'',''CONSINCO'');
        commit;
          end loop;
      commit;
    end;',
    start_date      => '29-JUN-22 11.00.00 AM',
    repeat_interval => 'freq=daily; byhour=4;',
    end_date        => NULL,
    enabled         => TRUE,
    comments        => '--INTEGRACAO CUPONS SAT, --Criado em 20/10/2016 por Lourent Silva --Execuc?o diaria as 4 horas');
end;
/



 -- exemplo de criação de scheduler.
BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name            => 'NOME_DO_OWNER.NOME_DO_SCHEDULER',
    job_type            => 'TIPO DE SCHEDULER, NO GERAL USA-SE O PLSQL_BLOCK PARA JOBS/SCHEDULERS',
    job_action          => 'O QUE O SCHEDULER IRÁ FAZER',
  	start_date		     	=> 'HORÁRIO DE SUA PRIMEIRA EXECUÇÃO',
    repeat_interval     => 'INTERVALO DE REPETIÇÃO DE ACORDO COM O HORÁRIO DA PRIMEIRA EXECUÇÃO',
	  enabled			      	=> 'SE ELE SERÁ CRIADO E JÁ ESTARÁ ATIVO OU NÃO',
    auto_drop           => 'SE ELE VAI SER DROPADO AUTOMATICAMENTE',
    comments            => 'SESSÃO PARA COMENTÁRIOS'
  );
END;
/


BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
    job_name            => 'CONSINCO.INTEGRA_NF_COMERCIAL_FISCAL',
    job_type             => 'PLSQL_BLOCK',
    job_action           => '',
	start_date			      => '28-FEV-22 17.15.00 AM -03:00',
    repeat_interval     => 'FREQ=DAILY; BYHOUR=02; BYMINUTE=00',
	  enabled				      => TRUE,
    auto_drop           => FALSE,
    comments            => ''
  );
END;
/

DECLARE V_DATA_INICIAL DATE := SYSDATE-10; 
V_DATA_FINAL DATE := SYSDATE; 
V_DATA DATE := V_DATA_INICIAL; 
BEGIN 
   WHILE V_DATA <= V_DATA_FINAL LOOP SP_CALC_SALDO_NUMERARIO_JOB(NULL,V_DATA,NULL,NULL,NULL); 
   V_DATA := V_DATA + 1;
END LOOP; 
V_DATA := V_DATA_INICIAL; 
END;

-- modificar job
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE
  (
   NAME         =>  'CONSINCO.JOB_PRECO_ECOMMERCE',
   ATTRIBUTE    =>  'repeat_interval',
   VALUE        =>  'codigo pl-sql'
  );
END;



-- scheduler executando de 1 em 1 hora a partir do start_date
BEGIN
  dbms_scheduler.create_job('NETWIN_SOL.UPDATE_CASA_CLIENTE_DADOS_TECNICOS_BKP',
  job_type=>'PLSQL_BLOCK', 
  job_action=>'P_CASA_CLIENTE_DADOS_TECNICOS_TT11957;', 
  number_of_arguments=>0,
  start_date=>TO_TIMESTAMP_TZ('29-NOV-2022 08.20.00 PM ETC/GMT+3','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'),  
  repeat_interval => 'FREQ=HOURLY;INTERVAL=1',
  end_date=>NULL,
  job_class=>'"DEFAULT_JOB_CLASS"', 
  enabled=>FALSE, 
  auto_drop=>TRUE,
  comments=>
  'Update Offline Tables For Casa Cliente. Every 60 minutes!'
  );
  sys.dbms_scheduler.set_attribute('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS_BKP"','NLS_ENV','NLS_LANGUAGE=''AMERICAN'' NLS_TERRITORY=''AMERICA'' NLS_CURRENCY=''$''NLS_ISO_CURRENCY=''AMERICA''NLS_NUMERIC_CHARACTERS=''.,'' NLS_CALENDAR=''GREGORIAN''NLS_DATE_FORMAT=''DD-MON-RR'' NLS_DATE_LANGUAGE=''AMERICAN'' NLS_SORT=''BINARY''NLS_TIME_FORMAT=''HH.MI.SSXFF AM'' NLS_TIMESTAMP_FORMAT=''DD-MON-RR HH.MI.SSXFFAM'' NLS_TIME_TZ_FORMAT=''HH.MI.SSXFF AM TZR'' NLS_TIMESTAMP_TZ_FORMAT=''DD-MON-RR HH.MI.SSXFF AM TZR'' NLS_DUAL_CURRENCY=''$'' NLS_COMP=''BINARY'' NLS_LENGTH_SEMANTICS=''BYTE'' NLS_NCHAR_CONV_EXCP=''FALSE''');
  dbms_scheduler.enable('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS_BKP"');
COMMIT;
END;
/


-- altera atributo do start date.
BEGIN
  DBMS_SCHEDULER.set_attribute (
    name      => 'NETWIN_SOL.UPDATE_CASA_CLIENTE_DADOS_TECNICOS',
    attribute => 'start_date',
    value     => TO_TIMESTAMP_TZ('01-DEC-2022 12.20.00 AM ETC/GMT+3','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english')
    );
END;
/

-- altera atributo do repeat_interval para hora em hora
BEGIN
  DBMS_SCHEDULER.SET_ATTRIBUTE
  (
   NAME         =>  'sys.KILL_LOCK_INATIVA2',
   ATTRIBUTE    =>  'repeat_interval',
   VALUE        =>  'FREQ=MINUTELY;INTERVAL=2'
  );
END;
/



BEGIN
  dbms_scheduler.create_job('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS"',
  job_type=>'PLSQL_BLOCK', job_action=>'P_CASA_CLIENTE_DADOS_TECNICOS_TT11957;', 
  number_of_arguments=>0,
  start_date=>TO_TIMESTAMP_TZ('29-NOV-2022 08.20.00.000000000 PM ETC/GMT+3','DD-MON-RRRR HH.MI.SSXFF AM TZR','NLS_DATE_LANGUAGE=english'), 
  repeat_interval=>'FREQ=HOURLY;INTERVAL=1;BYMINUTE=20', 
  end_date=>NULL,
  job_class=>'"DEFAULT_JOB_CLASS"', 
  enabled=>FALSE, 
  auto_drop=>TRUE,
  comments=>'Update Offline Tables For Casa Cliente. Every 60 minutes!'
);

sys.dbms_scheduler.set_attribute('"UPDATE_CASA_CLIENTE_DADOS_TECNICOS"','NLS_ENV','NLS_LANGUAGE=''AMERICAN'' NLS_TERRITORY=''AMERICA'' NLS_CURRENCY=''$''NLS_ISO_CURRENCY=''AMERICA''NLS_NUMERIC_CHARACTERS=''.,'' NLS_CALENDAR=''GREGORIAN''NLS_DATE_FORMAT=''DD-MON-RR'' NLS_DATE_LANGUAGE=''AMERICAN'' NLS_SORT=''BINARY''NLS_TIME_FORMAT=''HH.MI.SSXFF AM'' NLS_TIMESTAMP_FORMAT=''DD-MON-RR HH.MI.SSXFFAM'' NLS_TIME_TZ_FORMAT=''HH.MI.SSXFF AM TZR'' NLS_TIMESTAMP_TZ_FORMAT

