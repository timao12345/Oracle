Benefit / Impact:

When the PGA size is increased as per V$PGA_TARGET_ADVICE, performance degradation due to PGA over allocation to disk could be avoided.

Risk:

Slow database performance or even hang situations could arise when many PGA over allocations to disk occur.

Action / Repair:

Perform the following 2 actions:

1.	 Increase the size of PGA_AGGREGATE_TARGET when the optimal_percent is not 100.

V$PGA_TARGET_ADVICE view predicts how the statistics cache hit percentage and over allocation count in V$PGASTAT will be impacted if you change the value of the initialization parameter PGA_AGGREGATE_TARGET.

The following select statement can be used to find this information 

SELECT round(PGA_TARGET_FOR_ESTIMATE/1024/1024) target_mb,
       ESTD_PGA_CACHE_HIT_PERCENTAGE cache_hit_perc,
       ESTD_OVERALLOC_COUNT
FROM   v$pga_target_advice;

You can set the new value for PGA_AGGREGATE_TARGET where the "CACHE_HIT_PERC" equals to 100 and "ESTD_OVERALLOC_COUNT" equals to 0.

Steps to set PGA_AGGREGATE_TARGET
==========================

SQL> alter system set pga_aggregate_target = <value>M;

2.	Monitor the size of all active work areas and to determine if these active work areas spill to a temporary segment and also identify the SQLs that incur huge PGA usage.  Use  V$SQL_WORKAREA_ACTIVE  to display the work areas that are active (or executing) in the instance.

Example:

SELECT to_number(decode(SID, 65535, NULL, SID)) sid,
       operation_type OPERATION,trunc(EXPECTED_SIZE/1024) ESIZE,
       trunc(ACTUAL_MEM_USED/1024) MEM, trunc(MAX_MEM_USED/1024) "MAX MEM",
       NUMBER_PASSES PASS, trunc(TEMPSEG_SIZE/1024) TSIZE, SQL_ID
FROM V$SQL_WORKAREA_ACTIVE
ORDER BY 1,2;

SID OPERATION         ESIZE     MEM       MAX MEM    PASS   TSIZE    SQL_ID
--- -----------------     ---------  ---------   -------------   ------  -------    --------
8   GROUP BY (SORT)      315       280             904                  0                    gx4mv66pvj3xz  
8   HASH-JOIN                 2995      2377         2430                  1     20000    ... 
9   GROUP BY (SORT)  34300     22688     22688                  0                     ... 
11  HASH-JOIN              18044     54482     54482                  0                     ...  
12  HASH-JOIN              18044     11406     21406                  1   120000   d2g2xjjz4d2rp

This output shows that session 12 (column SID) is running a hash-join having its work area running in one-pass mode (PASS column). This work area is currently using 11406 KB of memory (MEM column) and has used, in the past, up to 21406 KB of PGA memory (MAX MEM column). It has also spilled to a temporary segment of size 120000 KB. Finally, the column ESIZE indicates the maximum amount of memory that the PGA memory manager expects this hash-join to use. This maximum is dynamically computed by the PGA memory manager according to workload
 