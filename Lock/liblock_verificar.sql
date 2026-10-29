select
 distinct
   ses.ksusenum sid, ses.ksuseser serial#, ses.ksuudlna username,ses.ksuseunm machine,
   ob.kglnaown obj_owner, ob.kglnaobj obj_name
   ,pn.kglpncnt pin_cnt, pn.kglpnmod pin_mode, pn.kglpnreq pin_req
   , w.state, w.event, w.wait_Time, w.seconds_in_Wait
 from
  x$kglpn pn,  x$kglob ob,x$ksuse ses
   , v$session_wait w
where pn.kglpnhdl in
(select kglpnhdl from x$kglpn where kglpnreq >0 )
and ob.kglhdadr = pn.kglpnhdl
and pn.kglpnuse = ses.addr
and w.sid = ses.indx
order by seconds_in_wait desc