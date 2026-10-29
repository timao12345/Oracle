SELECT  P1 "file#", p2 "block", p3 "class#"
FROM	v$session_wait
where	event = 'read by other session';

SELECT 	relative_fno, owner, segment_name, segment_type
from 	dba_extents
where	file_id = &file_id
and		&block between block_id and block_id + blocks -1;


