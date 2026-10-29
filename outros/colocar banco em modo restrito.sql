-- OBs: 
    -- Somente usuarios com gran de RESTRICTED SESSION podem utilizar o BD, 
    -- em caso de RAC os usuarios irão autimaticamente utilizar o outro nó sendo necessario colocar em modo restrito nos dois nós caso seja necessário

-- Verifica se está liberado para todos os uaurios utilizarem
SQL> select logins from v$instance;

LOGINS
----------
ALLOWED

-- colocar em modo restrico para fazer manutenção no BD.
ALTER SYSTEM ENABLE RESTRICTED SESSION;

-- verificar modo que a instancia está apos o comando 
SQL> select logins from v$instance;

LOGINS
----------
RESTRICTED

-- Retirar do modo restrito para os usuarios utilizarem o BD
ALTER SYSTEM DISABLE RESTRICTED SESSION;