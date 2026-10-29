-- Dentro do banco que deseja alterar o nome do serviço faça as consultas e passos abaixo.
-- verificar serviços
SELECT name FROM dba_services;

-- Delete o serviço do banco de dados que não queira usar mais.
EXEC DBMS_SERVICE.STOP_SERVICE('bdweb.adcorp.intranet');
EXEC DBMS_SERVICE.DELETE_SERVICE('bdweb.adcorp.intranet');

-- Crie um novo.
EXEC DBMS_SERVICE.CREATE_SERVICE('bdweb', 'bdweb');

-- Associar o serviço a instancia atual.
EXEC DBMS_SERVICE.START_SERVICE('bdweb');

-- Apos isso, alterar o listener.ora e adicionar ou modificar a entrada do serviço