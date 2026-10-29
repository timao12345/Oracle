set feedback off
set head off
column  free              format 999999999
Prompt Tamanho da base (sem tempfiles) Mb
select round(sum(bytes)/1024/1024, 0) MB from dba_data_files;
prompt
Prompt Espaço Livre (seg. 10%) desconsiderando tablespaces administrativas Mb
select round(sum(bytes)*.9/1024/1024, 0) Mb 
from dba_free_space 
where tablespace_name not in ('SYSTEM', 'PERFSTAT' , 'AC5JP01','ACANP0P01','SYSAUX',
'PSAPORAMOND','PSAPTEMP','PSAPLIVERD', 'PSAPPRECISED','PSAPSTTSPCKD', 'SPC_DEMO_TS_01', 'SPC_DEMO_TS_02')
AND tablespace_name not like '%UNDO%';
prompt
Prompt Crescimento Média Diário em Mb
select round(((atual - ANTERIOR)+(ANTERIOR - ANTERIOR2))/2/31,0) Mb
from
(select sum(TOTAL_BYTES/1024/1024) ATUAL
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by to_char(timestamp, 'mm/yy'))a,
(select sum(TOTAL_BYTES/1024/1024) ANTERIOR
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate-31, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by to_char(timestamp, 'mm/yy')) b,
(select sum(TOTAL_BYTES/1024/1024) ANTERIOR2
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate-61, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by  to_char(timestamp, 'mm/yy')) c;
prompt
set head on
Prompt Observação:
Prompt Detalhe Crescimento Base (Mensal) Mb
select ROUND(ATUAL - ANTERIOR) CRESC1, ROUND(ANTERIOR - ANTERIOR2) CRESC2, round(((atual - ANTERIOR)+(ANTERIOR - ANTERIOR2))/2,0) Cres_med
from
(select sum(TOTAL_BYTES/1024/1024) ATUAL
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by to_char(timestamp, 'mm/yy'))a,
(select sum(TOTAL_BYTES/1024/1024) ANTERIOR
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate-31, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by to_char(timestamp, 'mm/yy')) b,
(select sum(TOTAL_BYTES/1024/1024) ANTERIOR2
from spaces
where to_char(timestamp, 'mm/yy') = to_char(sysdate-61, 'mm/yy')
and owner NOT IN ('PERFSTAT')
group by  to_char(timestamp, 'mm/yy')) c;
set feedback on
