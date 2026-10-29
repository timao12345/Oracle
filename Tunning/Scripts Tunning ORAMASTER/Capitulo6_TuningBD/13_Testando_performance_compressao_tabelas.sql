-- crindo a tabela SOE.orders_items2 vazia
create table SOE.orders_items2 as select * from SOE.order_items where 1=0;

-- execute o bloco abaixo e veja que o tempo de INSERT piorou com compressao
SET SERVEROUTPUT ON
declare
  v_count NUMber;
  V_START NUMBER;
begin
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SOE.orders_items2';
    EXECUTE IMMEDIATE 'ALTER TABLE SOE.orders_items2 NOCOMPRESS';

    V_START := DBMS_UTILITY.GET_TIME;
    INSERT  INTO SOE.orders_items2
    SELECT * FROM SOE.ORDER_ITEMS where rownum < 100000;
      
    DBMS_OUTPUT.PUT_LINE('Tempo de execucao insert SEM compressao: ' || (DBMS_UTILITY.GET_TIME - V_START) || 'cs');  
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SOE.orders_items2';
    --EXECUTE IMMEDIATE 'ALTER TABLE SOE.orders_items2 COMPRESS FOR OLTP';
    EXECUTE IMMEDIATE 'ALTER TABLE SOE.orders_items2 ROW STORE COMPRESS ADVANCED';
    
    V_START := DBMS_UTILITY.GET_TIME;
    INSERT  INTO SOE.orders_items2
    SELECT * FROM SOE.ORDER_ITEMS where rownum < 100000;
    
    DBMS_OUTPUT.PUT_LINE('Tempo de execucao insert COM compressao ADVANCED: ' || (DBMS_UTILITY.GET_TIME - V_START) || 'cs');      
  
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SOE.orders_items2';
    EXECUTE IMMEDIATE 'ALTER TABLE SOE.orders_items2 COMPRESS BASIC';

    V_START := DBMS_UTILITY.GET_TIME;
    INSERT /*+ APPEND */ INTO SOE.orders_items2
    SELECT * FROM SOE.ORDER_ITEMS where rownum < 100000;
  
    DBMS_OUTPUT.PUT_LINE('Tempo de execucao insert COM compressao BASIC: ' || (DBMS_UTILITY.GET_TIME - V_START) || 'cs');    
end;