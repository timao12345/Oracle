select 100-round(a.bytes/b.sm*100,2)  percentual_usado
from
(select bytes from v$sgastat where name='free memory' AND pool='shared pool') a,
(select sum(bytes) sm from v$sgastat where pool = 'shared pool') b

--verificar tamanho atual da shared pool
select pool,name, (bytes)/1024/1024 as MB from v$sgastat where name= 'free memory' and pool ='shared pool';