/*SPFILE e PFILE: Entendendo e recuperando os arquivos de inicialização do Oracle
Filed under: Artigos, Banco de Dados, Estudos, Oracle, TI — 6 Comentários 17/11/2010
O banco de dados Oracle inicializa a partir da leitura de “um de seus arquivos” de inicialização. Como assim, um de seus arquivos?

São dois arquivos. O PFILE, mais conhecido por “init.ora”, e o SPFILE, que é um arquivo de parâmetro do servidor, conhecido como “spfile.ora”.

A instância Oracle inicialmente procura pelo SPFILE, caso não o encontre, buscará pelo PFILE. O SPFILE é uma versão binária do PFILE. Uma das maiores vantagens de se utilizar o SPFILE, é a possibilidade da alteração de diversos parâmetros de forma dinâmica, ativando-os sem a necessidade de reinicialização do banco de dados.

Para verificar a existência do SPFILE, basta executar o seguinte comando:*/

show parameter SPFILE;

--Para criar o SPFILE a partir do PFILE, utilize os seguintes comandos:

create SPFILE from PFILE;

create SPFILE from PFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/init.ora'

create SPFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/spfileNomeInstancia.ora' from PFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/init.ora'

create SPFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/spfileNomeInstancia.ora' from PFILE

create PFILE='/u01/app/oracle/product/11.2.0.4/middw01/dbs/init_midwd01-281122.ora' from SPFILE;

--Após isto, basta reiniciar o Oracle:

shutdown immediate;
startup

/*Durante o processo de reinicialização, o Oracle encontrará o SPFILE automaticamente.

Sempre faça um backup do SPFILE para um PFILE, pois um dia seu SPFILE pode corromper, então basta inicializar o Oracle a partir do PFILE. Como?

Criando um PFILE a partir do SPFILE já existente no BD:*/

create PFILE='u01/app/oracle/product/11.2.0/dbhome_1/dbs/initBACKUP.ora' from SPFILE;

--Caso o Oracle não inicie devido a um problema no SPFILE, inicialize-o a partir do PFILE salvo:

startup PFILE='u01/app/oracle/product/11.2.0/dbhome_1/dbs/initBACKUP.ora';

--O Oracle inicializará normalmente – só por que você fez o backup do SPFILE. Já que agora está tudo mais tranquilo, aproveite para criar um novo SPFILE a partir do PFILE – já que o atual está corrompido – seguindo a dica lá em cima.

create SPFILE from PFILE='/u01/app/oracle/product/11.2.0/dbhome_1/dbs/initBACKUP.ora';
shutdown immediate;
startup

/*Pronto, o Oracle voltou a iniciar a partir do SPFILE.
Lembre-se de sempre manter um backup “atualizado” do seu SPFILE em um PFILE.
Todas as operações acima são executadas com um usuário SYSDBA (sqlplus / as sysdba).

IMPORTANTE: Jamais edite de forma manual o SPFILE (spfile.ora), pois o mesmo é binário.*/

create pfile='/u01/app/oracle/product/11.2.0.4/middw01/dbs/init_midwd01-281122.ora' from spfile;
