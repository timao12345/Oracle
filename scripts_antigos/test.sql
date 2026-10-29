clear columns
column tablespace format a30
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
column graph format a22 heading "GRAPH (X=5%)"
column status format a10
compute sum of total_mb on report
compute sum of used_mb on report
compute sum of free_mb on report
break on report 
set lines 200 pages 100
select  total.ts tablespace,
        DECODE(total.mb,null,'OFFLINE',dbat.status) status,
                total.mb total_mb,
                NVL(total.mb - free.mb,total.mb) used_mb,
                NVL(free.mb,0) free_mb,
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used,
                CASE WHEN (total.mb IS NULL) THEN '['||RPAD(LPAD('OFFLINE',13,'-'),20,'-')||']'
                ELSE '['|| DECODE(free.mb,
                             null,'XXXXXXXXXXXXXXXXXXXX',
                             NVL(RPAD(LPAD('X',trunc((100-ROUND( (free.mb)/(total.mb) * 100, 2))/5),'X'),20,'-'),
                               '--------------------'))||']' 
         END as GRAPH
from
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
where total.ts=free.ts(+) and
      total.ts=dbat.tablespace_name
      and (dbat.tablespace_name like '%%')
UNION ALL
select  sh.tablespace_name, 
        'TEMP',
                SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
                SUM(sh.bytes_used)/1024/1024 used_mb,
                SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
        '['||DECODE(SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX',
              NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'),
                '--------------------'))||']'
FROM v$temp_space_header sh
GROUP BY tablespace_name
order by 6 
/

--------------------------------- // ----------------------------- // ------------------------------------ // -------------------------------- // -----------------------------------
EXPLAIN PLAN FOR
select  total.ts tablespace,
        DECODE(total.mb,null,'OFFLINE',dbat.status) status,
                total.mb total_mb,
                NVL(total.mb - free.mb,total.mb) used_mb,
                NVL(free.mb,0) free_mb,
        DECODE(total.mb,NULL,0,NVL(ROUND((total.mb - free.mb)/(total.mb)*100,2),100)) pct_used,
                CASE WHEN (total.mb IS NULL) THEN '['||RPAD(LPAD('OFFLINE',13,'-'),20,'-')||']'
                ELSE '['|| DECODE(free.mb,null,'XXXXXXXXXXXXXXXXXXXX', NVL(RPAD(LPAD('X',trunc((100-ROUND( (free.mb)/(total.mb) * 100, 2))/5),'X'),20,'-'),
                               '--------------------'))||']' 
         END as GRAPH
from
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_data_files group by tablespace_name) total,
                (select tablespace_name ts, sum(bytes)/1024/1024 mb from dba_free_space group by tablespace_name) free,
        dba_tablespaces dbat
where total.ts=free.ts(+) and
      total.ts=dbat.tablespace_name
      and (dbat.tablespace_name like '%%')
UNION ALL
select  sh.tablespace_name, 
        'TEMP',
                SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
                SUM(sh.bytes_used)/1024/1024 used_mb,
                SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
        '['||DECODE(SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX',
              NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'),
                '--------------------'))||']'
FROM v$temp_space_header sh
GROUP BY tablespace_name
order by 6;

SELECT PLAN_TABLE_OUTPUT FROM TABLE(DBMS_XPLAN.DISPLAY());

--------------------------------- // ----------------------------- // ------------------------------------ // -------------------------------- // -----------------------------------

clear columns
column tablespace format a30
column total_mb format 999,999,999.99
column used_mb format 999,999,999,999.99
column free_mb format 999,999,999.99
column pct_used format 999.99
column graph format a22 heading "GRAPH (X=5%)"
column status format a10
column PCT format a40
compute sum of total_mb on report
compute sum of used_mb on report
compute sum of free_mb on report
break on report 
set lines 200 pages 100
select  sh.tablespace_name, 
        'TEMP',
        SUM(sh.bytes_used+sh.bytes_free)/1024/1024 total_mb,
        SUM(sh.bytes_used)/1024/1024 used_mb,
        SUM(sh.bytes_free)/1024/1024 free_mb,
        ROUND(SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)*100,2) pct_used,
     '['||DECODE(
                SUM(sh.bytes_free),0,'XXXXXXXXXXXXXXXXXXXX', 
                    NVL(
                        RPAD(
                            LPAD('X',(
                                    TRUNC(
                                            ROUND((
                                                    SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free)
                                                )*100,2)/5)
                                    ),'X'
                                ),20,'-' 
                            ), '--------------------'
                        )
                    )||']' as PCT
FROM v$temp_space_header sh
GROUP BY tablespace_name
order by 6 
/



select sh.tablespace_name, 
    CASE 
        WHEN SUM(sh.bytes_free)= 0 THEN 'XXXXXXXXXXXXXXXXXXXX'
    ELSE '['|| NVL(RPAD(LPAD('X',(TRUNC(ROUND((SUM(sh.bytes_used) / SUM(sh.bytes_used+sh.bytes_free))*100,2)/5)),'X'),20,'-'), '--------------------')||']'
    END 
from v$temp_space_header sh GROUP BY sh.tablespace_name;


SELECT sh.tablespace_name,ROUND((SUM(sh.bytes_used)/SUM(sh.bytes_used+sh.bytes_free))*100,2) from v$temp_space_header sh group by sh.tablespace_name;


SELECT next_day(sysdate,'Thursday') from dual;

 
select LPAD('fazendo teste', 14, '*') from dual;



select RPAD('XXXXXXXXX',20,'-') from dual;


select trunc(100.256,2) from dual;


select NVL('XXXXXXXXX-----------','-------------------') as PCT from dual;

select SUM(sh.bytes_free) FROM v$temp_space_header sh

select DECODE ('141557760',0,'XXXXXXXXXXXXXXXXXXXX','XXXXXXXXX-----------') from dual;



--1 - Criar um novo usuário Oracle, chamado dbIwMundoSenior
create user DBIWMUNDOSENIOR identified by "YUDahNz5"
default tablespace MUNDOSENIOR_DT
quota unlimited on MUNDOSENIOR_DT
quota unlimited on MUNDOSENIOR_IDX
account unlock;


grant connect to DBIWMUNDOSENIOR;
grant create job to DBIWMUNDOSENIOR;
grant create view to DBIWMUNDOSENIOR;
grant resource to DBIWMUNDOSENIOR;


--2 - Criar as tablespaces MundoSenior_DT e MundoSenior_IDX
create tablespace "MUNDOSENIOR_DT" datefile size 7000M online;
create tablespace "MUNDOSENIOR_IDX" datefile size 3000M;

--3 - Tirar um export (expdp) do usuário dbIwMatrizData
nohup expdp \"/ as sysdba\" directory=EXPORT dumpfile=DUMP_RS00733824_DBIWMATRIZDATA.dmp logfile=DUMP_LOG_RS00733824_DBIWMATRIZDATA.log schemas=DBIWMATRIZDATA &
/*
--4 - Fazer o import (impdp) do usuário dbIwMundoSenior a partir do export do usuário dbIwMatrizData,IMPORTANTE: "(Import deverá carregar estruturas e dados para o novo banco)",
Remapeamento: Schema dbIwMatrizData para dbIwMundoSenior , Tablespace MatrizData_DT para MundoSenior_DT, 
Tablespace MatrizData_IDX para MundoSenior_IDX O procedimento pode ser realizado em qualquer momento Obrigado.
*/

nohup impdp \"/ as sysdba\" directory=EXPORT dumpfile=DUMP_RS00733824_DBIWMATRIZDATA.dmp logfile=IMPDP_LOG_RS00733824_DBIWMATRIZDATA.log remap_schema=DBIWMATRIZDATA:DBIWMUNDOSENIOR remap_tablespace=MATRIZDATA_DT:MUNDOSENIOR_DT,MATRIZDATA_IDX:MUNDOSENIOR_IDX &

select owner,object_type, count(object_type) QTD from dba_objects where owner='DBIWMUNDOSENIOR' group by owner,object_type order by QTD ;
select owner,object_type, count(object_type) QTD from dba_objects where owner='DBIWMATRIZDATA' group by owner,object_type order by QTD ;

select owner,count(object_type) QTD from dba_objects where owner='DBIWMATRIZDATA' or owner ='DBIWMUNDOSENIOR'group by owner;
select owner,count(object_type) QTD from dba_objects where owner='DBIWMATRIZDATA' group by owner;
