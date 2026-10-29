-- Adicionar tabela no OGG downstrean EXTRATOR
 /*
 Dentro do downstrean fazer login no banco de dados usando dblogin
 */

 --Em PROD precisa desabilitar a trigger antes de fazer o ADD TRAN antes de seguir os passos abaixo
 
Antes de fazer a alteração, executar esse comando no banco R102 de produção:
SQL> alter trigger A_RAIABD.TR_BLOQUEIA_DDL_TAB_REPLICADA disable;
 
Depois que terminar a alteração, executar esse comando no banco R102 de produção:
alter trigger A_RAIABD.TR_BLOQUEIA_DDL_TAB_REPLICADA enable;


-- dentro do GGSCI
>> dblogin userid oggforbd@r102HNEW, password PWD#oggforbd
Successfully logged into database.

-- realizar adição das tabelas 1 por 1 com add tran.
ADD TRANDATA A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE 
ADD TRANDATA A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE 

ADD TRANDATA A_RAIABD.TB_FORNECEDOR_AGENDA 


-- case de sucesso
/*

2023-11-30 12:53:24  INFO    OGG-15132  Logging of supplemental redo data enabled for table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE.

2023-11-30 12:53:24  INFO    OGG-15133  TRANDATA for scheduling columns has been added on table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE.

2023-11-30 12:53:26  INFO    OGG-15135  TRANDATA for instantiation CSN has been added on table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE.

2023-11-30 12:53:28  INFO    OGG-10471  ***** Oracle Goldengate support information on table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE *****
Oracle Goldengate support native capture on table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE.
Oracle Goldengate marked following column as key columns on table A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE: NR_PREFIXO, NR_TELEFONE.

GGSCI (lnxdownstreamqa01.raiadrogasil.com.br as oggforbd@R102HNEW) 5>

GGSCI (lnxdownstreamqa01.raiadrogasil.com.br as oggforbd@R102HNEW) 5>

GGSCI (lnxdownstreamqa01.raiadrogasil.com.br as oggforbd@R102HNEW) 5> ADD TRANDATA A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE

2023-11-30 12:54:59  INFO    OGG-15132  Logging of supplemental redo data enabled for table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE.

2023-11-30 12:54:59  INFO    OGG-15133  TRANDATA for scheduling columns has been added on table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE.

2023-11-30 12:54:59  INFO    OGG-15135  TRANDATA for instantiation CSN has been added on table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE.

2023-11-30 12:54:59  INFO    OGG-10471  ***** Oracle Goldengate support information on table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE *****
Oracle Goldengate support native capture on table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE.
Oracle Goldengate marked following column as key columns on table A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE: DS_EMAIL.

GGSCI (lnxdownstreamqa01.raiadrogasil.com.br as oggforbd@R102HNEW) 6>

*/

-- Agora no nivel do Downstrean (OGG Extrator) fazer um edit param na fila, adicionar na ultima linha para manter o padrão
>> edit param ECPBM

exmeplo:

EXTRACT ECPBM
USERID oggforbd@r102HNEW, password PWD#oggforbd
TRANLOGOPTIONS INTEGRATEDPARAMS (max_sga_size 1024, parallelism 1,downstream_real_time_mine Y)
TRANLOGOPTIONS MININGUSER oggadmds, MININGPASSWORD PWD#oggadmds
EXTTRAIL /u01/ogg/dirdat/pbm/ec
TRANLOGOPTIONS INCLUDEREGIONID
REPORTCOUNT EVERY 5 MINUTES, RATE
REPORTROLLOVER AT 05:30 ON friday
GETUPDATEBEFORES
LOGALLSUPCOLS
UPDATERECORDFORMAT FULL
SETENV (NLS_LANG="AMERICAN_AMERICA.WE8ISO8859P1")
TABLE A_RAIABD.TB_PBM_EAN_INTEGRACAO;
TABLE A_RAIABD.TB_PBM_INTEGRACAO_PROGRAMA;
TABLE A_RAIABD.TB_PBM_EAN_SEVENPDV;
-- RITM0312910 - Pedro Vido - 24/11/2023 --
TABLE A_RAIABD.TB_PBM_EAN;
TABLE A_RAIABD.TB_PBM_PLANO_SAUDE;
TABLE A_RAIABD.TB_BLACKLIST_TELEFONE_CLIENTE; -- linha nova
TABLE A_RAIABD.TB_BLACKLIST_EMAIL_CLIENTE; -- linha nova

-- stop start da Fila ECPBM
stop ECPBM
start ECPBM
