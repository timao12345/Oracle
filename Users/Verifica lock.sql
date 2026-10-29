SELECT /*+ ORDERED */ W1.SID WAITING_SESSION
, H1.SID HOLDING_SESSION, W.KGLLKTYPE LOCK_OR_PIN
, W.KGLLKHDL ADDRESS
,DECODE(H.KGLLKMOD,0,'None',1,'Null',2,'Share',3,'Exclusive','Unknown') MODE_HELD
,DECODE(W.KGLLKREQ,0,'None',1,'Null',2,'Share',3,'Exclusive','Unknown') 
MODE_REQUESTED FROM DBA_KGLLOCK W, DBA_KGLLOCK H, V$SESSION W1, V$SESSION H1 
WHERE (((H.KGLLKMOD != 0) AND (H.KGLLKMOD != 1) AND ((H.KGLLKREQ = 0) OR (H.KGLLKREQ = 1))) 
AND (((W.KGLLKMOD = 0) OR (W.KGLLKMOD= 1)) AND ((W.KGLLKREQ != 0) AND (W.KGLLKREQ != 1)))) 
AND W.KGLLKTYPE = H.KGLLKTYPE 
AND W.KGLLKHDL = H.KGLLKHDL 
AND W.KGLLKUSE = W1.SADDR 
AND H.KGLLKUSE = H1.SADDR;

Para saber o nome do objeto a partir do TO_ADDRESS, use este SELECT:

SELECT TO_NAME FROM V$OBJECT_DEPENDENCY WHERE TO_ADDRESS = '0700000010F62750';



WAITING_SESSION HOLDING_SESSION LOCK ADDRESS          MODE_HELD                        MODE_REQUESTED
--------------- --------------- ---- ---------------- -------------------------------- --------------------------------
           1870             396 Pin  00000004F64B1C40 Share                            Exclusive
           1490            1870 Lock 00000004F64B1C40 Exclusive                        Exclusive

SQL>

select 'alter system kill session '||''''||sid||','||serial#||''''||' immediate;' from v$session where sid=396;
select 'alter system kill session '||''''||sid||','||serial#||''''||' immediate;' from v$session where sid=1870;