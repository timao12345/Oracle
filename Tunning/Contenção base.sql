----------------------------------------------------------------------------------------
-- EVENTOS DE CONTEN��O BASE
----------------------------------------------------------------------------------------
col event format a40
col p1raw format a30

select sid, event, p1, p2, p3, p1raw 
from v$session_wait 
where sid > 9 and event not like 'SQL%' and event not like 'rdbms%';


select owner, segment_name, segment_type
from dba_extents
where file_id = &p1 AND
      &p2 between block_id AND block_id + blocks - 1;



-- Retorna classe de eventos
Select wait_class, sum(time_waited), sum(time_waited)/sum(total_waits)
Sum_Waits
From v$system_wait_class
Group by wait_class
Order by 3 desc;

-- A partir de uma classe de evento, retorna os eventos que a compoem
Select a.event, a.total_waits, a.time_waited, a.average_wait
From v$system_event a, v$event_name b, v$system_wait_class c
Where a.event_id=b.event_id
And b.wait_class#=c.wait_class#
And c.wait_class = '&Enter_Wait_Class'
order by average_wait desc;