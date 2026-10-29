select         sum(pins) Executions, sum(pinhits) "Execution Hits",
               ((sum(pinhits) / sum(pins)) * 100) phitrat,
               sum(reloads) Misses,
               ((sum(pins) / (sum(pins) + sum(reloads))) * 100)  hitrat
from        v$librarycache
/

