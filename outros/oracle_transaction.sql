-- Retorna transações.
select LOCAL_TRAN_ID,
       STATE,
       to_char(FAIL_TIME,'dd-mon-yyyy hh24:mi:ss')  FAIL_TIME,
       to_char(FORCE_TIME,'dd-mon-yyyy hh24:mi:ss') FORCE_TIME,
       to_char(RETRY_TIME,'dd-mon-yyyy hh24:mi:ss') RETRY_TIME,
       OS_USER,
       OS_TERMINAL,
       HOST,
       DB_USER,
       Global_tran_Id
from   dba_2pc_pending
order  by 4;

select state, local_tran_ID, Global_tran_Id from dba_2pc_pending where state = 'prepared';

-- retorna transações travadas com comando pra matar
SELECT  
'EXECUTE DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('||''''||LOCAL_TRAN_ID||''''||');'||chr(13)||''
FROM DBA_2PC_PENDING
ORDER BY 1 ASC;


--Caso  "STATE" for essa opções(collecting,committed,forced) executar o comando abaixo
execute DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('local_tran_id');

-- Caso  "STATE" for essa opções(prepared) executar o comando de rollback ou commit:
rollback force 'LOCAL_TRAN_ID'; --- Exemplo ( rollback force '8.22.1028614')
execute DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('local_tran_id');
--Ou
Commit force 'LOCAL_TRAN_ID';
execute DBMS_TRANSACTION.PURGE_LOST_DB_ENTRY('local_tran_id');

 --- // --
SELECT  
'rollback force '||''''||LOCAL_TRAN_ID||''''||';'||chr(13)||''
FROM DBA_2PC_PENDING
ORDER BY 1 ASC;

-- 



rollback force '10.27.450930';
rollback force ('11.30.728932');
rollback force ('12.3.358395');
rollback force ('15.12.264137');
rollback force ('17.11.252413');
rollback force ('19.33.288922');
rollback force ('20.30.264490');
rollback force ('33.3.132279');
rollback force ('35.15.128008');
rollback force ('35.26.128069');
rollback force ('35.29.128029');
rollback force ('35.31.127762');
rollback force ('37.31.135393');
rollback force ('38.7.125798');
rollback force ('42.27.127474');
rollback force ('47.16.79672');
rollback force ('47.19.79702');
rollback force ('47.24.79714');
rollback force ('48.26.69252');
rollback force ('51.4.134162');
rollback force ('52.15.81679');
rollback force ('55.1.129939');
rollback force ('55.5.129895');
rollback force ('55.7.129976');
rollback force ('58.1.136073');
rollback force ('60.28.106457');
rollback force ('62.10.100292');
rollback force ('64.25.104942');
rollback force ('68.3.109346');
rollback force ('75.11.90925');
rollback force ('77.4.99685');
rollback force ('77.9.99723');
rollback force ('78.23.92217');
rollback force ('78.3.92228');
rollback force ('8.4.365247');

/* Log de erro do CDC um exemplo que contem o 
2026-06-23 14:59:37.409000000000|S|SHAREDSCRAPE|1572|Information||Product has encountered distributed transaction,  
Transaction Id: TransactionId 
entryType: B 
xidUsn: 61 
xidSlot: 0 
xidSqn: 9326944 
rootDba (START_UBABLK): 945815552760 
currDba (UBABLK): 442813713110 
threadId: 1 First operation current position: 682065993328.1.1.27702.452.1.0 Number of reverted records: 0 
Journal Id: 0 
isExempt: true 
Num log records: 1 
Num regular log records: 0 
Num revertible log records: 0 
Global Txn Id: null 
Proxy Txn Id: 
TransactionId entryType: X 
xidUsn: UNKNOWN 
xidSlot: 0 
xidSqn: 9326944 
rootDba (START_UBABLK): 945815552760 
currDba (UBABLK): UNKNOWN 
threadId: 1 Is Partial 
Txn: false 
Transaction type: 0 
In memory: true. 
Estimated # of memory bytes: 948. The presence of this distributed transaction may lead to the restart position not advancing, Product only supports distributed transaction performed through Oracle DTP. 
Please contact support for more information.

*/

/* A partir de um log que contenha os ids da transação, é possível identificar a sessão que está realizando a transação distribuída. Para isso, utilize o seguinte comando:
Precisa dos valores de:
xidUsn: 61 
xidSlot: 0 
xidSqn: 9326944 
*/

select s.sid, s.serial#, t.xidusn, t.xidslot, t.xidsqn, s.username, s.program, s.status 
from v$transaction t join v$session s on s.saddr = t.ses_addr 
where t.xidusn = 61 and t.xidslot = 0 and t.xidsqn = 9326944;


-- Verifica transações pendentes.
select * from dba_2pc_pending;

select local_tran_id, state, global_tran_id from dba_2pc_pending;

select local_tran_id, global_tran_id, state, mixed, host, commit# from dba_2pc_pending;

-- Verifica a nivel global a transação
select * from v$global_transaction;



/*
Campos importantes:

LOCAL_TRAN_ID → usado para resolver a transação
STATE
prepared
collecting
committed
forced commit
forced rollback

Se a transação estiver parada há muito tempo e o sistema coordenador não existir mais, deve ser analisado a possibilidade de resolver manualmente:
obs: Tota transação deve ser analisada por conta de afetar o resultado da transação, caso seja forçada a execução do commit ou rollback.

Forçar commit: commit force 'LOCAL_TRAN_ID';

ou rollback:

rollback force 'LOCAL_TRAN_ID';

Exemplo:

commit force '61.0.9326944';

ou

rollback force '61.0.9326944';

Depois disso, normalmente executam:

exec dbms_transaction.purge_lost_db_entry('61.0.9326944');

Isso limpa a entrada do 2PC.
*/


225306112 currDba (UBABLK): 3422132648457 threadId: 1 First operation current position: 682091837545.1.1.645640.328.1.0 Number of 
reverted records: 0 Journal Id: 0 isExempt: true Num log records: 0 Num regular log records: 0 Num revertible log records: 0 Global Txn Id: null Proxy Txn Id: 
TransactionId entryType:  

xidUsn: 145 
xidSlot: 19 
xidSqn: 4889643 rootDba (START_UBABLK): UNKNOWN currDba (UBABLK): UNKNOWN threadId: UNKNOWN Is Partial Txn: false Transaction type: 0 In memory: true. Estimated # of memory bytes: 0. The presence of this distributed transaction may lead to the restart position not advancing, Product only supports distributed transaction performed through Oracle DTP. Please contact support for more information.
