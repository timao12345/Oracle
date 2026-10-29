select PASSO,TO_CHAR(DATAINI, 'DD-MON-YYYY HH:MI:SS') as DATAINI,TO_CHAR(DATAFIM, 'DD-MON-YYYY HH:MI:SS') as DATAFIM,BASE from contabilidade.logfechamento where base = user order by passo;

Melhorado

select PASSO,TO_CHAR(DATAINI, 'DD-MON-YYYY HH24:MI:SS') as INICIO,TO_CHAR(DATAFIM, 'DD-MON-YYYY HH24:MI:SS') as FIM,BASE as SCHEMA 
	from contabilidade.logfechamento 
		where base = user order by INICIO;
--------------------------------------------------------------
-- Select Sessão --
------------------------

select s.STATUS,s.inst_id,s.SID,s.serial#,s.USERNAME,s.osuser,s.MACHINE,s.SQL_HASH_VALUE,s.sql_id,p.PID,p.SPID
 from gv$process p, gv$session s
  where s.PADDR = p.ADDR and s.USERNAME='CONT_BDFAMA_201712';