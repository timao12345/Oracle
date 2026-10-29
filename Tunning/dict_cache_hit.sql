select 	sum(gets) "Gets", sum(getmisses) "Misses",
       	(1 - (sum(getmisses) / (sum(gets) +     	
		sum(getmisses))))*100 "HitRate"
from  	v$rowcache
/
