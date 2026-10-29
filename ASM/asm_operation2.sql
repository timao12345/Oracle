-- Check Rebalance.
set lines 900

SELECT 
	GROUP_NUMBER,
	OPERATION,
	STATE,/*WAIT - No operations running for the group
			RUN - Operation running for the group
			REAP - Operation is being run down
			HALT - Operation halted by admin
			ERRS - Operation halted by errors */
	POWER,
	SOFAR,
	EST_WORK,
	EST_RATE,
	EST_MINUTES,
	ERROR_CODE,
	ROUND((SOFAR*100)/EST_WORK)||'%' "PCT%"
FROM V$ASM_OPERATION;