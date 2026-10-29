select CHILD#  "cCHILD"
,      ADDR    "sADDR"
,      GETS    "sGETS"
,      MISSES  "sMISSES"
,      SLEEPS  "sSLEEPS"
from v$latch_children
where name = 'cache buffers chains'
and SLEEPS>5
order by 5 desc, 1, 2, 3


-- count(1) > 3 very hot block no buffer
select ADDR,  count(1)
 from v$latch_children
where name = 'cache buffers chains'
 and SLEEPS>5
group by ADDR
order by 2


-- outra maneira :

:: para converter para hex pode-se utilizar - select upper(replace( to_char(6859310904,'xxxxxxxxxxxxxxxx'),' ', '0'))  from dual  - já ajustado na query abaixo.

select sid, serial#, sql_id,event, p1||'-'||p1text par1, p2||'-'||p2text par2, p3||'-'||p3text par3, 
       upper(replace( to_char(p1,'xxxxxxxxxxxxxxx'),' ', '0')) hex_addr
 from v$session where event like '%latch%' ;
  
select addr, latch#, child#, level#, gets
from v$latch_children where addr='0000000197C3A9C0'

select hladdr,  file#, dbablk, decode(state,1,'cur ',3,'CR',state) ST, tch
 from x$bh where hladdr in
  (select addr from  (select addr from v$latch_children  where addr='0000000197C3A9C0'
 order by sleeps, misses,immediate_misses desc )where rownum <2)
 
 utilizar o file# e dbablk para procurar por hotblock
 
