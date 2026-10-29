-- veja o PE do SQL abaixo fazendo FTS p/ recuperar 1 unica linha:
EXPLAIN PLAN FOR
    SELECT * FROM SOE.CUSTOMERS
    WHERE   CUST_EMAIL = 'alton.tran@me.com';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);  

-- custo fts: 26.266 

-- crie um indice local e veja o custo no PE:       
CREATE INDEX soe.ix_customer_custemail_local on SOE.CUSTOMERS(CUST_EMAIL) local; -- 46s
drop INDEX soe.ix_customer_custemail_local;

-- custo ind local: 68

-- crie um indice global e veja o custo no PE:   
CREATE INDEX soe.ix_customer_custemail_global on SOE.CUSTOMERS(CUST_EMAIL) global; -- 69s
drop INDEX soe.ix_customer_custemail_global;

-- custo ind global: 6
