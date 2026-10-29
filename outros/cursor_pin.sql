select p2raw
from gv$session
where event = 'cursor: pin S wait on X'
/
