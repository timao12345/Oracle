PROMPT ********* CONSUMO PER USER MEMORY ********* 
col USERNAME for a40
BREAK ON REPORT
compute sum of memory_mb on report
SELECT NVL(a.username,'(oracle)') AS username,
      a.module,
      a.program,
      Trunc(b.value/1024/1024) AS memory_mb
FROM v$session a,
      v$sesstat b,
      v$statname c
WHERE a.sid = b.sid AND b.statistic# = c.statistic# AND c.name = 'session pga memory' AND a.program IS NOT NULL
ORDER BY b.value asc;


--Script retorna informações sobre uso de memoria, usuarios e processo quantidade de memoria utilizada.

PROMPT ********* INFORMATION OF DATABASE *********

ALTER SESSION SET NLS_DATE_FORMAT='dd/mm/yy:hh24:mi:ss';
SET PAGESIZE 5555  LINESIZE 500
COL STARTUP_TIME                HEADING 'STARTUP|TIME'
COL HOST_NAME FOR A30   HEADING 'HOST|NAME'
COL INSTANCE_NAME               HEADING 'INSTANCE|NAME'
COL OPEN_MODE                   HEADING 'OPEN|MODE'
COL DATABASE_ROLE FOR A9 HEADING 'DATABASE|ROLE'
SELECT SYSDATE, STARTUP_TIME, HOST_NAME, INSTANCE_NAME, STATUS, A.OPEN_MODE,LOGINS, A.DATABASE_ROLE, V.SESSIONS_CURRENT FROM V$INSTANCE, V$LICENSE V, V$DATABASE A;

PROMPT
PROMPT ********* SGA *********
sho parameter sga

PROMPT
PROMPT ********* PGA *********
sho parameter pga

PROMPT
PROMPT ********* PROCESS *********
set lines 300 pages 90
select * from v$resource_limit where resource_name in ('processes','sessions');

PROMPT
PROMPT ********* CONSUMO PER USER MEMORY ********* 
col USERNAME for a30
BREAK ON REPORT
compute sum of memory_kb on report
SELECT NVL(a.username,'(oracle)') AS username,
      a.module,
      a.program,
      Trunc(b.value/1024) AS memory_kb
FROM v$session a,
      v$sesstat b,
      v$statname c
WHERE a.sid = b.sid AND b.statistic# = c.statistic# AND c.name = 'session pga memory' AND a.program IS NOT NULL
ORDER BY b.value ASC;

PROMPT
PROMPT ********* TAM BASE *********
set serveroutput on
declare  
dbf number;    
tmpdbf number;    
lgf number;   
ctl number;  
soma number;  
begin  
	select trunc(sum(bytes/1024/1024),2) into dbf from v$datafile;
	select trunc(sum(bytes/1024/1024),2) into tmpdbf from v$tempfile; 
	select trunc(sum(bytes/1024/1024),2) into lgf from v$log l, v$logfile lf where l.group# = lf.group#; 
	select trunc(sum(block_size*file_size_blks/1024/1024),2) into ctl from v$controlfile;
	select trunc((dbf+tmpdbf+lgf+ctl)/1024,2) into soma from dual; 
DBMS_OUTPUT.PUT_LINE(chr(10)); 
DBMS_OUTPUT.PUT_LINE('Datafiles: '|| dbf ||' MB'); 
DBMS_OUTPUT.PUT_LINE(chr(0)); 
DBMS_OUTPUT.PUT_LINE('Tempfiles: '|| tmpdbf ||' MB');
DBMS_OUTPUT.PUT_LINE(chr(0)); 
DBMS_OUTPUT.PUT_LINE('Logfiles: '|| lgf ||' MB'); 
DBMS_OUTPUT.PUT_LINE(chr(0)); 
DBMS_OUTPUT.PUT_LINE('Controlfiles: '|| ctl ||' MB');
DBMS_OUTPUT.PUT_LINE(chr(0));
DBMS_OUTPUT.PUT_LINE('Total Tamanho: '|| soma ||' GB'); 
end;
 /
 
 