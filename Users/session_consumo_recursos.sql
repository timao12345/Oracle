SELECT stat.sid, sess.status, sess.machine, sess.username, (SYSDATE-sess.logon_time)*86400 elapsed_time, 
       stat.cpu, stat.memsorts, stat.tablescans, stat.phyreads, stat.logreads, stat.disksorts, stat.blks_changed, 
	   stat.chained_rows, stat.commits, stat.cursors, 
	   round((1-(stat.phyreads/DECODE(stat.logreads,0,NULL,stat.logreads)))*100) buffer_cache_hitrate 
from (SELECT st.sid, SUM(DECODE(name, 'CPU used by this session', value, 0)) cpu, 
                     SUM(DECODE(name, 'sorts (disk)', value, 0)) disksorts, 
					 SUM(DECODE(name, 'sorts (memory)', value, 0)) memsorts, 
					 SUM(DECODE(SUBSTR(name,0,11), 'table scans', value, 0)) tablescans, 
					 SUM(DECODE(name, 'physical reads', value, 0)) phyreads, 
					 SUM(DECODE(name, 'session logical reads', value, 0)) logreads, 
					 SUM(DECODE(name,'db block changes', value, 0)) blks_changed, 
					 SUM(DECODE(name, 'table fetch continued row', value, 0)) chained_rows, 
					 SUM(DECODE(name, 'user commits', value, 0)) commits, 
					 SUM(DECODE(name, 'opened cursors current', value, 0)) cursors 
		FROM V$SESSTAT st, 
		     V$STATNAME sn 
	   WHERE st.statistic# = sn.statistic# 
	   GROUP BY st.sid) stat, 
	 v$session sess 
where stat.sid = sess.sid
   and sess.sid=1008
order by stat.cpu