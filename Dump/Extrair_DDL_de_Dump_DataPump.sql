/*
  Extrair somente o DDL de um dump Oracle Data Pump (.dmp).

  O comando abaixo NAO importa dados nem cria objetos no banco.
  Ele lê o dump e grava os comandos DDL no arquivo informado em SQLFILE.

  Pré-requisitos:
    - O dump deve estar em um DIRECTORY Oracle.
    - O usuário deve ter privilégio para ler esse DIRECTORY.
    - SQLFILE é gravado no servidor Oracle, dentro do DIRECTORY informado.

  Substitua os valores entre <> antes de executar no SQL*Plus ou shell.
*/

-- Opção recomendada: usar diretamente no sistema operacional:
--
-- impdp <USUARIO>/<SENHA>@<SERVICE_NAME> ^
--   directory=<DIRECTORY_ORACLE> ^
--   dumpfile=<ARQUIVO_DUMP.dmp> ^
--   sqlfile=<ARQUIVO_SAIDA_DDL.sql> ^
--   logfile=<ARQUIVO_LOG.log>

-- Exemplo:
--
-- impdp system@ORCL ^
--   directory=DP_DIR ^
--   dumpfile=backup_full.dmp ^
--   sqlfile=backup_full_ddl.sql ^
--   logfile=backup_full_ddl.log

-- Para dump dividido em vários arquivos:
--
-- impdp system@ORCL ^
--   directory=DP_DIR ^
--   dumpfile=backup_full_%U.dmp ^
--   sqlfile=backup_full_ddl.sql ^
--   logfile=backup_full_ddl.log

-- Para extrair somente um schema:
--
-- impdp system@ORCL ^
--   directory=DP_DIR ^
--   dumpfile=backup_full.dmp ^
--   sqlfile=schema_ddl.sql ^
--   logfile=schema_ddl.log ^
--   schemas=APP_OWNER

-- Para extrair somente algumas tabelas:
--
-- impdp system@ORCL ^
--   directory=DP_DIR ^
--   dumpfile=backup_full.dmp ^
--   sqlfile=tabelas_ddl.sql ^
--   logfile=tabelas_ddl.log ^
--   tables=APP_OWNER.TABELA_1,APP_OWNER.TABELA_2

-- Validar o DIRECTORY e o caminho físico no banco:
SELECT directory_name, directory_path
FROM dba_directories
WHERE directory_name = UPPER('<DIRECTORY_ORACLE>');

-- Importante:
--   1. Não use CONTENT=METADATA_ONLY junto com SQLFILE; SQLFILE já extrai apenas DDL.
--   2. O arquivo SQLFILE não é executado automaticamente.
--   3. Revise e ajuste usuários, tablespaces, caminhos de datafiles e grants antes
--      de executar o DDL em outro ambiente.
