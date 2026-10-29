-- Gera uma Lista de Todos os Objetos Bloqueados por alguma Sessao no Banco de Dados

set lines 300
set pages 80
col username for a30
col owner for a20
col OBJETO_TRAVADO for a30
SELECT  	c.inst_id "INST_TRAVADA", 
			c.sid "SID_TRAVADO", 
			c.blocking_instance "INST_TRAVANDO", 
			c.blocking_session "SID_TRAVANDO", 
			b.OBJECT_TYPE, 
			b.OWNER "OBJECT_OWNER", 
			b.OBJECT_NAME "OBJETO_TRAVADO",  
			DECODE(A.locked_mode,
				1, 'No Lock',
				2, 'Row Share',
				3, 'Row Exclusive',
				4, 'Shared Table',
				5, 'Shared Row Exclusive',
				6, 'Exclusive') MODO_TRAVAMENTO
FROM    gV$LOCKED_OBJECT a, DBA_OBJECTS b, gv$session c
WHERE   a.OBJECT_ID = b.OBJECT_ID
and  	a.SESSION_ID = c.SID
and		a.INST_ID = c.INST_ID
and		c.blocking_instance is not null 
and 	c.blocking_session is not null
/


-- SQL_FULLTEXT DA SESSÃO QUE ESTÁ BLOQUEANDO O OBJETO

SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,
S.MACHINE,S.PORT , S.LOGON_TIME,SQ.SQL_FULLTEXT 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, 
V$PROCESS P, V$SQL SQ 
WHERE L.OBJECT_ID = O.OBJECT_ID 
AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR 
AND S.SQL_ADDRESS = SQ.ADDRESS;