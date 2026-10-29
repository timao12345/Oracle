---- Confirmar se o CONSULTA é o top consumidor


set pages 9999
set line 9999
COL DATA FORMAT A20
COL USERNAME FORMAT A10
COL INST_ID FORMAT 99
COL SQL_ID FORMAT a20
COL osuser FORMAT A13
COL EVENT FORMAT A25 trunc
COL tablespace FORMAT A10
COL temp_size HEADING "Temp Size (MB)" FORMAT 999,999,999
break on report on tablespace
compute avg sum label "Total : " of temp_size on report
SELECT
b.tablespace,
TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS') AS DATA,
NVL(a.username, '(oracle)') AS username,
a.osuser,
a.sid,
a.serial#,
a.inst_id,
a.sql_id,
a.status,
a.event,
ROUND( sum((b.blocks*p.value)/1024/1024),2) AS temp_size
FROM gv$session a, gv$sort_usage b, gv$parameter p
WHERE p.name = 'db_block_size'
AND a.saddr = b.session_addr
AND a.inst_id=b.inst_id
AND a.inst_id=p.inst_id
AND a.event like '%wait%'
group by NVL(a.username, '(oracle)'), SID, a.osuser,b.tablespace, a.sid,a.inst_id, a.sql_id,a.serial#, a.status, a.event,  TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS')
ORDER BY temp_size desc;


--==========================================================================================================================================================================
--														=		 					=
--														=		 					=
--														=   	   EXEMPLO			=
--														=		 					=
--														=		 					=
--==========================================================================================================================================================================
--
--
--
--TABLESPACE DATA                 USERNAME   OSUSER               SID    SERIAL# INST_ID SQL_ID               STATUS   EVENT                     Temp Size (MB)
------------ -------------------- ---------- ------------- ---------- ---------- ------- -------------------- -------- ------------------------- --------------
--TEMP_1     04/04/2024 05:23:57  CONSULTA   analytics           7855      21430       2 2qjakx4zjuyh6        ACTIVE   statement suspended, wait          4,562
--           04/04/2024 05:23:57  CONSULTA   PBIEgwService       9839      57710       4 cuggxam83xg05        ACTIVE   statement suspended, wait          3,401
--           04/04/2024 05:23:57  CONSULTA   oracle              9474      33587       2 3kqnsvtky15bv        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  CONSULTA   root               11073      19179       2 2mkkt1gnxa5ux        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  USR_ZABBIX zabbix              8674      58973       2 0174m6jt8wkkg        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  CONSULTA   root                8657       6006       3                      ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  CONSULTA   root               11871       9556       2 4uqyhgc7kz4wt        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  CONSULTA   root               11890      40446       2                      ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  CONSULTA   PBIEgwService       8739      59641       1 3xqxqanpd2yp3        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:23:57  USR_ZABBIX zabbix              6666      58911       3 ftsab5c2dtj7j        ACTIVE   statement suspended, wait              0
--**********                                                                                                                                     --------------
--avg                                                                                                                                                       796
--Total :                                                                                                                                                 7,963
--
--10 rows selected.
--
--SQL> /
--
--TABLESPACE DATA                 USERNAME   OSUSER               SID    SERIAL# INST_ID SQL_ID               STATUS   EVENT                     Temp Size (MB)
------------ -------------------- ---------- ------------- ---------- ---------- ------- -------------------- -------- ------------------------- --------------
--TEMP_1     04/04/2024 05:24:38  CONSULTA   rggelhadi           7300      22078       4 4npusgs4gzss2        ACTIVE   statement suspended, wait        484,470
--           04/04/2024 05:24:38  CONSULTA   analytics           7855      21430       2 2qjakx4zjuyh6        ACTIVE   statement suspended, wait          4,562
--           04/04/2024 05:24:38  CONSULTA   PBIEgwService       9839      57710       4 cuggxam83xg05        ACTIVE   statement suspended, wait          3,401
--           04/04/2024 05:24:38  CONSULTA   oracle              9474      33587       2 3kqnsvtky15bv        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   PBIEgwService       8739      59641       1 3xqxqanpd2yp3        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   root               11890      40446       2                      ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   root                9856      58316       3 4zvyg5sjdntnc        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   root               11073      19179       2 2mkkt1gnxa5ux        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   root               11871       9556       2 4uqyhgc7kz4wt        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  USR_ZABBIX zabbix              6666      58911       3 ftsab5c2dtj7j        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  USR_ZABBIX zabbix              8674      58973       2 0174m6jt8wkkg        ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   root                8657       6006       3                      ACTIVE   statement suspended, wait              0
--           04/04/2024 05:24:38  CONSULTA   PBIEgwService       8270      56246       3 4ma7u894d5g07        ACTIVE   statement suspended, wait              0
--**********                                                                                                                                     --------------
--avg                                                                                                                                                    37,879
--
--
--ALTER SYSTEM KILL SESSION '7300,22078,@3' immediate
--ALTER SYSTEM KILL SESSION '7855,21430,@2' immediate;