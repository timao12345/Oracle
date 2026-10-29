----------------------------------------------------------------------------------------
-- VERIFICAR JOBS AGENDADOS NO DATABASE
----------------------------------------------------------------------------------------
-- Calcular o NEXT_DATE
-- Alterar a " 1/24" para o tempo que dejsa a proxima execução, abaixo seria um valor somando a data atual + 1h
alter session set nls_date_format='DD-MM-YYY HH24:MI:SS';
SELECT sysdate + 1/24 from dual; -- a cada 1h
select Trunc(Sysdate+1) + 5/24 from dual; -- 1x ao dia as 5h da madrugada

SELECT trunc(sysdate+1) + 1/289 from dual;


-- execute job
begin
  dbms_job.run(934225);
end;
/

exec SYS.DBMS_IJOB.RUN(934225);

-- remover 

EXEC DBMS_JOB.REMOVE(999);

--exec SYS.DBMS_IJOB.REMOVE(822);

-- tira o job do broken ou coloca em broken com TRUE

begin
   dbms_job.broken(892,TRUE);
   commit;
end;
/


select To_Char(trunc(sysdate+1)+ 23/24, 'DD/MM/YY HH24:MI:SS') hour from dual;

-- package DBMS_IJOB pode alterar jobs de outros usuarios.
exec SYS.DBMS_IJOB.BROKEN(3, TRUE);
commit;

exec SYS.DBMS_IJOB.BROKEN(1054,FALSE);
commit;

-- jobs em execução
col this_date for a11
col sid for 99999
col job for 99999999
col this_sec for a10
col WHAT for a80
SELECT v.Inst_Id INSTANCE
,v.Sid
,v.Id2 Job
,j.Failures
,Last_Date
,Substr(To_Char(Last_Date, 'HH24:MI:SS'), 1, 8) Last_Sec
,This_Date
,Substr(To_Char(This_Date, 'HH24:MI:SS'), 1, 8) This_Sec
,j.what
FROM Sys.Job$ j ,Gv$lock  v
WHERE v.Type = 'JQ'
AND j.Job(+) = v.Id2;

-- verifica job
col schema_user for a9
col hs for 9999
col fail for 9999
col broken for a2
col total_time for 9999999999
col DDL for a45
select INSTANCE,job, schema_user, 
  to_char(last_date,'DD/MM/YY HH24:MI:SS') last_date, 
  to_char(next_date,'DD/MM/YY HH24:MI:SS') NEXT_TIME, 
  total_time/60/60 as total_horas, broken, failures fail, what as DDL
from dba_jobs 
where what like '%FUNCIONARIO%'
where job = '&JOB'
order by job;

-- verifica o job com o conteudo do job (o codigo)
col schema_user for a9
col hs for 9999
col fail for 9999
col broken for a2
select job,next_date,next_sec,failures, broken,what as DESCRIPTION
from dba_jobs
where job = '&JOB'
order by job;

-- Verifica job broker
clear columns
set lines 750 pages 1000
col log_user for a11
col schema_user for a15
col PRIV_USER for a15
col total_time for 9999999999
col hs for 9999
col failures for 10
col broken for a2
col interval for a45
select job
,log_user 
,schema_user
--,PRIV_USER
--,to_char(last_date,'DD/MM/YY HH24:MI') last_date
--,to_char(next_date,'DD/MM/YY HH24:MI') NEXT_TIME
--,total_time toltime
--,(total_time)/60 hs
,broken
--,interval
,SUBSTR(what,1,600) DESCRIPTION
,failures fail 
from dba_jobs
where broken = 'Y'
order by job;

-- Verifica o job
SET LINESIZE 5555
SET PAGESIZE 5555
COL BROKEN FOR A10
COL WHAT FOR A90
COL SCHEMA_USER FOR A15
COL LAST_DATE FOR A18
COL THIS_DATE FOR A18
COL NEXT_DATE FOR A18
SELECT JOB
  ,INSTANCE
	,TO_CHAR(LAST_DATE,'DD-MM-YY HH24:MI:SS') AS LAST_DATE
	,LAST_SEC
	,TO_CHAR(THIS_DATE,'DD-MM-YY HH24:MI:SS') AS THIS_DATE
	,THIS_SEC
	,TO_CHAR(NEXT_DATE,'DD-MM-YY HH24:MI:SS') as NEXT_DATE
	,NEXT_SEC
	,BROKEN
  --,SUBSTR(what,1,80) DESCRIPTION
	,FAILURES
	,SUBSTR(what,1,60) DESCRIPTION
FROM DBA_JOBS
where JOB=11;
where FAILURES>0


SET LINESIZE 5555
SET PAGESIZE 5555
COL BROKEN FOR A10
COL WHAT FOR A90
COL SCHEMA_USER FOR A15
SELECT 
SID
,JOB       
,FAILURES  
,LAST_DATE 
,LAST_SEC  
,THIS_DATE 
,THIS_SEC  
,INSTANCE
FROM DBA_JOBS_RUNNING
where job=94074;

-- jobs em execução
col machine for a20
col WHAT for a45
select * from (
SELECT a.username
      ,a.osuser
      ,a.machine
      ,a.blocking_session
      ,a.sid
      ,a.serial#
      ,b.spid
      ,c.job
      --,c.what
  FROM gv$session        a
      ,gv$process        b
      ,dba_jobs         c
      ,dba_jobs_running d
 WHERE a.paddr = b.addr
   AND c.job = d.job
   AND a.sid IN (SELECT sid FROM dba_jobs_running)) where JOB=241711;
 
 -- Todos jobs em execução.
col machine for a20
col WHAT for a45
SELECT a.username
      ,a.osuser
      ,a.machine
      ,a.sid
      ,a.serial#
      ,b.spid
      ,c.job
      --,c.what
  FROM gv$session        a
      ,gv$process        b
      ,dba_jobs         c
      ,dba_jobs_running d
 WHERE a.paddr = b.addr
   AND c.job = d.job
   AND a.sid IN (SELECT sid FROM dba_jobs_running);

col machine for a20
col WHAT for a45
col OSUSER for a25
SELECT a.username
      ,a.osuser
      ,a.machine
      ,a.status
      ,a.sid
      ,a.serial#
      ,b.spid
      ,c.job
      ,a.SQL_ID
      --,c.what
  FROM gv$session        a
      ,gv$process        b
      ,dba_jobs         c
 WHERE a.paddr = b.addr 
 --and a.sid=3991
 --and a.OSUSER like '%RMS%' 
 and c.job=94074;


-- alterar o job
DBMS_JOB.CHANGE(v_job_id, 
                v_what, 
                TRUNC(SYSDATE)+1/24, 
                'TRUNC(SYSDATE+1)+1/24');
COMMIT;


begin
  DBMS_JOB.CHANGE(1, 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;',TRUNC(SYSDATE+1)+1/24,'TRUNC(SYSDATE+1)+1/24');
end;
/

begin
  DBMS_JOB.CHANGE(9, 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;',TRUNC(SYSDATE+1)+1/24,'TRUNC(SYSDATE+1)+1/24');
end;
/

begin
  DBMS_JOB.CHANGE(25, 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;',TRUNC(SYSDATE+1)+1/24,'TRUNC(SYSDATE+1)+1/24');
end;
/

begin
  SYS.DBMS_JOB.CHANGE(27, 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;',TRUNC(SYSDATE)+1/24,'TRUNC(SYSDATE+1)+1/24');
end;
/

-- alterar o interval para 10 minutos
begin
  sys.dbms_job.change(job => 11,
                      what =>'begin
  for t in ( select a.nroempresa
               from   mad_parametro a
               order by 1)
  loop
      spmad_prodfilareserva(t.nroempresa, ''S'');
  end loop;
end;',
                      next_date => to_date('04-07-2022 17:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                      interval => 'sysdate + 1/150');
  commit;
end;
/

-- SM - Criado por C5Badan em 21/03/2017
-- ATUALIZANDO FILA DE RESERVAS DE VENDA

'begin
  for t in ( select a.nroempresa
               from   mad_parametro a
               order by 1)
  loop
      spmad_prodfilareserva(t.nroempresa, ''S'');
  end loop;
end;'


-- mudar intervalo
DBMS_JOB.INTERVAL ( 
   job       IN  BINARY_INTEGER,
   interval  IN  VARCHAR2);

begin
  DBMS_JOB.INTERVAL (11,   interval=>'trunc(sysdate+1)+ 23/24');
end;

-- criar job
alter session set current_schema=MOURA;
DBMS_JOB.SUBMIT (JOB => 27, 
                  WHAT => 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;', 
                  NEXT_DATE => 'trunc(sysdate+1)+ 23/24', 
                  INTERVAL => 'trunc(sysdate+1)+ 23/24', 
                  FORCE => NULL);
/

alter session set current_schema=PANTANAL;
DBMS_JOB.SUBMIT (JOB => 25, 
                  WHAT => 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;', 
                  NEXT_DATE => 'trunc(sysdate+1)+ 23/24', 
                  INTERVAL => 'trunc(sysdate+1)+ 23/24', 
                  FORCE => NULL);
;

alter session set current_schema=PORTFOOD;
DBMS_JOB.SUBMIT (JOB => 9, 
                  WHAT => 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;', 
                  NEXT_DATE => 'trunc(sysdate+1)+ 23/24', 
                  INTERVAL => 'trunc(sysdate+1)+ 23/24', 
                  FORCE => NULL);
/

alter session set current_schema=POUPEAQUI;
DBMS_JOB.SUBMIT (JOB => 1, 
                  WHAT => 'begin fis_prc_acerta_notas_transf(); exception when others then return; end;', 
                  NEXT_DATE =>'trunc(sysdate+1)+ 23/24', 
                  INTERVAL => 'trunc(sysdate+1)+ 23/24', 
                  FORCE => NULL);
;


INSTANCE        JOB   SCHEMA_US LAST_DATE         NEXT_TIME         TOTAL_HORAS BR  FAIL DDL
---------- ---------- --------- ----------------- ----------------- ----------- -- ----- ---------------------------------------------
         0         27 MOURA     25/05/22 00:03:17 25/05/22 23:00:00  .003888889 N      0 begin fis_prc_acerta_notas_transf(); exception when others then return; end;


INSTANCE        JOB SCHEMA_US LAST_DATE          NEXT_TIME         TOTAL_HORAS BR  FAIL DDL
---------- ---------- --------- ------------------ ----------------- ----------- -- ----- ---------------------------------------------
         0         25 PANTANAL  25/05/22 00:03:17  25/05/22 23:00:00  .005277778 N      0 begin fis_prc_acerta_notas_transf(); exception when others then return; end;


INSTANCE        JOB SCHEMA_US LAST_DATE          NEXT_TIME         TOTAL_HORAS BR  FAIL DDL
---------- ---------- --------- ------------------ ----------------- ----------- -- ----- ---------------------------------------------
         0          9 PORTFOOD  25/05/22 00:03:17  25/05/22 23:00:00  .008333333 N      0 begin fis_prc_acerta_notas_transf(); exception when others then return; end;


INSTANCE        JOB SCHEMA_US LAST_DATE          NEXT_TIME         TOTAL_HORAS BR  FAIL DDL
---------- ---------- --------- ------------------ ----------------- ----------- -- ----- ---------------------------------------------
         0          1 POUPEAQUI 25/05/22 00:03:17  25/05/22 23:00:00  .016388889 N      0 begin fis_prc_acerta_notas_transf(); exception when others then return; end;

