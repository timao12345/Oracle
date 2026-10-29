set lines 140 pages 100
set lines 140 pages 100
col recid format 999999
col operation format a10
col object_type format a15
col start_time format a11 heading "START|TIME"
col end_time format a11 heading "END|TIME"
col type format a10 heading "TYPE"
col status format a11
col output_device_type format a10 heading "DEVICE"
col processed_gb format 99999.99 heading "PROCESSED|GB"
col output_gb    format 99999.99 heading "OUTPUT|GB"
col th    format 99999.99 heading "GB/MIN"
col elapsed format a11

alter session set optimizer_mode=RULE;

select recid,operation, object_type, status, output_device_type,start_time,end_time,elapsed,processed_gb,output_gb,
processed_gb/decode(minuto,0,1,minuto) as th
from (
select recid,operation, object_type, status, output_device_type,
to_char(start_time, 'dd/mm/yyyy hh24:mi:ss') as start_time,
to_char(end_time, 'dd/mm/yyyy hh24:mi:ss') as end_time,
substr( numtodsinterval( end_time - start_time, 'day') ,1,
instr(numtodsinterval( end_time - start_time, 'day'),'.')-1) as elapsed,
round(mbytes_processed/1024,2) as processed_gb,
round(output_bytes/1024/1024/1024,2) as output_gb,
(to_number(substr(numtodsinterval( end_time - start_time, 'day'), 2,9)) * 24 * 60)+
(to_number(substr(numtodsinterval( end_time - start_time, 'day'),12,2)) * 60)+
to_number(substr(numtodsinterval( end_time - start_time, 'day'),15,2))  minuto
from v$rman_status
where operation != 'CATALOG'
and object_type in('DB FULL','DB INCR')
and trunc(end_time) >= trunc(sysdate-10))
order by recid;
