select 'kill -9 ' || b.SPID
 from v$session a, v$process b
where a.PADDR = b.ADDR
  and a.type='USER'
  and a.USERNAME is not null
  