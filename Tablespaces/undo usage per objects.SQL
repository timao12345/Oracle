select  s.username,  s.sid, s.osuser,     rn.name,     rs.extents
               ,rs.rssize /1024/1024 "Size (Mb)"
               ,rs.writes /1024/1024 "Mbytes used"
               ,rs.status,  t.used_ublk,  t.used_urec
               ,do.object_name
        from    v$transaction   t
               ,v$session       s
               ,v$rollname      rn
               ,v$rollstat      rs
               ,v$locked_object lo
               ,dba_objects     do
        where  t.addr        = s.taddr
        and    t.xidusn      = rn.usn
        and    rn.usn        = rs.usn
        and    t.xidusn      = lo.xidusn(+)
        and    do.object_id  = lo.object_id
        and s.sid=4356;

--
SELECT * FROM (SELECT
   S.SID                SID
 , S.SERIAL#            SERIAL_ID
 , S.INST_ID
 , LPAD(S.STATUS,9)     SES_STAT
 , LPAD(S.USERNAME,12)  ORA_USER
 , LPAD(S.OSUSER,9)     OS_USER
 , LPAD(P.SPID,7)       OS_PID
 , S.PROGRAM            SES_PRO
 , S.MACHINE
 , S.SECONDS_IN_WAIT
 , S.SQL_ID                             SQL_ID
 ,ROUND(T.USED_UBLK*8192/1024/1024) UNDO_USG_MB
FROM GV$SESSION S
LEFT JOIN GV$TRANSACTION T
ON S.SADDR = T.SES_ADDR AND S.INST_ID=T.INST_ID
LEFT JOIN GV$PROCESS P
ON S.PADDR = P.ADDR AND S.INST_ID=P.INST_ID
WHERE S.TYPE<>'BACKGROUND' and s.sid= 4356
ORDER BY T.USED_UBLK DESC) WHERE ROWNUM <=20;