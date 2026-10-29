select used_urec from v$transaction where addr =
(select taddr from v$session where sid=&sid);
undef sid;