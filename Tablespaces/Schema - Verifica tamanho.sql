select owner, sum(bytes)/1024/1024/1024 schema_size_gig
from dba_segments 
where owner in ('SDIMIO','SDBANCO','FINPAC','FINPAC_CUSTOM')
group by owner;