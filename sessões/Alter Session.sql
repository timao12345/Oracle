-- Altera a nivel de sessão para realizar operações DDL em paralelo
ALTER SESSION ENABLE PARALLEL DDL; 

-- Altera a nivel de sessão para aguardar lock em 600 segundos. 
ALTER SESSION SET DDL_LOCK_TIMEOUT= 600; 