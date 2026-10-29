How To Identify a Hot Block Within The Database Buffer Cache. (Doc ID 163424.1)



select CHILD#  "cCHILD"     ,      ADDR    "sADDR"     ,      GETS    "sGETS"     ,      MISSES  "sMISSES"     ,      SLEEPS  "sSLEEPS"      from v$latch_children 
     where name = 'cache buffers chains'
     order by 5, 1, 2, 3;

	 Exemplo:
	 
	 
     82538 0000000340F1B668 2019271111  126159217      62722
     14305 000000034675DF70 1292589464  139284248      74924
     39260 0000000344794418 1764601301  140398320      77724
    126290 0000000346E77FB8 3533270489  164624933     101920
     36884 00000003468BE748 1325362666  239018891     115584
      9702 0000000346713358  392924722  225375415     137941
    127982 0000000346E98998 3732165919  433772957     244282
     32472 000000034687D068 1926011181  503438048     365638

	 

	 
	 
column segment_name format a35
     select /*+ RULE */
       e.owner ||'.'|| e.segment_name  segment_name,
       e.extent_id  extent#,
       x.dbablk - e.block_id + 1  block#,
       x.tch,
       l.child#
     from
       sys.v$latch_children  l,
       sys.x$bh  x,
       sys.dba_extents  e
     where
       x.hladdr  = '&ADDR' and
       e.file_id = x.file# and
       x.hladdr = l.addr and
       x.dbablk between e.block_id and e.block_id + e.blocks -1
     order by x.tch desc ;


SEGMENT_NAME                             EXTENT#       BLOCK#          TCH       CHILD#
----------------------------------- ------------ ------------ ------------ ------------
PERSONATA.REC_FOLLOWUP                        11         3773            8        32472
PERSONATA.TLK_CLIENTE                        116          617            2        32472
PERSONATA.PROC_06_I                           42           69            2        32472
PERSONATA.TLK_CLIENTE                        126          738            0        32472


	 
column segment_name format a35
     select /*+ RULE */
       e.owner ||'.'|| e.segment_name  segment_name,
       e.extent_id  extent#,
       x.dbablk - e.block_id + 1  block#,
       x.tch,
       l.child#
     from
       sys.v$latch_children  l,
       sys.x$bh  x,
       sys.dba_extents  e
     where
       x.hladdr  = '&ADDR' and
       e.file_id = x.file# and
       x.hladdr = l.addr and
       x.dbablk between e.block_id and e.block_id + e.blocks -1
     order by x.tch desc ;	 

The following query joins with DBA_OBJECTS to find the objects waiting, the misses, sleeps, etc:

SQL> with bh_lc as
(select /*+ ORDERED */
lc.addr, lc.child#, lc.gets, lc.misses, lc.immediate_gets,
lc.immediate_misses, lc.spin_gets, lc.sleeps,
bh.hladdr, bh.tch tch, bh.file#, bh.dbablk, bh.class,
bh.state, bh.obj
from
x$kslld ld,
v$session_wait sw,
v$latch_children lc,
x$bh bh
where lc.addr =sw.p1raw
and sw.p2= ld.indx
and ld.kslldnam='cache buffers chains'
and lower(sw.event) like '%latch%'
and sw.state='WAITING'
and bh.hladdr=lc.addr
)
select bh_lc.hladdr, bh_lc.tch, o.owner, o.object_name, o.object_type,
bh_lc.child#, bh_lc.gets,
bh_lc.misses, bh_lc.immediate_gets,
bh_lc.immediate_misses, spin_gets, sleeps
from
bh_lc,
dba_objects o
where bh_lc.obj = o.object_id(+)
union
select bh_lc.hladdr, bh_lc.tch, o.owner, o.object_name, o.object_type,
bh_lc.child#, bh_lc.gets, bh_lc.misses, bh_lc.immediate_gets,
bh_lc.immediate_misses, spin_gets, sleeps
from
bh_lc,
dba_objects o
where bh_lc.obj = o.data_object_id(+)
order by 1,2 desc;


The output is something like following:

HLADDR TCH OWNER OBJECT_NAME OBJECT_TYP CHILD# GETS MISSES IMMEDIATE_GETS IMMEDIATE_MISSES SPIN_GETS SLEEPS
---------------- ----- -------------------- ---------------------------------------- ---------- ------- ---------------- ---------------- ---------------- ---------------- ---------------- ----------------
0000000621ED8B00 127 SABXFER PCBDEMPRELEVEMENT TABLE 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 127 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 74 SABXFER V_HIERARCHIEENTREPRISE_B TABLE 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 1 SABXFER SACNTPR_PK INDEX 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 1 SABXFER SAENCR2_1 TABLE 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 1 80750 703326 1649 8007 0 1642 7
0000000621ED8B00 0 80750 703326 1649 8007 0 1642 7	 