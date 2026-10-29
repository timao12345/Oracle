-- *** No 10G a opcao disponivel era configurar somente 1 parametro (COMMIT_WRITE) com 2 valores:
ALTER SESSION SET COMMIT_WRITE = '{IMMEDIATE | BATCH},{WAIT |NOWAIT}'

-- *** A partir do 11G deve-se configurar 2 parametros: COMMIT_WAIT e COMMIT_LOGGING.
show parameter COMMIT_WAIT
show parameter COMMIT_LOGGING

-- NAO EXECUTAR: Configurando commit assincrono: COMMIT_WAIT = NOWAIT. Valores possiveis: NOWAIT | WAIT (DEFAULT)
alter session set COMMIT_WAIT = nowait;
-- Para configurar commit em batch. Valores possiveis: IMMEDIATE (default) | BATCH. Batch agrupa pequenos commits p/ executar com menos I/O
ALTER session SET COMMIT_LOGGING = BATCH;

-- criando tabela para testes:
CREATE TABLE HR.EMP AS SELECT * FROM HR.EMPLOYEES WHERE 1=0;

-- configure commit sincrono (valor default):
alter session set COMMIT_WAIT = wait;
ALTER session SET COMMIT_LOGGING = IMMEDIATE;

-- EXECUTE o bloco 1 e veja o tempo:

-- *** BLOCO 1 ***
SET SERVEROUTPUT ON
declare
  v_count NUMber;
  V_START NUMBER;
begin
  V_START := DBMS_UTILITY.GET_TIME;
  for linha in (SELECT   FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
            HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
    FROM    HR.EMPLOYEES
    connect by level < 3)
  loop
    INSERT  INTO HR.EMP
    values (HR.EMPLOYEES_SEQ.NEXTVAL, linha.FIRST_NAME, linha.LAST_NAME, linha.EMAIL, 
            linha.PHONE_NUMBER, linha.HIRE_DATE, linha.JOB_ID, linha.SALARY, 
            linha.COMMISSION_PCT, linha.MANAGER_ID, linha.DEPARTMENT_ID);  
    COMMIT;
  end loop;
  
  DBMS_OUTPUT.PUT_LINE('Tempo de execucao com 1 COMMIT por linha: ' || (DBMS_UTILITY.GET_TIME - V_START) || 'cs');
 END;
 
 -- configurando commit assincrono e batch commit:
alter session set COMMIT_WAIT = nowait;
ALTER session SET COMMIT_LOGGING = BATCH;

-- limpe a tabela e EXECUTE novamente o bloco 1 e veja o tempo do SQL com COMMIT sincrono
TRUNCATE TABLE HR.EMP;

-- EXECUTE o bloco 1 novamente e veja o tempo:
