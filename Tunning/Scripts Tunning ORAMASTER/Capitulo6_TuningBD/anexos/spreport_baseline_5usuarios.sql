
STATSPACK report for

Database    DB Id    Instance     Inst Num  Startup Time   Release     RAC
~~~~~~~~ ----------- ------------ -------- --------------- ----------- ---
          2872535335 xe                  1 02-May-21 05:38 18.0.0.0.0  NO

Host                             Name             Platform                CPUs
Cores Sockets   Memory (G)
~~~~ ---------------- ---------------------- ----- ----- ------- ------------
     oramaster        Linux x86 64-bit           2     2       1          1.7

Snapshot       Snap Id     Snap Time      Sessions Curs/Sess Comment
~~~~~~~~    ---------- ------------------ -------- --------- ------------------
Begin Snap:         53 04-May-21 11:06:11        1      32.0
  End Snap:         63 04-May-21 14:36:44        1      29.0
   Elapsed:     210.55 (mins) Av Act Sess:       1.0
   DB time:     216.13 (mins)      DB CPU:     114.51 (mins)

Cache Sizes            Begin        End
~~~~~~~~~~~       ---------- ----------
    Buffer Cache:       692M              Std Block Size:         8K
     Shared Pool:       276M                  Log Buffer:     3,384K

Load Profile              Per Second    Per Transaction    Per Exec    Per Call
~~~~~~~~~~~~      ------------------  ----------------- ----------- -----------
      DB time(s):                1.0                0.7        0.05        0.20
       DB CPU(s):                0.5                0.3        0.02        0.11
       Redo size:          268,427.2          168,817.7
   Logical reads:            3,275.0            2,059.7
   Block changes:            1,213.6              763.2
  Physical reads:              644.1              405.1
 Physical writes:               35.5               22.4
      User calls:                5.1                3.2
          Parses:                4.0                2.5
     Hard parses:                0.3                0.2
W/A MB processed:                0.4                0.3
          Logons:                0.0                0.0
        Executes:               22.0               13.8
       Rollbacks:                0.0                0.0
    Transactions:                1.6

Instance Efficiency Indicators
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Buffer Nowait %:   99.85       Redo NoWait %:  100.00
            Buffer  Hit   %:   82.42  Optimal W/A Exec %:   99.94
            Library Hit   %:   97.71        Soft Parse %:   92.81
         Execute to Parse %:   81.68         Latch Hit %:   99.99
Parse CPU to Parse Elapsd %:   67.42     % Non-Parse CPU:   99.79

 Shared Pool Statistics        Begin   End
                               ------  ------
             Memory Usage %:   81.20   87.43
    % SQL with executions>1:   70.61   79.89
  % Memory for SQL w/exec>1:   73.08   84.41

Top 5 Timed Events                                                    Avg %Total
~~~~~~~~~~~~~~~~~~                                                   wait   Call
Event                                            Waits    Time (s)   (ms)   Time
----------------------------------------- ------------ ----------- ------ ------
CPU time                                                     6,860          47.2
db file sequential read                      2,397,364       5,130      2   35.3
PL/SQL lock timer                              135,935       1,389     10    9.5
db file scattered read                          84,273         662      8    4.5
read by other session                           58,476         216      4    1.5
          -------------------------------------------------------------
Host CPU  (CPUs: 2  Cores: 2  Sockets: 1)
~~~~~~~~              Load Average
                      Begin     End      User  System    Idle     WIO     WCPU
                    ------- -------   ------- ------- ------- ------- --------
                       0.11    0.12     24.95    2.17   71.33   15.56

Note: There is a 6% discrepancy between the OS Stat total CPU time and
      the total CPU time estimated by Statspack
          OS Stat CPU time: 23741(s) (BUSY_TIME + IDLE_TIME)
        Statspack CPU time: 25266(s) (Elapsed time * num CPUs in end snap)

Instance CPU
~~~~~~~~~~~~                                       % Time (seconds)
                                            -------- --------------
                     Host: Total time (s):                 23,740.8
                  Host: Busy CPU time (s):                  6,807.0
                   % of time Host is Busy:      28.7
             Instance: Total CPU time (s):                  6,870.3
          % of Busy CPU used for Instance:     100.9
        Instance: Total Database time (s):                 12,967.9
  %DB time waiting for CPU (Resource Mgr):       0.0

Virtual Memory Paging
~~~~~~~~~~~~~~~~~~~~~
                     KB paged out per sec:             2.3
                     KB paged  in per sec:              .9

Memory Statistics                       Begin          End
~~~~~~~~~~~~~~~~~                ------------ ------------
                  Host Mem (MB):      1,745.5      1,745.5
                   SGA use (MB):      1,024.0      1,024.0
                   PGA use (MB):         47.5         47.0
    % Host Mem used for SGA+PGA:         61.4         61.4
          -------------------------------------------------------------

Time Model System Stats  DB/Inst: XE/xe  Snaps: 53-63
-> Ordered by % of DB time desc, Statistic name

Statistic                                       Time (s) % DB time
----------------------------------- -------------------- ---------
sql execute elapsed time                        12,754.3      98.4
DB CPU                                           6,870.3      53.0
PL/SQL execution elapsed time                       35.0        .3
parse time elapsed                                  32.7        .3
hard parse elapsed time                             26.9        .2
connection management call elapsed                   6.8        .1
hard parse (sharing criteria) elaps                  1.3        .0
PL/SQL compilation elapsed time                      1.3        .0
failed parse elapsed time                            0.3        .0
repeated bind elapsed time                           0.1        .0
DB time                                         12,967.9
          -------------------------------------------------------------
Foreground Wait Events  DB/Inst: XE/xe  Snaps: 53-63
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read         2,393,883    0      5,123      2    119.2   35.2
PL/SQL lock timer                 135,935  100      1,389     10      6.8    9.5
db file scattered read             84,086    0        661      8      4.2    4.5
read by other session              58,467    0        216      4      2.9    1.5
log file sync                      20,108    0        190      9      1.0    1.3
direct path read                    5,407    0         25      5      0.3     .2
enq: KO - fast object checkp          122    0         16    128      0.0     .1
db file parallel read               2,743    0         13      5      0.1     .1
direct path write temp                768    0          8     10      0.0     .1
direct path read temp               4,070    0          6      1      0.2     .0
library cache load lock               244    0          5     22      0.0     .0
enq: RO - fast object reuse           144    0          5     34      0.0     .0
cursor: pin S wait on X                82    0          3     40      0.0     .0
direct path write                     190    0          2     12      0.0     .0
enq: CR - block range reuse           189    0          2     10      0.0     .0
reliable message                      487    0          2      4      0.0     .0
log file switch completion             14    0          2    128      0.0     .0
control file parallel write           132    0          1      8      0.0     .0
control file sequential read          429    0          1      2      0.0     .0
PGA memory operation               17,063    0          1      0      0.8     .0
log file switch (private str            8    0          1     81      0.0     .0
row cache lock                         22    0          0      9      0.0     .0
DLM cross inst call completi            1    0          0    152      0.0     .0
latch: In memory undo latch             5    0          0     29      0.0     .0
resmgr:cpu quantum                      8    0          0     17      0.0     .0
library cache: mutex X                158    0          0      1      0.0     .0
latch: cache buffers chains           123    0          0      1      0.0     .0
log buffer space                        2    0          0     54      0.0     .0
Disk file operations I/O              290    0          0      0      0.0     .0
library cache lock                      1    0          0     72      0.0     .0
enq: TX - row lock contentio            1    0          0     66      0.0     .0
latch: enqueue hash chains              4    0          0     13      0.0     .0
enq: CF - contention                    1    0          0     33      0.0     .0
enq: TX - contention                    1    0          0     31      0.0     .0
latch: object queue header o            9    0          0      3      0.0     .0
enq: SQ - contention                    3    0          0      7      0.0     .0
buffer busy waits                       5    0          0      3      0.0     .0
latch: shared pool                      2    0          0      6      0.0     .0
Compression analysis                1,476    0          0      0      0.1     .0
latch: redo allocation                  4    0          0      2      0.0     .0
latch free                             16    0          0      1      0.0     .0
SQL*Net break/reset to clien           35    0          0      0      0.0     .0
index (re)build lock or pin           198    0          0      0      0.0     .0
cursor: pin S                           3    0          0      2      0.0     .0
SQL*Net more data to client            29    0          0      0      0.0     .0
library cache: bucket mutex             3    0          0      1      0.0     .0
SQL*Net message from client        43,023    0      9,251    215      2.1
SQL*Net message to client          43,022    0          0      0      2.1
          -------------------------------------------------------------

Background Wait Events  DB/Inst: XE/xe  Snaps: 53-63
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read             3,481    0          8      2      0.2     .1
control file parallel write           840    0          7      8      0.0     .0
control file sequential read        1,134    0          2      1      0.1     .0
db file scattered read                187    0          0      2      0.0     .0
log file sync                          14    0          0      6      0.0     .0
read by other session                   9    0          0      8      0.0     .0
Disk file operations I/O              108    0          0      1      0.0     .0
cursor: pin S wait on X                 1    0          0     23      0.0     .0
latch: cache buffers chains             1    0          0     19      0.0     .0
latch: shared pool                      3    0          0      3      0.0     .0
row cache mutex                         1    0          0      7      0.0     .0
resmgr:cpu quantum                      1    0          0      6      0.0     .0
PGA memory operation                  264    0          0      0      0.0     .0
row cache lock                          3    0          0      1      0.0     .0
SQL*Net message from client            30    0          4    121      0.0
          -------------------------------------------------------------

Wait Events (fg and bg) DB/Inst: XE/xe  Snaps: 53-63
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
db file sequential read         2,397,364    0      5,130      2    119.3   35.3
PL/SQL lock timer                 135,935  100      1,389     10      6.8    9.5
db file scattered read             84,273    0        662      8      4.2    4.5
read by other session              58,476    0        216      4      2.9    1.5
log file sync                      20,122    0        190      9      1.0    1.3
direct path read                    5,407    0         25      5      0.3     .2
enq: KO - fast object checkp          122    0         16    128      0.0     .1
db file parallel read               2,743    0         13      5      0.1     .1
control file parallel write           972    0          8      8      0.0     .1
direct path write temp                768    0          8     10      0.0     .1
direct path read temp               4,070    0          6      1      0.2     .0
library cache load lock               244    0          5     22      0.0     .0
enq: RO - fast object reuse           144    0          5     34      0.0     .0
cursor: pin S wait on X                83    0          3     39      0.0     .0
control file sequential read        1,563    0          2      2      0.1     .0
direct path write                     190    0          2     12      0.0     .0
enq: CR - block range reuse           189    0          2     10      0.0     .0
reliable message                      487    0          2      4      0.0     .0
log file switch completion             14    0          2    128      0.0     .0
PGA memory operation               17,327    0          1      0      0.9     .0
log file switch (private str            8    0          1     81      0.0     .0
row cache lock                         25    0          0      8      0.0     .0
DLM cross inst call completi            1    0          0    152      0.0     .0
latch: In memory undo latch             5    0          0     29      0.0     .0
resmgr:cpu quantum                      9    0          0     16      0.0     .0
Disk file operations I/O              398    0          0      0      0.0     .0
latch: cache buffers chains           124    0          0      1      0.0     .0
library cache: mutex X                158    0          0      1      0.0     .0
log buffer space                        2    0          0     54      0.0     .0
library cache lock                      1    0          0     72      0.0     .0
enq: TX - row lock contentio            1    0          0     66      0.0     .0
latch: enqueue hash chains              4    0          0     13      0.0     .0
enq: CF - contention                    1    0          0     33      0.0     .0
enq: TX - contention                    1    0          0     31      0.0     .0
latch: object queue header o            9    0          0      3      0.0     .0
enq: SQ - contention                    3    0          0      7      0.0     .0
latch: shared pool                      5    0          0      4      0.0     .0
buffer busy waits                       5    0          0      3      0.0     .0
Compression analysis                1,476    0          0      0      0.1     .0
latch: redo allocation                  4    0          0      2      0.0     .0
latch free                             16    0          0      1      0.0     .0
SQL*Net break/reset to clien           35    0          0      0      0.0     .0
row cache mutex                         1    0          0      7      0.0     .0
index (re)build lock or pin           198    0          0      0      0.0     .0
cursor: pin S                           3    0          0      2      0.0     .0
SQL*Net more data to client            29    0          0      0      0.0     .0
library cache: bucket mutex             3    0          0      1      0.0     .0
SQL*Net message from client        43,053    0      9,254    215      2.1
SQL*Net message to client          43,042    0          0      0      2.1

Wait Events (fg and bg) DB/Inst: XE/xe  Snaps: 53-63
-> s - second, cs - centisecond,  ms - millisecond, us - microsecond
-> %Timeouts:  value of 0 indicates value was < .5%.  Value of null is truly 0
-> Only events with Total Wait Time (s) >= .001 are shown
-> ordered by Total Wait Time desc, Waits desc (idle events last)

                                                             Avg          %Total
                                          %Tim Total Wait   wait    Waits   Call
Event                               Waits  out   Time (s)   (ms)     /txn   Time
---------------------------- ------------ ---- ---------- ------ -------- ------
          -------------------------------------------------------------
Wait Event Histogram  DB/Inst: XE/xe  Snaps: 53-63
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
Compression analysis       1476  100.0
DLM cross inst call comple    1                                      100.0
Disk file operations I/O    398   96.5   1.0    .5    .5   1.3    .3
PGA memory operation         17K  99.6    .1    .2    .1    .0
PL/SQL lock timer           135K                .0    .0  98.6   1.4    .0
SQL*Net break/reset to cli   35  100.0
SQL*Net more data to clien   29  100.0
asynch descriptor resize     14  100.0
buffer busy waits             5   60.0              40.0
control file parallel writ  972                 .2  75.8  19.0   3.8   1.1
control file sequential re 1563   76.1   5.8  12.1   3.8    .8    .6    .6
cursor: mutex X               1  100.0
cursor: pin S                 3         66.7  33.3
cursor: pin S wait on X      83                4.8  12.0  21.7  27.7  33.7
db file parallel read      2743    3.6  18.0  31.0  34.6  11.4   1.5    .1
db file scattered read       84K   3.6  11.4  25.6  42.9  12.5   1.6   2.3
db file sequential read    2397K  69.6  10.5  10.3   6.5   2.1    .4    .6
direct path read           5407   11.9  14.6  31.1  27.8  12.6   2.1    .1
direct path read temp      4070   40.6  41.1  16.8    .8    .3    .3    .1
direct path write           190    2.1  35.8  15.8  17.9  13.7   8.4   6.3
direct path write temp      768         12.9   5.6  56.1  16.4   6.6   2.3
enq: CF - contention          1                                      100.0
enq: CR - block range reus  189    5.3   1.1    .5  72.0  15.3   1.1   4.8
enq: KO - fast object chec  122                1.6  11.5  14.8    .8  69.7   1.6
enq: RO - fast object reus  144   49.3   3.5   1.4    .7   3.5  22.9  18.8
enq: SQ - contention          3   33.3                    66.7
enq: TX - contention          1                                100.0
enq: TX - row lock content    1                                      100.0
index (re)build lock or pi  198   99.5    .5
latch free                   16   81.3  12.5   6.3
latch: In memory undo latc    5   80.0                                20.0
latch: cache buffers chain  124   94.4   1.6          .8         3.2
latch: enqueue hash chains    4                          100.0
latch: object queue header    9   44.4  22.2  11.1        22.2
latch: redo allocation        4   50.0        25.0  25.0
latch: shared pool            5   40.0  20.0        20.0  20.0
library cache load lock     244   26.2   5.3   9.8  12.3  13.1  12.7  20.5
library cache lock            1                                      100.0
library cache: bucket mute    3   66.7  33.3
library cache: mutex X      158   88.6   5.1    .6   1.9   3.8
log buffer space              2                           50.0        50.0
log file switch (private s    8                                      100.0
log file switch completion   14                                      100.0
log file sync                20K          .5  13.3  45.0  29.9   9.6   1.8
read by other session        58K  35.0  24.9  17.3  16.8   4.5    .6    .9
reliable message            487   78.2   9.9   3.3   2.5   5.3    .4    .4
resmgr:cpu quantum            9         11.1        33.3  11.1  44.4
row cache lock               25   16.0  16.0   4.0  16.0  40.0   4.0   4.0
row cache mutex               1                    100.0
SQL*Net message from clien   43K  94.0   3.5   1.2    .5    .3    .0    .2    .2
SQL*Net message to client    43K 100.0    .0
Wait Event Histogram  DB/Inst: XE/xe  Snaps: 53-63
-> Total Waits - units: K is 1000, M is 1000000, G is 1000000000
-> % of Waits - column heading: <=1s is truly <1024ms, >1s is truly >=1024ms
-> % of Waits - value: .0 indicates value was <.05%, null is truly 0
-> Ordered by Event (idle events last)

                           Total ----------------- % of Waits ------------------
Event                      Waits  <1ms  <2ms  <4ms  <8ms <16ms <32ms  <=1s   >1s
-------------------------- ----- ----- ----- ----- ----- ----- ----- ----- -----
          -------------------------------------------------------------

SQL ordered by CPU  DB/Inst: XE/xe  Snaps: 53-63
-> Total DB CPU (s):           6,870
-> Captured SQL accounts for    0.0% of Total DB CPU
-> SQL reported below exceeded  1.0% of Total DB CPU

    CPU                  CPU per             Elapsd                     Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)    Buffer Gets  Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
    274.67        7,752       0.04    4.0    2487.90      17,560,326 3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

    189.33        7,752       0.02    2.8     420.98      14,983,836  140204897
Module: New Order
SELECT CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD_NUMBER, EXPIRY_DATE
, IS_VALID, SECURITY_CODE FROM CARD_DETAILS WHERE CUSTOMER_ID =
:B2 AND ROWNUM < :B1

          -------------------------------------------------------------
SQL ordered by Elapsed time for DB: XE  Instance: xe  Snaps: 53 -63
-> Total DB Time (s):          12,968
-> Captured SQL accounts for    0.1% of Total DB Time
-> SQL reported below exceeded  1.0% of Total DB Time

  Elapsed                Elap per            CPU                        Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)  Physical Reads Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------
   2487.90        7,752       0.32   19.2     274.67         345,806 3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

    929.38       23,196       0.04    7.2      30.87          98,878 2319948924
Module: New Order
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_ID = :B3 AND INV

    633.31        9,672       0.07    4.9      28.84          37,737 1852190137
Module: Swingbench User Thread
BEGIN :1 := orderentry.browseproducts(:2 ,:3 ,:4 ); END;

    622.51       21,285       0.03    4.8       7.97          35,995 1822227481
Module: Browse Products
SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, NLS_LANGUAG
E, NLS_TERRITORY, CREDIT_LIMIT, CUST_EMAIL, ACCOUNT_MGR_ID, CUST
OMER_SINCE, CUSTOMER_CLASS, SUGGESTIONS, DOB, MAILSHOT, PARTNER_
MAILSHOT, PREFERRED_ADDRESS, PREFERRED_CARD FROM CUSTOMERS WHERE

    420.98        7,752       0.05    3.2     189.33         162,465  140204897
Module: New Order
SELECT CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD_NUMBER, EXPIRY_DATE
, IS_VALID, SECURITY_CODE FROM CARD_DETAILS WHERE CUSTOMER_ID =
:B2 AND ROWNUM < :B1

    274.84        2,900       0.09    2.1       8.78          23,852 1283549268
Module: Swingbench User Thread
BEGIN :1 := orderentry.newcustomer(:2 ,:3 ,:4 ,:5 ,:6 ,:7 ,:8 ,:
9 ,:10 ); END;

    251.45       29,005       0.01    1.9       6.73          15,764 1113394757
Module: Browse Products
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.PRODUCT_ID = :B2 AND INVE

    245.90       22,219       0.01    1.9       4.29          15,437 2308915322
Module: New Order
SELECT QUANTITY_ON_HAND FROM PRODUCT_INFORMATION P, INVENTORIES
I WHERE I.PRODUCT_ID = :B2 AND I.PRODUCT_ID = P.PRODUCT_ID AND I
.WAREHOUSE_ID = :B1

    191.15        7,752       0.02    1.5       4.08          15,725 4194254847
Module: New Order
INSERT INTO ORDERS ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_
ID, ORDER_STATUS, WAREHOUSE_ID, DELIVERY_TYPE, DELIVERY_ADDRESS_
ID, COST_OF_DELIVERY, WAIT_TILL_ALL_AVAILABLE, CUSTOMER_CLASS, C
ARD_ID, INVOICE_ADDRESS_ID ) VALUES ( ORDERS_SEQ.NEXTVAL + :B8 ,
SQL ordered by Elapsed time for DB: XE  Instance: xe  Snaps: 53 -63
-> Total DB Time (s):          12,968
-> Captured SQL accounts for    0.1% of Total DB Time
-> SQL reported below exceeded  1.0% of Total DB Time

  Elapsed                Elap per            CPU                        Old
  Time (s)   Executions  Exec (s)  %Total   Time (s)  Physical Reads Hash Value
---------- ------------ ---------- ------ ---------- --------------- ----------

    184.04       20,153       0.01    1.4       5.76          16,222 4219272024
Module: New Order
INSERT INTO ORDER_ITEMS ( ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UN
IT_PRICE, QUANTITY, GIFT_WRAP, CONDITION, ESTIMATED_DELIVERY ) V
ALUES ( :B4 , :B3 , :B2 , :B1 , 1, 'None', 'New', (SYSDATE + 3)
)

    164.77        8,714       0.02    1.3       3.39          21,874  336093312
Module: New Order
SELECT ADDRESS_ID, CUSTOMER_ID, DATE_CREATED, HOUSE_NO_OR_NAME,
STREET_NAME, TOWN, COUNTY, COUNTRY, POST_CODE, ZIP_CODE FROM ADD
RESSES WHERE CUSTOMER_ID = :B2 AND ROWNUM < :B1

    162.78        2,900       0.06    1.3       2.59          10,708 3463613875
Module: Update Customer Details
INSERT INTO CUSTOMERS ( CUSTOMER_ID , CUST_FIRST_NAME , CUST_LAS
T_NAME , NLS_LANGUAGE , NLS_TERRITORY , CREDIT_LIMIT , CUST_EMAI
L , ACCOUNT_MGR_ID, CUSTOMER_SINCE, CUSTOMER_CLASS, SUGGESTIONS,
 DOB, MAILSHOT, PARTNER_MAILSHOT, PREFERRED_ADDRESS, PREFERRED_C

          -------------------------------------------------------------
SQL ordered by Gets  DB/Inst: XE/xe  Snaps: 53-63
-> End Buffer Gets Threshold:     10000 Total Buffer Gets:      41,373,143
-> Captured SQL accounts for    0.2% of Total Buffer Gets
-> SQL reported below exceeded  1.0% of Total Buffer Gets

                                                     CPU      Elapsd     Old
  Buffer Gets    Executions  Gets per Exec  %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
     17,560,326        7,752        2,265.3   43.2   274.67   2487.90 3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

     14,983,836        7,752        1,932.9   36.9   189.33    420.98  140204897
Module: New Order
SELECT CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD_NUMBER, EXPIRY_DATE
, IS_VALID, SECURITY_CODE FROM CARD_DETAILS WHERE CUSTOMER_ID =
:B2 AND ROWNUM < :B1

      1,948,099       23,196           84.0    4.8    30.87    929.38 2319948924
Module: New Order
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_ID = :B3 AND INV

        603,381          995          606.4    1.5     9.07     83.63 3802135678
BEGIN :1 := orderentry.processorders(:2 ,:3 ,:4 ); END;

        596,376          995          599.4    1.5     8.36     81.70 1391979773
Module: Process Orders
WITH NEED_TO_PROCESS AS (SELECT ORDER_ID, CUSTOMER_ID FROM ORDER
S WHERE ORDER_STATUS <= 4 AND WAREHOUSE_ID = :B1 AND ROWNUM < 10
 ) SELECT O.ORDER_ID, OI.LINE_ITEM_ID, OI.PRODUCT_ID, OI.UNIT_PR
ICE, OI.QUANTITY, O.ORDER_MODE, O.ORDER_STATUS, O.ORDER_TOTAL, O

          -------------------------------------------------------------
SQL ordered by Reads  DB/Inst: XE/xe  Snaps: 53-63
-> End Disk Reads Threshold:      1000  Total Disk Reads:       8,136,651
-> Captured SQL accounts for    0.0% of Total Disk Reads
-> SQL reported below exceeded  1.0% of Total Disk Reads

                                                     CPU      Elapsd
  Physical Rds   Executions  Rds per Exec   %Total Time (s)  Time (s) Hash Value
--------------- ------------ -------------- ------ -------- --------- ----------
        345,806        7,752           44.6    4.2   274.67   2487.90 3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

        162,465        7,752           21.0    2.0   189.33    420.98  140204897
Module: New Order
SELECT CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD_NUMBER, EXPIRY_DATE
, IS_VALID, SECURITY_CODE FROM CARD_DETAILS WHERE CUSTOMER_ID =
:B2 AND ROWNUM < :B1

         98,878       23,196            4.3    1.2    30.87    929.38 2319948924
Module: New Order
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_ID = :B3 AND INV

          -------------------------------------------------------------
SQL ordered by Executions  DB/Inst: XE/xe  Snaps: 53-63
-> End Executions Threshold:       100  Total Executions:         277,306
-> Captured SQL accounts for    7.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
      29,005         406,098             14.0       0.00        0.01  1113394757
Module: Browse Products
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.PRODUCT_ID = :B2 AND INVE

      23,196         104,824              4.5       0.00        0.04  2319948924
Module: New Order
SELECT PRODUCTS.PRODUCT_ID, PRODUCT_NAME, PRODUCT_DESCRIPTION, C
ATEGORY_ID, WEIGHT_CLASS, WARRANTY_PERIOD, SUPPLIER_ID, PRODUCT_
STATUS, LIST_PRICE, MIN_PRICE, CATALOG_URL, QUANTITY_ON_HAND FRO
M PRODUCTS, INVENTORIES WHERE PRODUCTS.CATEGORY_ID = :B3 AND INV

      22,219          20,153              0.9       0.00        0.01  2308915322
Module: New Order
SELECT QUANTITY_ON_HAND FROM PRODUCT_INFORMATION P, INVENTORIES
I WHERE I.PRODUCT_ID = :B2 AND I.PRODUCT_ID = P.PRODUCT_ID AND I
.WAREHOUSE_ID = :B1

      21,286          21,286              1.0       0.00        0.01  2137532914
Module: Browse Products
INSERT INTO LOGON (LOGON_ID,CUSTOMER_ID, LOGON_DATE) VALUES (LOG
ON_SEQ.NEXTVAL, :B2 , :B1 )

      21,285          21,285              1.0       0.00        0.03  1822227481
Module: Browse Products
SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, NLS_LANGUAG
E, NLS_TERRITORY, CREDIT_LIMIT, CUST_EMAIL, ACCOUNT_MGR_ID, CUST
OMER_SINCE, CUSTOMER_CLASS, SUGGESTIONS, DOB, MAILSHOT, PARTNER_
MAILSHOT, PREFERRED_ADDRESS, PREFERRED_CARD FROM CUSTOMERS WHERE

      21,283          21,283              1.0       0.00        0.00  2293415029
Module: Browse Products
SELECT SYSDATE FROM DUAL

      20,153          20,153              1.0       0.00        0.01  4219272024
Module: New Order
INSERT INTO ORDER_ITEMS ( ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UN
IT_PRICE, QUANTITY, GIFT_WRAP, CONDITION, ESTIMATED_DELIVERY ) V
ALUES ( :B4 , :B3 , :B2 , :B1 , 1, 'None', 'New', (SYSDATE + 3)
)

      10,604           9,425              0.9       0.00        0.00  2566028731
select /*+ rule */ bucket_cnt, row_cnt, cache_cnt, null_cnt, tim
estamp#, sample_size, minimum, maximum, distcnt, lowval, hival,
density, col#, spare1, spare2, avgcln, minimum_enc, maximum_enc
from hist_head$ where obj#=:1 and intcol#=:2

       9,672           9,672              1.0       0.00        0.07  1852190137
Module: Swingbench User Thread
BEGIN :1 := orderentry.browseproducts(:2 ,:3 ,:4 ); END;
SQL ordered by Executions  DB/Inst: XE/xe  Snaps: 53-63
-> End Executions Threshold:       100  Total Executions:         277,306
-> Captured SQL accounts for    7.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------

       8,714          13,136              1.5       0.00        0.02   336093312
Module: New Order
SELECT ADDRESS_ID, CUSTOMER_ID, DATE_CREATED, HOUSE_NO_OR_NAME,
STREET_NAME, TOWN, COUNTY, COUNTRY, POST_CODE, ZIP_CODE FROM ADD
RESSES WHERE CUSTOMER_ID = :B2 AND ROWNUM < :B1

       7,752          11,403              1.5       0.02        0.05   140204897
Module: New Order
SELECT CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD_NUMBER, EXPIRY_DATE
, IS_VALID, SECURITY_CODE FROM CARD_DETAILS WHERE CUSTOMER_ID =
:B2 AND ROWNUM < :B1

       7,752           7,752              1.0       0.04        0.32  3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

       7,752           7,752              1.0       0.00        0.00  3812575787
Module: New Order
UPDATE ORDERS SET ORDER_MODE = 'online', ORDER_STATUS = FLOOR(DB
MS_RANDOM.VALUE(0, :B3 )), ORDER_TOTAL = :B2 WHERE ORDER_ID = :B
1

       7,752           7,752              1.0       0.00        0.02  4194254847
Module: New Order
INSERT INTO ORDERS ( ORDER_ID, ORDER_DATE, ORDER_MODE, CUSTOMER_
ID, ORDER_STATUS, WAREHOUSE_ID, DELIVERY_TYPE, DELIVERY_ADDRESS_
ID, COST_OF_DELIVERY, WAIT_TILL_ALL_AVAILABLE, CUSTOMER_CLASS, C
ARD_ID, INVOICE_ADDRESS_ID ) VALUES ( ORDERS_SEQ.NEXTVAL + :B8 ,

       7,326          20,153              2.8       0.00        0.00  2385983258
Module: New Order
UPDATE INVENTORIES SET QUANTITY_ON_HAND = QUANTITY_ON_HAND - :B1
 WHERE PRODUCT_ID = :B3 AND WAREHOUSE_ID = :B2

       3,496           3,496              1.0       0.00        0.03   522486300
Module: Update Customer Details
INSERT INTO ADDRESSES ( ADDRESS_ID, CUSTOMER_ID, DATE_CREATED, H
OUSE_NO_OR_NAME, STREET_NAME, TOWN, COUNTY, COUNTRY, POST_CODE,
ZIP_CODE ) VALUES ( :B6 , :B5 , TRUNC(SYSDATE,'MI'), FLOOR(DBMS_
RANDOM.VALUE(1, :B4 )), 'Street Name', :B3 , :B2 , :B1 , 'Postco

       3,496           3,496              1.0       0.00        0.00  4084548783
Module: Update Customer Details
SELECT ADDRESS_SEQ.NEXTVAL FROM DUAL

       3,311             916              0.3       0.00        0.00   214372507
select o.owner#,o.name,o.namespace,o.remoteowner,o.linkname,o.su
bname from obj$ o where o.obj#=:1

       2,900           2,900              1.0       0.00        0.01  1006760834
Module: Update Customer Details
SQL ordered by Executions  DB/Inst: XE/xe  Snaps: 53-63
-> End Executions Threshold:       100  Total Executions:         277,306
-> Captured SQL accounts for    7.9% of Total Executions
-> SQL reported below exceeded  1.0% of Total Executions

                                                CPU per    Elap per     Old
 Executions   Rows Processed   Rows per Exec    Exec (s)   Exec (s)  Hash Value
------------ --------------- ---------------- ----------- ---------- ----------
INSERT INTO CARD_DETAILS ( CARD_ID, CUSTOMER_ID, CARD_TYPE, CARD
_NUMBER, EXPIRY_DATE, IS_VALID, SECURITY_CODE ) VALUES ( :B2 , :
B1 , 'Visa(Debit)', FLOOR(DBMS_RANDOM.VALUE(1111111111, 99999999
99)), TRUNC(SYSDATE + (DBMS_RANDOM.VALUE(365, 1460))), 'Y', FLOO

       2,900           2,900              1.0       0.00        0.09  1283549268
Module: Swingbench User Thread
BEGIN :1 := orderentry.newcustomer(:2 ,:3 ,:4 ,:5 ,:6 ,:7 ,:8 ,:
9 ,:10 ); END;

       2,900           2,900              1.0       0.00        0.00  1888432089
Module: Update Customer Details
SELECT CARD_DETAILS_SEQ.NEXTVAL FROM DUAL

       2,900           2,900              1.0       0.00        0.00  2690112681
Module: Update Customer Details
SELECT CUSTOMER_SEQ.NEXTVAL FROM DUAL

       2,900           2,900              1.0       0.00        0.06  3463613875
Module: Update Customer Details
INSERT INTO CUSTOMERS ( CUSTOMER_ID , CUST_FIRST_NAME , CUST_LAS
T_NAME , NLS_LANGUAGE , NLS_TERRITORY , CREDIT_LIMIT , CUST_EMAI
L , ACCOUNT_MGR_ID, CUSTOMER_SINCE, CUSTOMER_CLASS, SUGGESTIONS,
 DOB, MAILSHOT, PARTNER_MAILSHOT, PREFERRED_ADDRESS, PREFERRED_C

          -------------------------------------------------------------
SQL ordered by Parse Calls  DB/Inst: XE/xe  Snaps: 53-63
-> End Parse Calls Threshold:      1000 Total Parse Calls:          50,806
-> Captured SQL accounts for   14.3% of Total Parse Calls
-> SQL reported below exceeded  1.0% of Total Parse Calls

                           % Total    Old
 Parse Calls   Executions   Parses Hash Value
------------ ------------ -------- ----------
       9,669        9,672    19.03 1852190137
Module: Swingbench User Thread
BEGIN :1 := orderentry.browseproducts(:2 ,:3 ,:4 ); END;

       7,752        7,752    15.26 3565022785
Module: Swingbench User Thread
BEGIN :1 := orderentry.neworder(:2 ,:3 ,:4 ); END;

       2,900        2,900     5.71 1283549268
Module: Swingbench User Thread
BEGIN :1 := orderentry.newcustomer(:2 ,:3 ,:4 ,:5 ,:6 ,:7 ,:8 ,:
9 ,:10 ); END;

       1,885        1,885     3.71 2254572530
Module: Swingbench User Thread
BEGIN :1 := orderentry.updateCustomerDetails(:2 ,:3 ,:4 ,:5 ,:6
,:7 ,:8 ); END;

         995          995     1.96 3802135678
BEGIN :1 := orderentry.processorders(:2 ,:3 ,:4 ); END;

         971        3,496     1.91  522486300
Module: Update Customer Details
INSERT INTO ADDRESSES ( ADDRESS_ID, CUSTOMER_ID, DATE_CREATED, H
OUSE_NO_OR_NAME, STREET_NAME, TOWN, COUNTY, COUNTRY, POST_CODE,
ZIP_CODE ) VALUES ( :B6 , :B5 , TRUNC(SYSDATE,'MI'), FLOOR(DBMS_
RANDOM.VALUE(1, :B4 )), 'Street Name', :B3 , :B2 , :B1 , 'Postco

         971        3,496     1.91 4084548783
Module: Update Customer Details
SELECT ADDRESS_SEQ.NEXTVAL FROM DUAL

         962          962     1.89 2835506982
BEGIN :1 := orderentry.browseandupdateorders(:2 ,:3 ,:4 ); END;

          -------------------------------------------------------------
truncate table STATS$TEMP_SQLSTATS
               *
ERROR at line 1:
ORA-00942: table or view does not exist


Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
ASSM cbk:blocks examined                      79,556            6.3          4.0
ASSM cbk:blocks marked full                   26,541            2.1          1.3
ASSM gsp:L1 bitmaps examined                  56,648            4.5          2.8
ASSM gsp:L2 bitmap full                           52            0.0          0.0
ASSM gsp:L2 bitmaps examined                  18,387            1.5          0.9
ASSM gsp:Search all                               29            0.0          0.0
ASSM gsp:Search hint                             141            0.0          0.0
ASSM gsp:Search steal                             29            0.0          0.0
ASSM gsp:bump HWM                                 29            0.0          0.0
ASSM gsp:get free block                       53,081            4.2          2.6
ASSM gsp:good hint                            34,838            2.8          1.7
ASSM gsp:reject db                                 0            0.0          0.0
ASSM rsv:fill reserve                              8            0.0          0.0
ASSM wasted db state change                       44            0.0          0.0
Batched IO (bound) vector count                  286            0.0          0.0
Batched IO block miss count                    6,210            0.5          0.3
Batched IO double miss count                   1,857            0.2          0.1
Batched IO same unit count                       135            0.0          0.0
Batched IO single block count                  1,160            0.1          0.1
Batched IO vector block count                  5,139            0.4          0.3
Batched IO vector read count                     982            0.1          0.1
Block Cleanout Optim referenced                4,634            0.4          0.2
CCursor + sql area evicted                     2,044            0.2          0.1
CPU used by this session                     686,009           54.3         34.2
CPU used when call started                   686,056           54.3         34.2
CR blocks created                              2,590            0.2          0.1
Cached Commit SCN referenced                 262,255           20.8         13.1
Commit SCN cached                                 44            0.0          0.0
DB time                                    1,435,208          113.6         71.5
DML statements retried                             4            0.0          0.0
Effective IO time                         25,220,958        1,996.4      1,255.6
HSC Compressed Segment Block Chan                  0            0.0          0.0
HSC Heap Segment Block Changes                87,368            6.9          4.4
HSC IDL Compressed Blocks                     67,300            5.3          3.4
HSC OLTP Non Compressible Blocks                   0            0.0          0.0
HSC OLTP Space Saving                              0            0.0          0.0
HSC OLTP inline compression                        0            0.0          0.0
HSC OLTP positive compression                      0            0.0          0.0
Heap Segment Array Inserts                       271            0.0          0.0
Heap Segment Array Updates                       139            0.0          0.0
Heatmap BlkLevel Flushed                          66            0.0          0.0
Heatmap BlkLevel Flushed to BF                     0            0.0          0.0
Heatmap BlkLevel Flushed to SYSAU                 66            0.0          0.0
Heatmap BlkLevel Ranges Flushed                   66            0.0          0.0
IMU CR rollbacks                                  35            0.0          0.0
IMU Flushes                                    2,929            0.2          0.2
IMU Redo allocation size                   9,512,916          753.0        473.6
IMU commits                                   17,001            1.4          0.9
IMU contention                                 1,871            0.2          0.1
IMU ktichg flush                                 168            0.0          0.0
IMU pool not allocated                            97            0.0          0.0
IMU recursive-transaction flush                    2            0.0          0.0
IMU undo allocation size                  58,645,136        4,642.2      2,919.6
IMU- failed to get a private stra                 97            0.0          0.0
KTFB alloc myinst                              1,491            0.1          0.1
KTFB alloc req                                 2,081            0.2          0.1
Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
KTFB alloc search FFB                          1,582            0.1          0.1
KTFB alloc space (block)               1,207,458,440       95,579.7     60,111.4
KTFB alloc steal                                   0            0.0          0.0
KTFB alloc time (ms)                         754,452           59.7         37.6
KTFB apply req                                 2,288            0.2          0.1
KTFB apply time (ms)                         679,666           53.8         33.8
KTFB commit req                                  164            0.0          0.0
KTFB commit time (ms)                         83,439            6.6          4.2
KTFB free req                                  1,868            0.2          0.1
KTFB free space (block)                      150,152           11.9          7.5
KTFB free time (ms)                          454,822           36.0         22.6
LOB table id lookup cache misses                   0            0.0          0.0
Number of read IOs issued                      6,596            0.5          0.3
Requests to/from client                       43,023            3.4          2.1
RowCR attempts                                 6,760            0.5          0.3
RowCR hits                                     6,758            0.5          0.3
SQL*Net roundtrips to/from client             43,023            3.4          2.1
TBS Extension: tasks created                       0            0.0          0.0
active txn count during cleanout               9,752            0.8          0.5
application wait time                          2,052            0.2          0.1
blocks cleaned out using minact              466,702           36.9         23.2
branch node splits                                88            0.0          0.0
buffer is not pinned count                   986,013           78.1         49.1
buffer is pinned count                       967,934           76.6         48.2
bytes received via SQL*Net from c          5,129,850          406.1        255.4
bytes sent via SQL*Net to client           2,314,731          183.2        115.2
calls to get snapshot scn: kcmgss          1,226,188           97.1         61.0
calls to kcmgas                              533,318           42.2         26.6
calls to kcmgcs                              372,732           29.5         18.6
cell physical IO interconnect byt     70,344,728,576    5,568,331.2  3,502,002.7
change write time                             18,286            1.5          0.9
cleanout - number of ktugct calls             38,985            3.1          1.9
cleanouts and rollbacks - consist                 38            0.0          0.0
cleanouts only - consistent read              10,016            0.8          0.5
cluster key scan block gets                   20,004            1.6          1.0
cluster key scans                             14,400            1.1          0.7
commit batch performed                             0            0.0          0.0
commit batch requested                             0            0.0          0.0
commit batch/immediate performed               1,431            0.1          0.1
commit batch/immediate requested               1,431            0.1          0.1
commit cleanout failures: block l                  1            0.0          0.0
commit cleanout failures: buffer                  15            0.0          0.0
commit cleanout failures: callbac                349            0.0          0.0
commit cleanout failures: cannot                 257            0.0          0.0
commit cleanouts                           1,871,522          148.2         93.2
commit cleanouts successfully com          1,870,900          148.1         93.1
commit immediate performed                     1,431            0.1          0.1
commit immediate requested                     1,431            0.1          0.1
commit nowait performed                            0            0.0          0.0
commit nowait requested                            0            0.0          0.0
commit txn count during cleanout              40,147            3.2          2.0
commit wait performed                             49            0.0          0.0
commit wait requested                             49            0.0          0.0
commit wait/nowait performed                      49            0.0          0.0
commit wait/nowait requested                      49            0.0          0.0
concurrency wait time                            954            0.1          0.1
Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
consistent changes                             2,701            0.2          0.1
consistent gets                           33,611,729        2,660.6      1,673.3
consistent gets direct                       652,627           51.7         32.5
consistent gets examination               16,448,769        1,302.1        818.9
consistent gets examination (fast         16,200,037        1,282.4        806.5
consistent gets from cache                32,959,102        2,609.0      1,640.8
consistent gets pin                       16,510,333        1,306.9        821.9
consistent gets pin (fastpath)            15,842,909        1,254.1        788.7
cursor authentications                           681            0.1          0.0
cursor reload failures                            18            0.0          0.0
data blocks consistent reads - un                181            0.0          0.0
db block changes                          15,331,175        1,213.6        763.2
db block gets                              7,761,414          614.4        386.4
db block gets direct                         106,823            8.5          5.3
db block gets from cache                   7,654,591          605.9        381.1
db block gets from cache (fastpat          5,137,491          406.7        255.8
deferred (CURRENT) block cleanout          1,219,835           96.6         60.7
dirty buffers inspected                    1,242,712           98.4         61.9
doubling up with imu segment                       1            0.0          0.0
enqueue conversions                            8,560            0.7          0.4
enqueue releases                             615,642           48.7         30.7
enqueue requests                             615,672           48.7         30.7
enqueue timeouts                                  35            0.0          0.0
enqueue waits                                    461            0.0          0.0
execute count                                277,306           22.0         13.8
failed probes on index block recl                  0            0.0          0.0
fastpath consistent get quota lim                  0            0.0          0.0
file io service time                         664,589           52.6         33.1
file io wait time                     11,479,389,794      908,682.8    571,483.5
free buffer inspected                      7,657,500          606.2        381.2
free buffer requested                      7,333,433          580.5        365.1
heap block compress                              441            0.0          0.0
hot buffers moved to head of LRU           1,192,636           94.4         59.4
immediate (CR) block cleanout app             10,054            0.8          0.5
immediate (CURRENT) block cleanou            558,267           44.2         27.8
in call idle wait time                       138,897           11.0          6.9
index crx upgrade (positioned)                 5,206            0.4          0.3
index fast full scans (full)                     340            0.0          0.0
index fetch by key                         5,445,045          431.0        271.1
index range scans                            165,527           13.1          8.2
leaf node 90-10 splits                             9            0.0          0.0
leaf node splits                              26,377            2.1          1.3
lob reads                                          7            0.0          0.0
lob writes                                         7            0.0          0.0
lob writes unaligned                               7            0.0          0.0
logical read bytes from cache        332,707,373,056   26,336,370.9 ############
logons cumulative                                 10            0.0          0.0
max cf enq hold time                               0            0.0          0.0
messages sent                                483,698           38.3         24.1
min active SCN optimization appli                240            0.0          0.0
no buffer to keep pinned count                     0            0.0          0.0
no work - consistent read gets            16,010,759        1,267.4        797.1
non-idle wait count                        2,715,994          215.0        135.2
non-idle wait time                           628,570           49.8         31.3
opened cursors cumulative                    273,583           21.7         13.6
parse count (failures)                            25            0.0          0.0
Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
parse count (hard)                             3,652            0.3          0.2
parse count (total)                           50,806            4.0          2.5
parse time cpu                                 1,465            0.1          0.1
parse time elapsed                             2,173            0.2          0.1
physical read IO requests                  2,535,173          200.7        126.2
physical read bytes                   66,655,444,992    5,276,295.8  3,318,337.5
physical read total IO requests            2,535,602          200.7        126.2
physical read total bytes             66,662,473,728    5,276,852.2  3,318,687.4
physical read total multi block r             77,551            6.1          3.9
physical reads                             8,136,651          644.1        405.1
physical reads cache                       7,141,881          565.3        355.6
physical reads cache prefetch              4,659,880          368.9        232.0
physical reads direct                        994,770           78.7         49.5
physical reads direct (lob)                        0            0.0          0.0
physical reads direct temporary t            342,143           27.1         17.0
physical reads prefetch warmup                     0            0.0          0.0
physical write IO requests                    19,209            1.5          1.0
physical write bytes                   3,677,929,472      291,136.7    183,100.0
physical write total IO requests              19,473            1.5          1.0
physical write total bytes             3,682,254,848      291,479.1    183,315.3
physical write total multi block              11,549            0.9          0.6
physical writes                              448,966           35.5         22.4
physical writes direct                       448,966           35.5         22.4
physical writes direct (lob)                       0            0.0          0.0
physical writes direct temporary             342,143           27.1         17.0
physical writes non checkpoint               448,966           35.5         22.4
pinned buffers inspected                       2,147            0.2          0.1
pinned cursors current                             0            0.0          0.0
prefetch clients - default                        30            0.0          0.0
prefetch warmup blocks aged out b                  0            0.0          0.0
prefetched blocks aged out before              5,294            0.4          0.3
process last non-idle time                    12,634            1.0          0.6
recursive calls                              422,581           33.5         21.0
recursive cpu usage                          672,683           53.3         33.5
redo buffer allocation retries                    24            0.0          0.0
redo entries                               7,898,241          625.2        393.2
redo log space requests                           49            0.0          0.0
redo log space wait time                         246            0.0          0.0
redo ordering marks                                0            0.0          0.0
redo size                              3,391,040,124      268,427.2    168,817.7
redo size for direct writes              706,393,408       55,916.5     35,166.7
redo synch long waits                              0            0.0          0.0
redo synch time                               19,022            1.5          1.0
redo synch time (usec)                   190,224,551       15,057.8      9,470.0
redo synch time overhead (usec)            4,599,750          364.1        229.0
redo synch time overhead count (              19,919            1.6          1.0
redo synch time overhead count (                 170            0.0          0.0
redo synch time overhead count (                  19            0.0          0.0
redo synch time overhead count (1                  0            0.0          0.0
redo synch writes                             20,165            1.6          1.0
redo write info find                          20,108            1.6          1.0
rollback changes - undo records a                199            0.0          0.0
rollbacks only - consistent read                 133            0.0          0.0
rows fetched via callback                    161,585           12.8          8.0
scheduler wait time                               13            0.0          0.0
securefile add dedupd lob to set                   0            0.0          0.0
Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
securefile allocation bytes                        0            0.0          0.0
securefile allocation chunks                       0            0.0          0.0
securefile bytes deduplicated                      0            0.0          0.0
securefile bytes non-transformed                   0            0.0          0.0
securefile create dedup set                        0            0.0          0.0
securefile dedup callback oper fi                  0            0.0          0.0
securefile direct read bytes                       0            0.0          0.0
securefile direct read ops                         0            0.0          0.0
securefile direct write bytes                      0            0.0          0.0
securefile direct write ops                        0            0.0          0.0
securefile number of flushes                       0            0.0          0.0
securefile number of non-transfor                  0            0.0          0.0
segment cfs allocations                            0            0.0          0.0
segment chunks allocation from di                  0            0.0          0.0
segment dispenser allocations                      0            0.0          0.0
segment dispenser load empty                       0            0.0          0.0
segment dispenser load tasks                       0            0.0          0.0
segment prealloc tasks                             0            0.0          0.0
segment total chunk allocation                     0            0.0          0.0
session cursor cache hits                    260,821           20.7         13.0
session logical reads                     41,373,143        3,275.0      2,059.7
session uga memory max                    56,949,648        4,508.0      2,835.2
shared hash latch upgrades - no w            140,455           11.1          7.0
shared hash latch upgrades - wait                 20            0.0          0.0
shared io pool buffer get success                  0            0.0          0.0
sorts (disk)                                     133            0.0          0.0
sorts (memory)                                12,399            1.0          0.6
sorts (rows)                             891,442,988       70,564.6     44,379.1
sql area evicted                               2,214            0.2          0.1
sql area purged                                  138            0.0          0.0
switch current caused by our pin               2,472            0.2          0.1
switch current to new buffer                   2,626            0.2          0.1
table fetch by rowid                         680,513           53.9         33.9
table fetch continued row                        606            0.1          0.0
table scan blocks gotten                  14,555,493        1,152.2        724.6
table scan disk non-IMC rows gott      1,681,436,241      133,098.7     83,707.7
table scan rows gotten                 1,681,436,688      133,098.8     83,707.7
table scans (direct read)                        325            0.0          0.0
table scans (long tables)                        438            0.0          0.0
table scans (short tables)                    41,770            3.3          2.1
temp space allocated (bytes)                       0            0.0          0.0
total cf enq hold time                         1,200            0.1          0.1
total number of cf enq holders                    66            0.0          0.0
transaction rollbacks                             99            0.0          0.0
undo change vector size                1,012,665,536       80,160.3     50,414.0
user I/O wait time                           605,634           47.9         30.2
user calls                                    64,591            5.1          3.2
user commits                                  20,086            1.6          1.0
user logons cumulative                            10            0.0          0.0
user logouts cumulative                           10            0.0          0.0
user rollbacks                                     1            0.0          0.0
workarea executions - multipass                    2            0.0          0.0
workarea executions - onepass                    131            0.0          0.0
workarea executions - optimal                 11,760            0.9          0.6
write clones created in foregroun                497            0.0          0.0
Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63

Statistic                                      Total     per Second    per Trans
--------------------------------- ------------------ -------------- ------------
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63
-> Statistics with absolute values (should not be diffed)

Statistic                             Begin Value       End Value
--------------------------------- --------------- ---------------
logons current                                  1               1
opened cursors current                         32              29
session cursor cache count                    174             750
          -------------------------------------------------------------

Instance Activity Stats  DB/Inst: XE/xe  Snaps: 53-63
-> Statistics identified by '(derived)' come from sources other than SYSSTAT

Statistic                                      Total  per Hour
--------------------------------- ------------------ ---------
log switches (derived)                            20      5.70
          -------------------------------------------------------------

OS Statistics  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by statistic type (CPU use, Virtual Memory, Hardware Config), Name

Statistic                                  Total
------------------------- ----------------------
FREE_MEMORY_BYTES                     41,259,008
INACTIVE_MEMORY_BYTES                648,540,160
BUSY_TIME                                680,695
IDLE_TIME                              1,693,380
IOWAIT_TIME                              369,429
NICE_TIME                                      0
SYS_TIME                                  51,478
USER_TIME                                592,447
RSRC_MGR_CPU_WAIT_TIME                        27
VM_IN_BYTES                           11,317,248
VM_OUT_BYTES                          29,417,472
PHYSICAL_MEMORY_BYTES              1,830,281,216
NUM_CPUS                                       2
NUM_CPU_CORES                                  2
NUM_CPU_SOCKETS                                1
GLOBAL_RECEIVE_SIZE_MAX                4,194,304
GLOBAL_SEND_SIZE_MAX                   1,048,576
TCP_RECEIVE_SIZE_DEFAULT                  87,380
TCP_RECEIVE_SIZE_MAX                   6,291,456
TCP_RECEIVE_SIZE_MIN                       4,096
TCP_SEND_SIZE_DEFAULT                     16,384
TCP_SEND_SIZE_MAX                      4,194,304
TCP_SEND_SIZE_MIN                          4,096
          -------------------------------------------------------------

OS Statistics - detail  DB/Inst: XE/xe  Snaps: 53-63

  Snap Snapshot
    Id Day Time          Load  %Busy  %User %System   %WIO  %WCPU
------ --------------- ------ ------ ------ ------- ------ ------
    53 Tue 04 11:06:11     .1
    63 Tue 04 14:36:44     .1   28.7   25.0     2.2   15.6
          -------------------------------------------------------------
IO Stat by Function - summary  DB/Inst: XE/xe  Snaps: 53-63
->Data Volume values suffixed with   M,G,T,P are in multiples of 1024,
  other values suffixed with       K,M,G,T,P are in multiples of 1000
->ordered by Data Volume (Read+Write) desc

               ---------- Read --------- --------- Write -------- --- Wait ----
                 Data  Requests    Data   Data  Requests    Data          Avg
Function        Volume     /sec  Vol/sec Volume     /sec  Vol/sec  Count Tm(ms)
--------------- ------ -------- -------- ------ -------- -------- ------ ------
Buffer Cache Re    55G   198.6      4.4M                           2489K    0.0
DBWR                        .0              15G    20.5      1.2M     7     0.0
Others           4177M     3.5       .3M  3796M     1.4       .3M    41K    0.0
Direct Reads     7580M     2.6       .6M   328M      .0       .0M           0.0
LGWR                3M      .0       .0M  3502M    38.2       .3M   267     0.0
Direct Writes     194M      .2       .0M  3126M     1.5       .2M           0.0
Streams AQ                  .0                                      106     0.0
          -------------------------------------------------------------

IO Stat by Function - detail  DB/Inst: XE/xe  Snaps: 53-63
->ordered by Data Volume (Read+Write) desc

                   ----------- Read ---------- ----------- Write ---------
                    Small  Large  Small  Large  Small  Large  Small  Large
                     Read   Read   Data   Data  Write  Write   Data   Data
Function             Reqs   Reqs   Read   Read   Reqs   Reqs  Writn  Writn
------------------ ------ ------ ------ ------ ------ ------ ------ ------
Buffer Cache Reads  2445K    64K    19G    35G
DBWR                   7                         171K    88K  3831M    11G
Others                41K  3560    641M  3536M    14K  3591    226M  3570M
Direct Reads          20K    13K  1016M  6564M   142    473      1M   327M
LGWR                 227             3M          480K  2445   1739M  1763M
Direct Writes       2489     65    130M    64M  7569     11K   243M  2883M
Streams AQ           106
          -------------------------------------------------------------
Tablespace IO Stats  DB/Inst: XE/xe  Snaps: 53-63
->ordered by IOs (Reads + Writes) desc

Tablespace
------------------------------
                 Av      Av     Av                    Av        Buffer Av Buf
         Reads Reads/s Rd(ms) Blks/Rd       Writes Writes/s      Waits Wt(ms)
-------------- ------- ------ ------- ------------ -------- ---------- ------
SOE
     2,499,095     198    2.4     3.1      249,894       20     58,918    3.7
TEMP
        28,894       2   15.7    11.8       12,719        1          0    0.0
UNDO_TBS
           367       0    5.3     1.0       13,222        1          3    0.0
SYSTEM
         6,020       0    1.8     2.2        1,249        0         43    4.9
SYSAUX
         2,866       0    1.9     3.4          111        0          9    7.8
USERS
           362       0    1.6     2.1          193        0          0    0.0
          -------------------------------------------------------------
File IO Stats  DB/Inst: XE/xe  Snaps: 53-63
->Mx Rd Bkt: Max bucket time for single block read
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
                        Av   Mx                                             Av
                 Av     Rd   Rd    Av                    Av        Buffer BufWt
         Reads Reads/s (ms)  Bkt Blks/Rd       Writes Writes/s      Waits  (ms)
-------------- ------- ----- --- ------- ------------ -------- ---------- ------
SOE                      /oradata/XE/pdbxe/soe.dbf
     2,499,095     198   2.4   1     3.1      249,894       20     58,918    3.7

SYSAUX                   /opt/oracle/oradata/XE/pdbxe/sysaux.dbf
         2,866       0   1.9   1     3.4          111        0          9    7.8

SYSTEM                   /opt/oracle/oradata/XE/pdbxe/system01.dbf
         6,020       0   1.8   1     2.2        1,249        0         43    4.9

TEMP                     /opt/oracle/oradata/XE/pdbxe/temp01.dbf
        28,894       2  15.7        11.8       12,719        1          0

UNDO_TBS                 /oradata/XE/pdbxe/undo_tbs.dbf
           367       0   5.3   1     1.0       13,222        1          3    0.0

USERS                    /opt/oracle/oradata/XE/pdbxe/users.dbf
           362       0   1.6   1     2.1          193        0          0

          -------------------------------------------------------------
File Read Histogram Stats  DB/Inst: XE/xe  Snaps: 53-63
->Number of single block reads in each time range
->Tempfiles are not included
->ordered by Tablespace, File

Tablespace               Filename
------------------------ ----------------------------------------------------
    0 - 2 ms     2 - 4 ms    4 - 8 ms     8 - 16 ms   16 - 32 ms       32+ ms
------------ ------------ ------------ ------------ ------------ ------------
SOE                      /oradata/XE/pdbxe/soe.dbf
   1,680,596            0            0            0            0            0

UNDO_TBS                 /oradata/XE/pdbxe/undo_tbs.dbf
         133            0            0            0            0            0

SYSAUX                   /opt/oracle/oradata/XE/pdbxe/sysaux.dbf
       1,599            0            0            0            0            0

USERS                    /opt/oracle/oradata/XE/pdbxe/users.dbf
         303            0            0            0            0            0

SYSTEM                   /opt/oracle/oradata/XE/pdbxe/system01.dbf
       4,022            0            0            0            0            0

          -------------------------------------------------------------
IO Stats Function Detail  DB/Inst: XE/xe  Snaps: 53-63

                            Small   Small   Large   Large
Function     FileType        Read   Write    Read   Write             Wait Time
Name         Name            (MB)    (MB)    (MB)    (MB)     Waits        (ms)
------------ ------------ ------- ------- ------- ------- --------- -----------
DBWR         Control File       0       0       0       0         7          17
DBWR         Data File          0    3830       0   11061         0           0
DBWR         Temp File          0       1       0       0         0           0
LGWR         Control File       3       6       0       0       187         370
LGWR         Data File          0       0       0       0         0           0
LGWR         Log File           0    1733       0    1763        80         323
Streams AQ   Data File          0       0       0       0       106         288
Buffer Cache Data File      19830       0   36092       0   2488837     5848684
Buffer Cache Temp File          0       0       0       0        27          30
Inmemory Pop Data File          2       0    5035     282         0           0
Inmemory Pop Temp File       1014       1    1529      45         0           0
Direct Reads Data File          0     193      64     306         0           0
Direct Reads Temp File        130      50       0    2577         0           0
Archive Mana External Tab       0       0       0       0         0           0
Archive Mana Archive Log        0       0       0    3509         0           0
Archive Mana Temp File          0       0       0       0         0           0
Archive Mana Parameter Fi       0       0       0       0        32          57
Archive Mana Password Fil       0       0       0       0         0           0
Archive Mana Data File          0       4       0      61         3           9
Archive Mana Control File     640     222      27       0     41010       49142
Archive Mana Log File           1       0    3509       0        80         445
          -------------------------------------------------------------
Instance Recovery Stats  DB/Inst: XE/xe  Snaps: 53-63
-> B: Begin snapshot,  E: End snapshot

  Targt Estd                                  Log File  Log Ckpt    Log Ckpt
  MTTR  MTTR   Recovery   Actual    Target      Size     Timeout    Interval
   (s)   (s)   Estd IOs  Redo Blks Redo Blks Redo Blks  Redo Blks  Redo Blks
- ----- ----- ---------- --------- --------- ---------- --------- ------------
B     0    18        488      2449      2414     663552      2414
E     0    18        369      2094    663552     663552   1341884
          -------------------------------------------------------------

Memory Dynamic Components  DB/Inst: XE/xe  Snaps: 53-63
->  Op - memory resize Operation
->  Cache:    D: Default,  K: Keep,  R:  Recycle
->   Mode:  DEF: DEFerred mode,  IMM: IMMediate mode

                       Begin Snap End Snap   Op    Last Op
Cache                    Size (M) Size (M)  Count  Type/Mode   Last Op Time
---------------------- ---------- -------- ------- ---------- ---------------
D:32K buffer cache            200                0 INITIA/
D:buffer cache                392                0 SHRINK/DEF 03-May 12:19:41
K:buffer cache                100                0 INITIA/
PGA Target                    256                0 STATIC
SGA Target                  1,024                0 STATIC
Shared IO Pool                 32                0 GROW/IMM   02-May 05:39:01
java pool                       4                0 STATIC
large pool                      8                0 SHRINK/DEF 02-May 05:38:36
shared pool                   276                0 GROW/DEF   03-May 12:19:41
          -------------------------------------------------------------

Buffer Pool Advisory  DB/Inst: XE/xe  End Snap: 63
-> Only rows with estimated physical reads >0 are displayed
-> ordered by Pool, Block Size, Buffers For Estimate

                                   Est
                                  Phys      Estimated                   Est
    Size for  Size      Buffers   Read     Phys Reads     Est Phys % dbtime
P    Est (M) Factr  (thousands)  Factr    (thousands)    Read Time  for Rds
--- -------- ----- ------------ ------ -------------- ------------ --------
D         36    .1            4    2.2         16,287       24,917    161.6
D         72    .2            9    2.1         15,164       22,555    146.3
D        108    .3           13    1.9         14,181       20,485    132.9
D        144    .4           18    1.8         13,212       18,446    119.7
D        180    .5           22    1.7         12,293       16,513    107.1
D        216    .6           26    1.5         11,396       14,625     94.9
D        252    .6           31    1.4         10,553       12,852     83.4
D        288    .7           35    1.3          9,746       11,154     72.4
D        324    .8           40    1.2          8,904        9,383     60.9
D        360    .9           44    1.1          8,119        7,731     50.1
D        392   1.0           48    1.0          7,367        6,148     39.9
D        396   1.0           48    1.0          7,283        5,971     38.7
D        432   1.1           53    0.9          6,466        4,253     27.6
D        468   1.2           57    0.8          5,704        2,650     17.2
D        504   1.3           61    0.6          4,498          805      5.2
D        540   1.4           66    0.4          2,884          758      4.9
D        576   1.5           70    0.3          2,379          743      4.8
D        612   1.6           75    0.3          2,059          733      4.8
D        648   1.7           79    0.3          1,963          730      4.7
D        684   1.7           83    0.3          1,932          730      4.7
D        720   1.8           88    0.3          1,914          729      4.7
K          8    .1            1    1.0              0            0       .0
K         16    .2            2    1.0              0            0       .0
K         24    .2            3    1.0              0            0       .0
K         32    .3            4    1.0              0            0       .0
K         40    .4            5    1.0              0            0       .0
K         48    .5            6    1.0              0            0       .0
K         56    .6            7    1.0              0            0       .0
K         64    .6            8    1.0              0            0       .0
K         72    .7            9    1.0              0            0       .0
K         80    .8           10    1.0              0            0       .0
K         88    .9           11    1.0              0            0       .0
K         96   1.0           12    1.0              0            0       .0
K        100   1.0           12    1.0              0            0       .0
K        104   1.0           13    1.0              0            0       .0
K        112   1.1           14    1.0              0            0       .0
K        120   1.2           15    1.0              0            0       .0
K        128   1.3           16    1.0              0            0       .0
K        136   1.4           17    1.0              0            0       .0
K        144   1.4           18    1.0              0            0       .0
K        152   1.5           19    1.0              0            0       .0
K        160   1.6           20    1.0              0            0       .0
          -------------------------------------------------------------

Buffer Pool Statistics  DB/Inst: XE/xe  Snaps: 53-63
-> Standard block size Pools  D: default,  K: keep,  R: recycle
-> Default Pools for other block sizes: 2k, 4k, 8k, 16k, 32k
-> Buffers: the number of buffers.  Units of K, M, G are divided by 1000

                                                            Free Writ     Buffer
            Pool         Buffer     Physical    Physical  Buffer Comp       Busy
P   Buffers Hit%           Gets        Reads      Writes   Waits Wait      Waits
--- ------- ---- -------------- ------------ ----------- ------- ---- ----------
32k   6200                    0            0           0       0    0          0
D       47K   82     40,851,397    7,159,247   1,906,064       0    0     58,994
K       12K   48            132           69           0       0    0          0
          -------------------------------------------------------------

Buffer wait Statistics  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by wait time desc, waits desc

Class                        Waits Total Wait Time (s) Avg Time (ms)
---------------------- ----------- ------------------- -------------
data block                  58,839                 216             4
segment header                  47                   0             9
2nd level bmb                   32                   0            12
1st level bmb                   52                   0             2
undo header                      3                   0             0
          -------------------------------------------------------------
PGA Aggr Target Stats  DB/Inst: XE/xe  Snaps: 53-63
-> B: Begin snap   E: End snap (rows identified with B or E contain data
   which is absolute i.e. not diffed over the interval)
-> PGA cache hit % - percentage of W/A (WorkArea) data processed only in-memory
-> Auto PGA Target - actual workarea memory target
-> W/A PGA Used    - amount of memory used for all WorkAreas (manual + auto)
-> %PGA W/A Mem    - percentage of PGA memory allocated to WorkAreas
-> %Auto W/A Mem   - percentage of WorkArea memory controlled by Auto Mem Mgmt
-> %Man W/A Mem    - percentage of WorkArea memory under Manual control

PGA Cache Hit % W/A MB Processed Extra W/A MB Read/Written
--------------- ---------------- -------------------------
          100.0            5,101                         0

                                             %PGA  %Auto   %Man
  PGA Aggr  Auto PGA   PGA Mem    W/A PGA    W/A    W/A    W/A   Global Mem
  Target(M) Target(M)  Alloc(M)   Used(M)    Mem    Mem    Mem    Bound(K)
- --------- --------- ---------- ---------- ------ ------ ------ ----------
B       256         0       47.5        0.0     .0     .0     .0     52,428
E       256         0       47.0        0.0     .0     .0     .0     52,428
          -------------------------------------------------------------

PGA Aggr Target Histogram  DB/Inst: XE/xe  Snaps: 53-63
-> Optimal Executions are purely in-memory operations

    Low    High
Optimal Optimal    Total Execs Optimal Execs 1-Pass Execs M-Pass Execs
------- ------- -------------- ------------- ------------ ------------
     2K      4K        179,724       179,724            0            0
    64K    128K              5             5            0            0
   128K    256K              1             1            0            0
   256K    512K              8             8            0            0
   512K   1024K         35,611        35,611            0            0
     1M      2M          7,740         7,740            0            0
     2M      4M             36            36            0            0
     4M      8M             66            66            0            0
     8M     16M            228            99          129            0
    64M    128M              2             0            2            0
   256M    512M              2             0            0            2
          -------------------------------------------------------------

PGA Memory Advisory  DB/Inst: XE/xe  End Snap: 63
-> When using Auto Memory Mgmt, minimally choose a pga_aggregate_target value
   where Estd PGA Overalloc Count is 0

                                   Estd Extra                Estd
  PGA Aggr                           W/A MB      Estd Time    PGA   Estd PGA
    Target   Size         W/A MB  Read/Written  to Process  Cache  Overalloc
  Est (MB)  Factr      Processed    to Disk      Bytes (s)  Hit %      Count
---------- ------ -------------- -------------- ---------- ------ ----------
        32    0.1         84,734          4,258        5.1   95.0        287
        64    0.3         84,734          4,258        5.1   95.0        287
       128    0.5         84,734          4,031        5.1   95.0        287
       192    0.8         84,734          4,031        5.1   95.0        287
       256    1.0         84,734            386        4.9  100.0        191
       307    1.2         84,734            386        4.9  100.0        181
       358    1.4         84,734            386        4.9  100.0        162
       410    1.6         84,734            386        4.9  100.0          2
       461    1.8         84,734            386        4.9  100.0          0
       512    2.0         84,734            386        4.9  100.0          0
       768    3.0         84,734            386        4.9  100.0          0
     1,024    4.0         84,734            386        4.9  100.0          0
     1,536    6.0         84,734            386        4.9  100.0          0
     2,048    8.0         84,734            386        4.9  100.0          0
          -------------------------------------------------------------
Process Memory Summary Stats  DB/Inst: XE/xe  Snaps: 53-63
-> B: Begin snap   E: End snap
-> All rows below contain absolute values (i.e. not diffed over the interval)
-> Max Alloc is Maximum PGA Allocation size at snapshot time
   Hist Max Alloc is the Historical Max Allocation for still-connected processes
-> Num Procs or Allocs:  For Begin/End snapshot lines, it is the number of
   processes. For Category lines, it is the number of allocations
-> ordered by Begin/End snapshot, Alloc (MB) desc

                                                                  Hist   Num
                                          Avg    Std Dev   Max    Max   Procs
             Alloc     Used    Freeabl   Alloc    Alloc   Alloc  Alloc    or
  Category   (MB)      (MB)      (MB)     (MB)    (MB)    (MB)    (MB)  Allocs
- -------- --------- --------- -------- -------- ------- ------- ------ ------
B --------     441.2     359.4     21.9      7.5    11.7      45    110     59
  Other        394.8                         6.7    11.3      44     49     59
  Freeable      22.0        .0               1.3     1.0       5            17
  SQL           17.9      15.1                .7     1.1       4     54     19
  PL/SQL         6.5       4.7                .1      .7       5      7     56
E --------     447.0     357.8     28.8      7.6    11.8      45    110     59
  Other        392.4                         6.7    11.3      44     49     59
  Freeable      28.9        .0               1.5     1.7       7            19
  SQL           19.2      16.4                .7     1.1       4     54     19
  PL/SQL         6.4       4.5                .1      .7       5      7     56
          -------------------------------------------------------------

Top Process Memory (by component)  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     38 ARC0 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      40 ARC1 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      41 ARC2 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      42 ARC3 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      61  ------------    38.8    32.8      1.0       38.8      110.4
         Other            32.2                        32.2       48.7
         PL/SQL            5.1     3.4                 5.1        6.8
         Freeable          1.0      .0                 1.0
         SQL                .5      .0                  .5       53.9
      31 MMON --------    24.5     5.7      1.4       24.5       26.1
         Other            22.6                        22.6       22.6
         Freeable          1.4      .0                 1.4
         PL/SQL             .4      .3                  .4         .4
         SQL                .1      .0                  .1        2.1
      37 TT00 --------    19.5    18.0       .0       19.5       19.5
         Other            19.5                        19.5       19.5
         PL/SQL             .0      .0                  .0         .0
      19 DBW0 --------     9.8     9.1       .0        9.8       20.5
         Other             9.8                         9.8       20.5
         PL/SQL             .0      .0                  .0         .0
      30 TNS V1-V3 ---     8.7     4.8      1.6        8.7        8.7
         Other             6.5                         6.5        6.5
         Freeable          1.8      .0                 1.8
         SQL                .3      .0                  .3        3.3
         PL/SQL             .2      .2                  .2         .2
      25 SMCO --------     7.0     2.2      4.7        7.0        7.0
         Freeable          4.7      .0                 4.7
         Other             2.3                         2.3        2.3
         SQL                .0      .0                  .0         .1
         PL/SQL             .0      .0                  .0         .0
      57 W007 --------     6.8     6.1       .0        6.8        7.7
         SQL               3.7     3.6                 3.7        5.0
         Other             3.1                         3.1        3.1
         PL/SQL             .0      .0                  .0         .0
      54 Q004 --------     6.4     3.9       .0        6.4        7.0
         Other             5.7                         5.7        5.7
         PL/SQL             .6      .6                  .6         .7
         SQL                .0      .0                  .0        2.7
      46 W003 --------     6.2     5.4       .0        6.2       10.8
         Other             3.4                         3.4        6.7
         SQL               2.8     2.5                 2.8        4.1

Top Process Memory (by component)  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
B     46 PL/SQL             .0      .0                  .0         .0
      45 AQPC --------     6.0     4.0      1.9        6.0        6.0
         Other             4.1                         4.1        4.1
         Freeable          1.9      .0                 1.9
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.3
      47 M004 --------     5.7     3.4       .7        5.7        5.7
         Other             4.9                         4.9        4.9
         Freeable           .7      .0                  .7
         PL/SQL             .1      .1                  .1         .2
         SQL                .0      .0                  .0        1.8
      44 W002 --------     5.5     4.6       .0        5.5        9.2
         Other             3.3                         3.3        5.7
         SQL               2.2     1.9                 2.2        3.5
         PL/SQL             .0      .0                  .0         .0
      52 W005 --------     5.4     5.0       .0        5.4        9.3
         Other             2.9                         2.9        5.6
         SQL               2.5     2.3                 2.5        3.7
         PL/SQL             .0      .0                  .0         .0
      28 W001 --------     5.2     4.7       .0        5.2        8.8
         Other             3.3                         3.3        5.8
         SQL               1.9     1.7                 1.9        3.1
         PL/SQL             .0      .0                  .0         .0
       6 GEN0 --------     5.0     2.4      1.4        5.0        5.0
         Other             3.7                         3.7        3.7
         Freeable          1.4      .0                 1.4
         SQL                .0      .0                  .0        1.3
         PL/SQL             .0      .0                  .0         .0
      27 RECO --------     5.0     2.5       .8        5.0        5.0
         Other             4.3                         4.3        4.3
         Freeable           .8      .0                  .8
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.3
E     38 ARC0 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      40 ARC1 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      41 ARC2 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      42 ARC3 --------    44.6    41.1      1.1       44.6       44.6
         Other            43.5                        43.5       43.5
         Freeable          1.1      .0                 1.1
         PL/SQL             .0      .0                  .0         .0
      61  ------------    38.8    31.4      1.0       38.8      110.4
         Other            31.8                        31.8       48.7
         PL/SQL            5.1     3.3                 5.1        6.8
         Freeable          1.0      .0                 1.0

Top Process Memory (by component)  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     61 SQL                .9      .6                  .9       53.9
      31 MMON --------    24.5     5.6      1.1       24.5       26.1
         Other            22.9                        22.9       22.9
         Freeable          1.1      .0                 1.1
         PL/SQL             .4      .3                  .4         .4
         SQL                .1      .0                  .1        2.1
      37 TT00 --------    19.5    18.0       .0       19.5       19.5
         Other            19.5                        19.5       19.5
         PL/SQL             .0      .0                  .0         .0
      19 DBW0 --------    16.5     9.1      6.9       16.5       20.5
         Other             9.5                         9.5       13.6
         Freeable          6.9      .0                 6.9
         PL/SQL             .0      .0                  .0         .0
      59 TNS V1-V3 ---     8.2     4.9      1.9        8.2        8.2
         Other             5.6                         5.6        5.6
         Freeable          2.1      .0                 2.1
         SQL                .3      .1                  .3        3.3
         PL/SQL             .2      .2                  .2         .2
      52 W005 --------     7.1     5.5       .0        7.1        9.3
         Other             4.3                         4.3        5.4
         SQL               2.8     2.6                 2.8        3.9
         PL/SQL             .0      .0                  .0         .0
      25 SMCO --------     7.0     2.2      4.7        7.0        7.0
         Freeable          4.7      .0                 4.7
         Other             2.3                         2.3        2.3
         SQL                .0      .0                  .0         .1
         PL/SQL             .0      .0                  .0         .0
      57 W007 --------     6.8     6.3       .0        6.8        9.3
         SQL               3.7     3.5                 3.7        5.1
         Other             3.1                         3.1        4.3
         PL/SQL             .0      .0                  .0         .0
      54 Q004 --------     6.4     3.9       .0        6.4        7.0
         Other             5.7                         5.7        5.7
         PL/SQL             .6      .6                  .6         .7
         SQL                .0      .0                  .0        2.7
      46 W003 --------     6.2     5.4       .0        6.2       10.8
         Other             3.4                         3.4        6.7
         SQL               2.8     2.5                 2.8        4.1
         PL/SQL             .0      .0                  .0         .0
      45 AQPC --------     6.1     4.1      1.9        6.1        6.1
         Other             4.2                         4.2        4.2
         Freeable          1.9      .0                 1.9
         PL/SQL             .0      .0                  .0         .0
         SQL                .0      .0                  .0        1.3
      28 W001 --------     6.1     5.0       .0        6.1       10.0
         Other             3.9                         3.9        6.7
         SQL               2.2     1.9                 2.2        3.3
         PL/SQL             .0      .0                  .0         .0
      44 W002 --------     5.5     4.7       .0        5.5        9.2
         Other             3.3                         3.3        5.6
         SQL               2.2     1.9                 2.2        3.5
         PL/SQL             .0      .0                  .0         .0
      48 W004 --------     5.5     4.6       .0        5.5        9.2

Top Process Memory (by component)  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by Begin/End snapshot, Alloc (MB) desc

                        Alloc   Used   Freeabl     Max      Hist Max
     PId Category       (MB)    (MB)     (MB)   Alloc (MB) Alloc (MB)
- ------ ------------- ------- ------- -------- ---------- ----------
E     48 Other             3.6                         3.6        6.3
         SQL               1.9     1.6                 1.9        3.0
         PL/SQL             .0      .0                  .0         .0
       6 GEN0 --------     5.0     2.4      1.4        5.0        5.0
         Other             3.7                         3.7        3.7
         Freeable          1.4      .0                 1.4
         SQL                .0      .0                  .0        1.3
         PL/SQL             .0      .0                  .0         .0
      27 RECO --------     5.0     2.6       .7        5.0        5.0
         Other             4.3                         4.3        4.3
         Freeable           .7      .0                  .7
         SQL                .1      .0                  .1        1.3
         PL/SQL             .0      .0                  .0         .0
          -------------------------------------------------------------
Enqueue activity  DB/Inst: XE/xe  Snaps: 53-63
-> only enqueues with waits are shown
-> Enqueue stats gathered prior to 10g should not be compared with 10g data
-> ordered by Wait Time desc, Waits desc

Enqueue Type (Request Reason)
------------------------------------------------------------------------------
    Requests    Succ Gets Failed Gets       Waits Wt Time (s)  Av Wt Time(ms)
------------ ------------ ----------- ----------- ------------ --------------
KO-Multiple Object Checkpoint (fast object checkpoint)
       1,220        1,220           0         122           16         128.07
RO-Multiple Object Reuse (fast object reuse)
       1,640        1,640           0         144            5          33.53
CR-Reuse Block Range (block range reuse ckpt)
       2,050        2,050           0         195            2           9.46
TX-Transaction (row lock contention)
           1            1           0           1            0          66.00
TX-Transaction
     514,408      514,409           0           1            0          61.00
CF-Controlfile Transaction
      12,139       12,139           0           2            0          24.00
SQ-Sequence Cache
          19           19           0           3            0          12.67
          -------------------------------------------------------------

Undo Segment Summary  DB/Inst: XE/xe  Snaps: 53-63
-> Min/Max TR (mins) - Min and Max Tuned Retention (minutes)
-> STO - Snapshot Too Old count,  OOS - Out Of Space count
-> Undo segment block stats:
   uS - unexpired Stolen,   uR - unexpired Released,   uU - unexpired reUsed
   eS - expired   Stolen,   eR - expired   Released,   eU - expired   reUsed

Undo   Num Undo       Number of  Max Qry     Max Tx Min/Max   STO/  uS/uR/uU/
 TS# Blocks (K)    Transactions  Len (s)      Concy TR (mins) OOS   eS/eR/eU
---- ---------- --------------- -------- ---------- --------- ----- -----------
   7      150.9         513,261       75         12 3221/3420 0/0   0/0/0/0/0/0
                                                    .2
          -------------------------------------------------------------


Undo Segment Stats  DB/Inst: XE/xe  Snaps: 53-63
-> Most recent 35 Undostat rows, ordered by End Time desc

                Num Undo    Number of Max Qry  Max Tx Tun Ret STO/  uS/uR/uU/
End Time          Blocks Transactions Len (s)   Concy  (mins) OOS   eS/eR/eU
------------ ----------- ------------ ------- ------- ------- ----- -----------
04-May 14:28       6,811       26,009      75       5   3,420 0/0   0/0/0/0/0/0
04-May 14:18      16,643       60,978      75       5   3,410 0/0   0/0/0/0/0/0
04-May 14:08      10,918       45,561      75       4   3,400 0/0   0/0/0/0/0/0
04-May 13:58       8,007       40,076      75       4   3,390 0/0   0/0/0/0/0/0
04-May 13:48       8,041       38,159      75       4   3,380 0/0   0/0/0/0/0/0
04-May 13:38       7,224       32,405      75       4   3,370 0/0   0/0/0/0/0/0
04-May 13:28       8,625       42,170      75       5   3,361 0/0   0/0/0/0/0/0
04-May 13:18      12,502       56,478      75       4   3,351 0/0   0/0/0/0/0/0
04-May 13:08      14,966       58,977      75       5   3,341 0/0   0/0/0/0/0/0
04-May 12:58      47,874       73,696      75       5   3,331 0/0   0/0/0/0/0/0
04-May 12:48           5           86      75       2   3,321 0/0   0/0/0/0/0/0
04-May 12:38           2           36      75       2   3,311 0/0   0/0/0/0/0/0
04-May 12:28           3            5      75       2   3,301 0/0   0/0/0/0/0/0
04-May 12:18          20          184      75       3   3,291 0/0   0/0/0/0/0/0
04-May 12:08          37          442      75       4   3,281 0/0   0/0/0/0/0/0
04-May 11:58       2,816       14,197      75       5   3,271 0/0   0/0/0/0/0/0
04-May 11:48          14          161      75       3   3,261 0/0   0/0/0/0/0/0
04-May 11:38          10          294      75       2   3,251 0/0   0/0/0/0/0/0
04-May 11:28           0            0      75       1   3,241 0/0   0/0/0/0/0/0
04-May 11:18       4,520       16,703      75      12   3,231 0/0   0/0/0/0/0/0
04-May 11:08       1,896        6,644      75      12   3,221 0/0   0/0/0/0/0/0
          -------------------------------------------------------------
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
AQ Background: interrupt              2    0.0             0          660    0.0
AQ Coord jobx_kwsbgsgn l          1,261    0.0             0            0
AQ Message drive state o              2    0.0             0            0
AQ Sharded master pool l          1,051    0.0             0            0
AQ Slave freSlvL_kwsbgsg            420    0.0             0            0
AQ deq hash table latch               2    0.0             0            0
AQ process state object             420    0.0             0            0
ASM connection state lat              4    0.0             0            0
ASM db client latch               9,373    0.0             0            0
ASM map operation hash t              2    0.0             0            0
ASM network background l              4    0.0             0            0
ASM network state latch             203    0.0             0            0
ASM remote client latch             203    0.0             0            0
AWR Alerted Metric Eleme         86,368    0.0             0            0
CDB Service Hash Table L             10    0.0             0            0
Change Notification Hash             66    0.0             0            0
Column stats entry latch              2    0.0             0            0
Consistent RBA                  480,904    0.0    0.0      0            0
DML lock allocation             180,516    0.0    0.0      0            0
Event Group Locks                   562    0.0             0            0
FAL Queue                           712    0.0             0            0
FIB s.o chain latch                  50    0.0             0            0
FOB consolidated s.o lis             50    0.0             0            0
File State Object Pool P              2    0.0             0            0
GCS logfile block                     2    0.0             0            0
GCS logfile write queue               2    0.0             0            0
Hang Manager wait event             820    0.0             0            0
I/O Staticstics latch                 2    0.0             0            0
ILM Stats Stripe Latch                2    0.0             0            0
ILM Stats main anchor la        130,686    0.0             0            0
ILM access tracking exte              2    0.0             0            0
ILM activity tracking la              2    0.0             0            0
IM Global dictionary lat              2    0.0             0            0
IM Global dictionary que              2    0.0             0            0
IM Global dictionary rw               2    0.0             0            0
IM area sb latch                      2    0.0             0            0
IM area scb latch                     2    0.0             0            0
IM emb latch                          2    0.0             0            0
IM seg hdr latch                      2    0.0             0            0
IMFS defer write list                 2    0.0             0            0
IMXT hash table latch                 2    0.0             0            0
IPC stats buffer allocat              2    0.0             0            0
In memory undo latch            189,799    0.0    0.6      0       20,144    0.0
JS Sh mem access                      2    0.0             0            0
JS queue access latch                 2    0.0             0            0
JS slv state obj latch                2    0.0             0            0
KCNIBR - invalid block r              2    0.0             0            0
KDCStatHash latch                     2    0.0             0            0
KDFI Buffer Latch                     2    0.0             0            0
KDFI Hash Bucket Latch                2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
KDFI Hash Elem Latch                  2    0.0             0            0
KDMADO action list latch              2    0.0             0            0
KDMADO bll latch                      2    0.0             0            0
KDMADO latch                          2    0.0             0            0
KFC FX Hash Latch                     2    0.0             0            0
KFC Hash Latch                        2    0.0             0            0
KFCL LE Freelist                      2    0.0             0            0
KFIAS client latch                    2    0.0             0            0
KFIAS cluster latch                   2    0.0             0            0
KFIAS endpoint latch                  2    0.0             0            0
KFIAS node latch                      2    0.0             0            0
KFIAS process latch                   2    0.0             0            0
KFIAS queue latch                     2    0.0             0            0
KGNFS-NFS:SHM structure               7    0.0             0            0
KGNFS-NFS:SVR LIST                    2    0.0             0            0
KJC message pool free li              2    0.0             0            0
KJC message pool pending              2    0.0             0            0
KJCT flow control latch               2    0.0             0            0
KMG MMAN ready and start          4,209    0.0             0            0
KSFS OFS ctx level paren              2    0.0             0            0
KSFS OFS req layer paren              2    0.0             0            0
KSFS OFS sess layer pare              2    0.0             0            0
KSFS Receive and Send Qu              2    0.0             0            0
KSFS id table parent lat              2    0.0             0            0
KSFS ksfs_node latch                  2    0.0             0            0
KSFSD name cache parent               2    0.0             0            0
KSGL LS Segment latch                 2    0.0             0            0
KSGL SGA anchor latch                 2    0.0             0            0
KSIPC SGA allocation par            205    0.0             0            0
KSIPCGSN Hash Table latc              2    0.0             0            0
KSIPCGSN Namespace latch              2    0.0             0            0
KSK PDB IO STAT                  16,814    0.0             0            0
KSRMA SGA anchor latch                2    0.0             0            0
KSRMF SGA anchor latch                2    0.0             0            0
KSXR hang analysis phase              2    0.0             0            0
KSXR hang analysis phase              2    0.0             0            0
KTF sga latch                        66    0.0             0        3,882    0.0
KTILM latch                           2    0.0             0            0
KTU in-memory txn table               2    0.0             0            0
KTURMA ODPSCN latch                   2    0.0             0            0
KTURMA SGA allocation pa              2    0.0             0            0
KWQMN job cache list lat            916    0.0             0            0
KWQP Prop Status                      2    0.0             0            0
Latch for NonceHistory                2    0.0             0            0
Locator state objects po              2    0.0             0            0
Lsod array latch                      2    0.0             0            0
MGA asr alloc latch                 210    0.0             0            0
MGA heap latch                        2    0.0             0            0
MGA shared context latch              2    0.0             0            0
MGA shared context root             210    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
MMON per PDB bit map lat             21    0.0             0            0
MQL Tracking Latch                    0                    0          462    0.0
Memory Management Latch               0                    0        4,209    0.0
Memory Queue                          2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Message Sub              2    0.0             0            0
Memory Queue Subscriber               2    0.0             0            0
Message cache latch                   2    0.0             0            0
MinActiveScn Latch                  840    0.0             0            0
Mutex                                 2    0.0             0            0
Mutex Stats                           2    0.0             0            0
Nologging Standby SCN Ti          3,850    0.0             0            0
OS process                        6,668    0.0             0            0
OS process allocation            26,619    0.0             0            0
OS process: request allo            561    0.0             0            0
PDB Hash Table Latch             13,346    0.0             0            0
PDB LRU structure                     2    0.0             0            0
PL/SQL warning settings             283    0.0             0            0
PX hash array latch                   2    0.0             0            0
Parent latch for depende              2    0.0             0            0
Parent latch for query h              2    0.0             0            0
Parent latch for segment              2    0.0             0            0
QMT                                   2    0.0             0            0
RTT parent context                   20    0.0             0            0
Real-time descriptor lat          1,470    0.0             0            0
Report Request stats lat            840    0.0             0            0
Request holder compeltio            536    0.0             0            0
Result Cache: RC Latch            2,904    0.0             0            0
Result Cache: SO Latch                2    0.0             0            0
Retry Ht elm latch                    2    0.0             0            0
Retry bkt latch                       2    0.0             0            0
SGA IO buffer pool latch         28,124    0.0             0       28,322    0.0
SGA Logging Bkt Latch                 2    0.0             0            0
SGA Logging Log Latch            17,006    0.0             0            0
SGA blob parent                       2    0.0             0            0
SGA bucket locks                      2    0.0             0            0
SGA heap locks                        2    0.0             0            0
SGA pool locks                        2    0.0             0            0
SQL memory manager latch              1    0.0             0        4,203    0.0
SQL memory manager worka        671,161    0.0    0.0      0            0
SR Stats Stripe Latch                 2    0.0             0            0
Sched IM Job latch                  205    0.0             0            0
Sched InMem Job Cache                 2    0.0             0            0
Shared B-Tree                       456    0.0             0            0
Streams Generic                       2    0.0             0            0
Subscriber Ht elm latch               2    0.0             0            0
Testing                               2    0.0             0            0
Token Manager                         2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
Txn Ht elm latch                      2    0.0             0            0
Txn bkt latch                         2    0.0             0            0
WCR: sync                             2    0.0             0            0
Write State Object Pool               2    0.0             0            0
XDB NFS Security Latch                2    0.0             0            0
XDB unused session pool               2    0.0             0            0
XDB used session pool                 2    0.0             0            0
active checkpoint queue          81,042    0.0             0            0
active service list              16,721    0.0    0.0      0        4,824    0.0
alert log latch                      40    0.0             0            0
archive destination               1,100    0.0             0            0
archive process                     927    0.2    0.0      0            0
begin backup scn array            6,496    0.0             0            0
buffer pool                           2    0.0             0            0
business card                         2    0.0             0            0
cache buffer handles             23,959    0.0             0            0
cache buffers chains        110,536,512    0.0    0.1      0   12,254,420    0.0
cache buffers lru chain       1,965,888    0.0    0.0      0    9,578,891    0.5
cache table scan latch           84,565    0.0    0.0      0       84,566    0.0
call allocation                  10,625    0.0             0            0
change notification clie              2    0.0             0            0
channel handle pool latc          1,147    0.0             0            0
channel operations paren          5,214    0.0             0            0
checkpoint queue latch        4,114,699    0.0    0.0      0    1,885,521    0.0
client/application info         289,026    0.1    0.0      0            0
compile environment latc            271    0.0             0            0
corrupted undo seg latch            831    0.0             0            0
cp handoff latch                      2    0.0             0            0
cp pool latch                         2    0.0             0            0
cp server hash latch                  2    0.0             0            0
cp sga latch                        203    0.0             0            0
cp srv type state latch          12,629    0.0             0            0
cp srv type wait latch                2    0.0             0            0
cr slave free list                    2    0.0             0            0
cvmap freelist lock                   2    0.0             0            0
deferred cleanup latch              203    0.0             0            0
dispatcher info                     196    0.0             0            0
dml lock allocation                 479    0.0             0            0
done queue latch                      2    0.0             0            0
dtp latch                           548    0.2    0.0      0            0
dummy allocation                    563    0.0             0            0
eighth spare latch - X p              2    0.0             0            0
eleventh spare latch - c              2    0.0             0            0
enqueue freelist latch                3   33.3    0.0      0       94,548    0.0
enqueue hash chains           1,377,863    0.0    0.0      0            9    0.0
enqueues                            448    0.0             0            0
fifteenth spare latch -               2    0.0             0            0
file cache latch                  7,936    0.0             0            0
first Audit Vault latch              10    0.0             0            0
flash file access latch               2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
flashback copy                        2    0.0             0            0
fourteenth spare latch -              2    0.0             0            0
fourth Audit Vault latch              2    0.0             0            0
gc element                            2    0.0             0            0
gcs commit scn state                  2    0.0             0            0
gcs nodemap pool                      2    0.0             0            0
gcs opaque info freelist              2    0.0             0            0
gcs partitioned table ha              2    0.0             0            0
gcs pcm hashed value buc              2    0.0             0            0
gcs resource freelist                 2    0.0             0            0
gcs resource hash                     2    0.0             0            0
gcs resource scan list                2    0.0             0            0
gcs resource timerq list              2    0.0             0            0
gcs shadows freelist                  2    0.0             0            0
ges cached resource list              2    0.0             0            0
ges domain table                      2    0.0             0            0
ges enqueue table freeli              2    0.0             0            0
ges group table                       2    0.0             0            0
ges process hash list                 2    0.0             0            0
ges process parent latch              2    0.0             0            0
ges remote lock freelist              2    0.0             0            0
ges resource hash list                2    0.0             0            0
ges resource scan list                2    0.0             0            0
ges resource table freel              2    0.0             0            0
ges timeout list                      2    0.0             0            0
ges value block free lis              2    0.0             0            0
global KZLD latch for au             20    0.0             0            0
global KZLG latch for me              1    0.0             0            0
global tx hash mapping                2    0.0             0            0
granule from data transf              2    0.0             0            0
gws:Sharding global desc            842    0.0             0            0
hash table Sql Plan Find            446    0.0             0          203    0.0
hash table column usage           2,946    0.0             0      752,668    0.0
hash table expression us             71    0.0             0            0
hash table modification             196    0.0             0            0
heartbeat check                       2    0.0             0            0
imc buf hdl lat                       2    0.0             0            0
imc cr clone buf                      2    0.0             0            0
imc hash lat                          2    0.0             0            0
imc sj lat                            2    0.0             0            0
imc srchsp lat                        2    0.0             0            0
imc-txn-wrk-lat                       2    0.0             0            0
in-memory area latch                  2    0.0             0            0
in-memory columnar segme              2    0.0             0            0
in-memory columnar ts ex              2    0.0             0            0
in-memory global pool la              2    0.0             0            0
internal temp table obje             19    0.0             0            0
interrupt manipulation                1    0.0             0            0
intra txn parallel recov              2    0.0             0            0
io pool granule metadata              2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
job workq parent latch                2    0.0             0            0
k2q lock allocation                   2    0.0             0            0
kcb DW scan objtemp hash              2    0.0             0            0
kcbtsemkid latch                     20    0.0             0            0
kcn buffer chains                     2    0.0             0            0
kdlx hb parent latch                  2    0.0             0            0
keiut hash table modific             10    0.0             0            2    0.0
kgb parent                            2    0.0             0            0
kgnfs mount latch                     2    0.0             0            0
kjbr roi instance map                 2    0.0             0            0
kjci objects freelist la             14    0.0             0            0
kjci process context lat             16    0.0             0      109,584    0.0
kjci process list latch               4    0.0             0            0
kjci request sequence la              2    0.0             0            0
kjoedcso state object fr            203    0.0             0            0
kjoeq omni enqueue hash               2    0.0             0            0
kjoer owner hash bucket               2    0.0             0            0
kjsca protect pkey hash               2    0.0             0            0
kjsca protect service ha              2    0.0             0            0
krso process                        761    0.0             0            0
ksevn object root latch           4,209    0.0             0            0
ksfv messages                         2    0.0             0            0
ksi resource reuse count              2    0.0             0            0
ksim group membership ca              2    0.0             0            0
kss move lock                       536    0.0             0            0
ksuosstats global area           23,804    0.0    0.5      0        4,823    0.1
ksv allocation latch              1,271    0.0             0            0
ksv class latch                   7,225    0.5    0.0      0            0
ksv instance latch                  420    0.0             0            0
ksv msg queue latch                 824    0.2    0.0      0          822    0.1
ksz_so allocation latch             561    0.0             0            0
ktfbn latch                       8,779    0.0             0            0
ktm adg jrnls                         2    0.0             0            0
ktm adg lookuptable leve              2    0.0             0            0
ktm adg lookuptable leve              2    0.0             0            0
ktm adg space                         2    0.0             0            0
ktm adg stages                        2    0.0             0            0
ktm adg worklink                      2    0.0             0            0
ktm global data                     357    0.0             0            0
ktm prv jrnls                         2    0.0             0            0
ktmpj HT ls                           2    0.0             0            0
kwqbsn:qsga                         453    0.0             0            0
kwslbmdl: metadata latch          2,522    0.0             0            0
kwslbql: queue latch                  2    0.0             0            0
kwslbutl: uncommitted tx              2    0.0             0            0
kwsptQcachLt: queue cach              2    0.0             0            0
kwsptTrncTsksLt: trunc t              2    0.0             0            0
kwsptjobAdPtLt: AdPt lis            304    0.0             0            0
kwsslLat: skiplist latch              2    0.0             0            0
kxfxscanrate_latch                    2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
lgwr LWN SCN                    483,392    0.1    0.0      0            0
list of block allocation        108,670    0.0             0            0
loader state object free          1,480    0.0             0            0
lob segment dispenser la              2    0.0             0            0
lob segment hash table l            254    0.0             0            0
lob segment query latch               2    0.0             0            0
lock DBA buffer during m              2    0.0             0            0
log write info                        0                    0      480,798    0.0
log write worker phase            1,184    0.0             0            0
logical standby cache                 2    0.0             0            0
logminer context allocat              2    0.0             0            0
logminer local                        2    0.0             0            0
logminer work area                    2    0.0             0            0
longop free list parent           4,216    0.0             0            5    0.0
managed standby                     421    0.0             0            0
message bitmap latch                  2    0.0             0            0
message pool operations           1,490    0.0             0            0
messages                      1,993,518    0.0    0.0      0            0
msg queue latch                       2    0.0             0            0
multiblock read objects         595,626    0.0    0.0      0            0
name-service namespace b              2    0.0             0            0
ncodef allocation latch             203    0.0             0            0
ninth spare latch - X pa              2    0.0             0            0
object queue header free        188,015    0.0             0            0
object queue header oper     20,417,586    0.0    0.0      0            0
object queue memory                   6    0.0             0            0
object stats modificatio          2,353    0.0             0            0
parallel query alloc buf              2    0.0             0        1,572    0.0
parallel query stats                  2    0.0             0            0
parameter table manageme            633    0.0             0            0
pdb enqueue hash chains               2    0.0             0            0
peshm                                 2    0.0             0            0
pesom_free_list                       2    0.0             0            0
pesom_hash_node                       2    0.0             0            0
pkey global statistics                2    0.0             0            0
pmon dead latch                     203    0.0             0            0
post/wait queue                  52,513    0.0    0.0      0       65,665    0.1
process allocation                  838    0.0             0            0
process group creation              561    0.0             0            0
process pkey statistics               2    0.0             0            0
process queue                         2    0.0             0            0
process queue reference               2    0.0             0            0
qmn task queue latch              1,837    0.0             0            0
quarantine object                   209    0.0             0            0
query server freelists                2    0.0             0            0
query server process              8,937    0.0             0            0
queued dump request                  42    0.0             0            0
queuing load statistics               2    0.0             0            0
recovery domain hash buc              2    0.0             0            0
redo allocation               8,990,475    0.1    0.0      0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
redo copy                             2    0.0             0    7,981,396    0.1
redo gen encryption key              20    0.0             0            0
redo transport task                 950    0.0             0            0
redo writing                  1,530,432    0.0    0.1      0            0
remote tool request latc            281    0.0             0            0
resmgr group change latc          1,851    0.0             0            0
resmgr:active threads            11,544    0.0             0      123,961    0.0
resmgr:actses change gro          1,258    0.0             0            0
resmgr:actses change sta            519    0.0             0            0
resmgr:free threads list          2,285    0.0    0.0      0            0
resmgr:plan CPU method                2    0.0             0            0
resmgr:plan change alloc              2    0.0             0            0
resmgr:plan change latch              2    0.0             0            0
resmgr:resource group CP          6,729    0.1    0.0      0            0
resmgr:schema config              9,357    0.0    0.0      0          211    0.0
resmgr:session queuing                2    0.0             0            0
row cache objects                     2    0.0             0            0
rules engine aggregate s              3    0.0             0            0
rules engine rule set st            106    0.0             0            0
second Audit Vault latch              2    0.0             0            0
sequence cache                  101,051    0.1    0.0      0            0
service drain list               12,615    0.0             0            0
session allocation               29,713    0.0    0.0      0       29,673    0.1
session idle bit                260,253    0.0    0.0      0            0
session queue latch                   2    0.0             0            0
session state list latch            645    0.2    0.0      0            0
session statistics                  563    0.2    0.0      0            0
session switching                   486    0.2    0.0      0            0
session timer                     4,209    0.0             0            0
seventh spare latch - X               2    0.0             0            0
sga hash table parent la              2    0.0             0            0
shard latch                           2    0.0             0            0
shared pool                     595,515    0.0    0.1      0            0
shared pool sim alloc                 2    0.0             0            0
shared pool simulator            20,549    0.0             0            0
shared server configurat          4,225    0.0             0            0
sim partition latch                   2    0.0             0            0
simulator hash latch          4,883,308    0.0             0            0
simulator lru latch           1,906,096    0.0    0.0      0    2,766,908    0.1
sixth spare latch - X pa              2    0.0             0            0
sort extent pool                  3,713    0.0             0            0
space background task la         22,062    7.9    0.1      0        8,574    0.0
subscriber Ht bkt                     2    0.0             0            0
tablespace key chain                  2    0.0             0            0
temporary table state ob              6    0.0             0            0
tenth spare latch - X pa              2    0.0             0            0
test excl. parent l0                  2    0.0             0            0
test excl. parent2 l0                 2    0.0             0            0
test excl. parent2 lmid               2    0.0             0            0
test mixed exclusive                  2    0.0             0            0
Latch Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Get Requests", "Pct Get Miss" and "Avg Slps/Miss" are statistics for
  willing-to-wait latch get requests
->"NoWait Requests", "Pct NoWait Miss" are for no-wait latch get requests
->"Pct Misses" for both should be very close to 0.0

                                           Pct    Avg   Wait                 Pct
                              Get          Get   Slps   Time       NoWait NoWait
Latch                       Requests      Miss  /Miss    (s)     Requests   Miss
------------------------ -------------- ------ ------ ------ ------------ ------
test mode exclusive                   2    0.0             0            0
test open exclusive                   2    0.0             0            0
test pdb exclusive                    2    0.0             0            0
test shared parent2 lmid              2    0.0             0            0
thirteenth spare latch -              2    0.0             0            0
threshold alerts latch              511    0.0             0            0
trace latch                           5    0.0             0            0
transaction allocation            1,306    0.0             0            0
twelfth spare latch - ch              2    0.0             0            0
twenty-fifth spare latch              2    0.0             0            0
twenty-first spare latch              2    0.0             0            0
twenty-fourth spare latc              2    0.0             0            0
twenty-second spare latc              2    0.0             0            0
twenty-third spare latch              2    0.0             0            0
undo global data              1,789,284    0.0    0.0      0           10    0.0
virtual circuit buffers               2    0.0             0            0
virtual circuit holder                2    0.0             0            0
virtual circuit queues                2    0.0             0            0
          -------------------------------------------------------------
Latch Sleep breakdown  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by misses desc

                                       Get                                 Spin
Latch Name                        Requests       Misses      Sleeps        Gets
-------------------------- --------------- ------------ ----------- -----------
redo allocation                  8,990,475        7,956          98       7,858
object queue header operat      20,417,586        2,253          15       2,238
space background task latc          22,062        1,752         210       1,543
cache buffers chains           110,536,512        1,386         124       1,262
client/application info            289,026          382          13         369
cache buffers lru chain          1,965,888          292           2         290
shared pool                        595,515          234          16         224
messages                         1,993,518          184           3         181
multiblock read objects            595,626          142           2         140
enqueue hash chains              1,377,863          127           5         122
cache table scan latch              84,565           40           1          39
ksv class latch                      7,225           35           1          34
redo writing                     1,530,432           16           2          14
In memory undo latch               189,799            8           5           3
ksuosstats global area              23,804            2           1           1
          -------------------------------------------------------------
Latch Miss Sources  DB/Inst: XE/xe  Snaps: 53-63
-> only latches with sleeps are shown
-> ordered by name, sleeps desc

                                                     NoWait              Waiter
Latch Name               Where                       Misses     Sleeps   Sleeps
------------------------ -------------------------- ------- ---------- --------
In memory undo latch     ktiFlush: child                  0          3        2
In memory undo latch     kticmt: child                    0          2        0
cache buffers chains     kcbgtcr: slow path excl          0         90       52
cache buffers chains     kcbgtcr: convert latch           0         19        0
cache buffers chains     kcbzwb                           0          9        8
cache buffers chains     kcbzibmlt: multi-block rea       0          6        0
cache buffers chains     kcbgtcr: fast path pin           0          6       69
cache buffers chains     kcbzgb: scan from tail now       0          3        0
cache buffers chains     kcbzibmlt: finish free buf       0          2        4
cache buffers chains     kcbrls: fast pin release         0          2        5
cache buffers chains     kcbgcur: fast path excl          0          1        1
cache buffers chains     kcbgtcr: retry after read        0          1        0
cache buffers chains     kcbget: fast path                0          1        1
cache buffers chains     kcbgtcr: convert latch 4         0          1        0
cache buffers chains     kcbrls: pin release              0          1        2
cache buffers chains     kcbbxsv                          0          1        0
cache buffers chains     kcbrls: fast pin exclusive       0          1        0
cache buffers chains     kcbget: new pin                  0          1        0
cache buffers chains     kcbbic1                          0          1        0
cache buffers lru chain  kcbzgwsnomuma                    0          2        0
cache table scan latch   kcbz_find_table_scan_read_       0          1        0
client/application info  ksuinfos_modact                  0         13       13
ksuosstats global area   ksugetosstat                     0          1        1
ksv class latch          ksvclsl: checkpool               0          1        0
messages                 ksaamb: after wakeup             0          2        0
messages                 ksarcv                           0          1        1
multiblock read objects  kcbzibmlt: normal mbr free       0          1        2
multiblock read objects  kcbzibmlt                        0          1        0
object queue header oper kcbo_switch_q_bg                 0          8        5
object queue header oper kcbo_unlink_q                    0          3        6
object queue header oper kcbo_link_q                      0          3        1
object queue header oper kcbo_switch_mq_bg                0          2        1
object queue header oper kcbo_switch_cq                   0          1        4
redo allocation          kcrfw_redo_gen: redo alloc       0         92        5
redo allocation          kcrfw_redo_write: before w       0          6       55
redo writing             kcrfwcr                          0          1        0
redo writing             kcrfw_post: rba scn pair         0          1        0
space background task la ktsj_grab_task                   0        155      209
space background task la ktsj_detach_task                 0         46        1
unknown latch            No latch                         0          9        0
unknown latch            kghalo                           0          8        5
unknown latch            kghfrunp: alloc: wait            0          5        0
unknown latch            ksqgtl3                          0          5        6
unknown latch            kghupr1                          0          2        9
unknown latch            kghalp                           0          1        1
          -------------------------------------------------------------
Mutex Sleep  DB/Inst: XE/xe  Snaps: 53-63
-> ordered by Wait Time desc

                                                                         Wait
Mutex Type         Location                                 Sleeps     Time (s)
------------------ -------------------------------- -------------- ------------
Cursor Pin         kkslce [KKSCHLPIN2]                         980          3.3
Row Cache          [19] kqrpre                                  40          0.2
Library Cache      kglpin1   4                                  36          0.1
Library Cache      kglpnal1  90                                109          0.0
Library Cache      kglhdgn2 106                                  4          0.0
Library Cache      kglllal1 109                                  3          0.0
Library Cache      kglpndl1  95                                  4          0.0
Row Cache          [10] kqreqd                                   2          0.0
Cursor Pin         kksfbc [KKSCHLFSP2]                           2          0.0
Library Cache      kgllkc1   57                                  3          0.0
Library Cache      kglhdgn1  62                                  3          0.0
Library Cache      kglllal3 111                                  3          0.0
Cursor Pin         kksLockDelete [KKSCHLPIN6]                    1          0.0
Library Cache      kglobpn1  71                                  1          0.0
Library Cache      kglget2   2                                   3          0.0
Library Cache      kgllldl2 112                                  3          0.0
Library Cache      kglobld1  75                                  1          0.0
Cursor Stat        qesdpDPCSetupNextExec [KKSSTALOC              1          0.0
          -------------------------------------------------------------
Dictionary Cache Stats  DB/Inst: XE/xe  Snaps: 53-63
->"Pct Misses"  should be very low (< 2% in most cases)
->"Final Usage" is the number of cache entries being used in End Snapshot

                                   Get    Pct    Scan   Pct      Mod      Final
Cache                         Requests   Miss    Reqs  Miss     Reqs      Usage
------------------------- ------------ ------ ------- ----- -------- ----------
dc_awr_control                     387    1.3       0             84          1
dc_constraints                     594   34.3       0            594         34
dc_global_oids                     178   25.3       0              0          4
dc_histogram_data               58,388   13.8       0              1      1,525
dc_histogram_defs              214,993    8.0       0          1,316      1,720
dc_object_grants                   131   10.7       0              0          2
dc_objects                      83,217    5.8       0          1,196      1,216
dc_profiles                         20    5.0       0              0          0
dc_props                         9,896    0.1       0              0          4
dc_rollback_segments            23,861    0.0       0              6         97
dc_segments                      9,390   21.6       0            981        214
dc_sequences                        16  100.0       0             16          1
dc_statistics_status               350  100.0       0              0          2
dc_table_scns                       99  100.0       0              0          2
dc_tablespace_quotas             1,008    1.4       0              0          1
dc_tablespaces                   5,622    2.0       0              0          6
dc_users                        18,496    1.9      72  36.1        0         25
outstanding_alerts                  33   30.3       0              3          1
          -------------------------------------------------------------


Library Cache Activity  DB/Inst: XE/xe  Snaps: 53-63
->"Pct Misses"  should be very low

                         Get  Pct        Pin        Pct               Invali-
Namespace           Requests  Miss     Requests     Miss     Reloads  dations
--------------- ------------ ------ -------------- ------ ---------- --------
SQL AREA              25,631   20.9        399,452    2.3      1,179      420
TABLE/PROCEDURE       14,107   21.3        335,674    1.9      1,282        0
BODY                  22,350    0.2        139,616    0.1         27        0
TRIGGER                2,973    3.7          2,918    2.0          2        0
INDEX                    644   14.1            649   15.3          0        0
CLUSTER                1,296    2.2          1,340    1.8          1        0
QUEUE                      6    0.0              7   71.4          3        0
RULESET                    2    0.0              3  100.0          3        0
EDITION                   70    8.6            140   22.9          2        0
DBLINK                    56   10.7              0                 0        0
OBJECT ID                204  100.0              0                 0        0
SCHEMA                 3,848    0.4              0                 0        0
SQL AREA STATS         3,052   90.7          3,052   90.7          1        0
SQL AREA BUILD         3,267   89.9              0                 0        0
AUDIT POLICY              32   37.5             32   43.8          0        0
FED APP                   12   25.0             12   25.0          0        0
CMP                    1,773   86.0          1,773   86.5          8        0
          -------------------------------------------------------------
Shared Pool Advisory  DB/Inst: XE/xe  End Snap: 63
-> SP: Shared Pool     Est LC: Estimated Library Cache   Factr: Factor
-> Note there is often a 1:Many correlation between a single logical object
   in the Library Cache, and the physical number of memory objects associated
   with it.  Therefore comparing the number of Lib Cache objects (e.g. in
   v$librarycache), with the number of Lib Cache Memory Objects is invalid

                                        Est LC Est LC  Est LC Est LC
    Shared    SP   Est LC                 Time   Time    Load   Load      Est LC
      Pool  Size     Size       Est LC   Saved  Saved    Time   Time         Mem
  Size (M) Factr      (M)      Mem Obj     (s)  Factr     (s)  Factr    Obj Hits
---------- ----- -------- ------------ ------- ------ ------- ------ -----------
       276   1.0       28        1,499  77,483    1.0     171    1.0   2,182,672
       280   1.0       31        1,674  77,488    1.0     166    1.0   2,183,276
       284   1.0       34        1,847  77,494    1.0     160     .9   2,183,965
       288   1.0       37        2,112  77,499    1.0     155     .9   2,184,437
       292   1.1       40        2,279  77,504    1.0     150     .9   2,185,294
       296   1.1       44        2,338  77,512    1.0     142     .8   2,186,174
       300   1.1       47        2,550  77,522    1.0     132     .8   2,187,102
       304   1.1       51        2,719  77,527    1.0     127     .7   2,187,917
       308   1.1       55        2,982  77,531    1.0     123     .7   2,188,580
       312   1.1       59        3,163  77,536    1.0     118     .7   2,189,132
       332   1.2       78        3,988  77,555    1.0      99     .6   2,191,649
       360   1.3      105        4,699  77,569    1.0      85     .5   2,193,404
       388   1.4      132        5,882  77,581    1.0      73     .4   2,195,018
       416   1.5      158        6,463  77,590    1.0      64     .4   2,196,164
       444   1.6      185        8,231  77,599    1.0      55     .3   2,197,185
       472   1.7      212       10,207  77,606    1.0      48     .3   2,198,089
       500   1.8      240       10,611  77,610    1.0      44     .3   2,198,534
       528   1.9      268       11,015  77,612    1.0      42     .2   2,198,813
       556   2.0      296       11,496  77,614    1.0      40     .2   2,199,065
          -------------------------------------------------------------
SGA Target Advisory  DB/Inst: XE/xe  End Snap: 63

SGA Target SGA Size   Est DB      Est DB   Est Physical
  Size (M)   Factor Time (s) Time Factor          Reads
---------- -------- -------- ----------- --------------
       768       .8   28,076         1.8     13,362,818
     1,024      1.0   15,416         1.0      7,365,681
     1,280      1.3   10,054          .7      2,405,631
     1,536      1.5    9,997          .6      1,984,314
     1,792      1.8    9,997          .6      1,934,964
     2,048      2.0    9,997          .6      1,934,964
          -------------------------------------------------------------
SGA Memory Summary  DB/Inst: XE/xe  Snaps: 53-63

                                                        End Size (Bytes)
SGA regions                      Begin Size (Bytes)       (if different)
------------------------------ -------------------- --------------------
Database Buffers                        759,169,024
Fixed Size                                8,904,184
Redo Buffers                              3,678,208
Variable Size                           301,989,888
                               -------------------- --------------------
sum                                   1,073,741,304
          -------------------------------------------------------------


SGA breakdown difference  DB/Inst: XE/xe  Snaps: 53-63
-> Top 35 rows by size, ordered by Pool, Name (note rows with null values for
   Pool column, or Names showing free memory are always shown)
-> Null value for Begin MB or End MB indicates the size of that Pool/Name was
   insignificant, or zero in that snapshot

Pool   Name                                 Begin MB         End MB  % Diff
------ ------------------------------ -------------- -------------- --------
java p free memory                               4.0            4.0     0.00
large  free memory                               7.5            7.5     0.00
shared KGLDA                                                     .9 ########
shared KGLH0                                     4.6            9.1    96.25
shared KGLHD                                      .9            1.7    83.69
shared KGLS                                      3.9            4.2     8.75
shared KQR X PO                                  1.0            1.9    89.64
shared KQR X SO                                   .8            1.5    86.97
shared SQLA                                      6.4           10.8    70.13
shared alls-ktimcem                              1.0            1.0     0.00
shared free memory                              51.9           34.7   -33.12
shared kcbi io desc slot                          .8             .8     0.00
       buffer_cache                            692.0          692.0     0.00
       fixed_sga                                 8.5            8.5     0.00
       log_buffer                                3.5            3.5     0.00
       shared_io_pool                           32.0           32.0     0.00
          -------------------------------------------------------------
SQL Memory Statistics  DB/Inst: XE/xe  Snaps: 53-63

                                   Begin            End         % Diff
                          -------------- -------------- --------------
   Avg Cursor Size (KB):           40.25          27.97         -43.91
 Cursor to Parent ratio:            1.09           1.22          10.23
          Total Cursors:             342            454          24.67
          Total Parents:             313            373          16.09
          -------------------------------------------------------------
init.ora Parameters  DB/Inst: XE/xe  Snaps: 53-63

                                                                  End value
Parameter Name                Begin value                       (if different)
----------------------------- --------------------------------- --------------
audit_file_dest               /opt/oracle/admin/xe/adump
audit_trail                   DB
commit_logging                                                  IMMEDIATE
commit_wait                                                     WAIT
compatible                    18.0.0
control_files                 /opt/oracle/oradata/XE/control01.
                              ctl, /opt/oracle/oradata/XE/contr
                              ol02.ctl
control_management_pack_acces NONE
cursor_sharing                EXACT                             FORCE
db_32k_cache_size             209715200
db_block_size                 8192
db_keep_cache_size            104857600
db_name                       xe
diagnostic_dest               /opt/oracle
dispatchers                   (PROTOCOL=TCP) (SERVICE=xeXDB)
enable_pluggable_database     TRUE
filesystemio_options          SETALL
job_queue_processes           0
local_listener                LISTENER_XE
log_archive_dest_1            LOCATION=/orabkp/arc/xe
log_archive_format            %t_%s_%r.arc
nls_language                  AMERICAN
nls_territory                 AMERICA
open_cursors                  2000
pga_aggregate_target          268435456
processes                     300
remote_login_passwordfile     EXCLUSIVE
result_cache_max_size         104857600
sga_max_size                  1073741824
sga_target                    1073741824
undo_tablespace               UNDO_TBS
          -------------------------------------------------------------

End of Report ( spreport_antes_alteracoes.txt )

