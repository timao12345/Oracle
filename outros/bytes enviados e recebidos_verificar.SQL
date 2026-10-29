select sess.sid, sess.OSUSER, sent.name, sent.mbytes mbytes_env,
                               rec.name,  rec.mbytes mbytes_rec
 from
 v$session sess,
 (select a.*, a.value / 1024 /1024 mbytes, b.NAME
    from sys.V_$SESSTAT a,
         sys.V_$STATNAME b
   where a.STATISTIC# = b.STATISTIC#
     and b.NAME like 'bytes sent via SQL*Net to client'
   order by value desc) sent,
 (select a.*, a.value / 1024 /1024 mbytes, b.NAME
    from sys.V_$SESSTAT a,
         sys.V_$STATNAME b
   where a.STATISTIC# = b.STATISTIC#
     and b.NAME like 'bytes received via SQL*Net from client'
   order by value desc) rec
where sess.sid = rec.sid
  and sess.sid = sent.sid
  and sess.USER# > 0
order by sent.mbytes desc



