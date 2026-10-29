RESOURCE_NAME	VARCHAR2(30)	Name of the resource (see Table 8-5)
CURRENT_UTILIZATION	NUMBER	Number of (resources, locks, or processes) currently being used
MAX_UTILIZATION	NUMBER	Maximum consumption of this resource since the last instance start-up
INITIAL_ALLOCATION	VARCHAR2(10)	Initial allocation. This will be equal to the value specified for the resource in the initialization parameter file (UNLIMITED for infinite allocation).
LIMIT_VALUE	VARCHAR2(10)	Unlimited for resources and locks. This can be greater than the initial allocation value (UNLIMITED for infinite limit).

SQL> col BEGIN_INTERVAL_TIME for a28
SQL> col END_INTERVAL_TIME for a28
SQL>col RESOURCE_NAME for a10
SELECT A.SNAP_ID,A.INSTANCE_NUMBER "ID",B.BEGIN_INTERVAL_TIME,B.END_INTERVAL_TIME,A.RESOURCE_NAME,
CURRENT_UTILIZATION "CURRENT",MAX_UTILIZATION "MAX"
FROM WRH$_RESOURCE_LIMIT A, WRM$_SNAPSHOT B
WHERE A.RESOURCE_NAME LIKE '%session%'
AND A.SNAP_ID=B.SNAP_ID
AND A.INSTANCE_NUMBER= B.INSTANCE_NUMBER
AND ((A.INSTANCE_NUMBER=1
AND B.BEGIN_INTERVAL_TIME > (SELECT STARTUP_TIME FROM GV$INSTANCE WHERE INSTANCE_NUMBER=1)) OR
(A.INSTANCE_NUMBER=2 AND B.BEGIN_INTERVAL_TIME >
(SELECT STARTUP_TIME FROM GV$INSTANCE WHERE INSTANCE_NUMBER=2)))
order by A.INSTANCE_NUMBER,A.SNAP_ID;


col BEGIN_INTERVAL_TIME for a28
col END_INTERVAL_TIME for a28
col RESOURCE_NAME for a10
SELECT A.SNAP_ID,A.INSTANCE_NUMBER "ID",B.BEGIN_INTERVAL_TIME,B.END_INTERVAL_TIME,A.RESOURCE_NAME,
CURRENT_UTILIZATION "CURRENT",MAX_UTILIZATION "MAX"
FROM WRH$_RESOURCE_LIMIT A, WRM$_SNAPSHOT B
WHERE A.RESOURCE_NAME LIKE '%processes%'
AND A.SNAP_ID=B.SNAP_ID
AND A.INSTANCE_NUMBER= B.INSTANCE_NUMBER
AND B.BEGIN_INTERVAL_TIME >='27/03/15' AND B.BEGIN_INTERVAL_TIME <'28/03/15'
order by A.INSTANCE_NUMBER,A.SNAP_ID;

SELECT RESOURCE_NAME "RESOURCE",
CURRENT_UTILIZATION "CURRENT",
MAX_UTILIZATION "MAX",
INITIAL_ALLOCATION "INITIAL",
LIMIT_VALUE 
FROM V$RESOURCE_LIMIT ;
WHERE RESOURCE_NAME='processes';


Error:  ORA 20   
Text:   maximum number of processes <num> exceeded 
-------------------------------------------------------------------------------
Cause:  An operation requested a resource that was unavailable.
        The maximum number of processes is specified by the initialization 
        parameter PROCESSES.
        When this maximum is reached, no more requests are processed.
Action: Try the operation again in a few minutes.
        If this message occurs often, shut down Oracle, increase the PROCESSES 
        parameter in the initialization parameter file, and restart Oracle.

		
