O erro ORA-01194

Neste artigo vamos tratar o que significa o erro ORA-01194, quando este erro  ocorre e o que fazer para tentar corrigir este erro.

Uma das mensagens mais preocupantes que um DBA pode ler em sua tela é ORA-01194.
Mas quando essa mensagem pode ser apresentada ao DBA?

Abaixo os principais motivos:

Essa mensagem pode aparecer quando o DBA tenta renomear um banco de dados, utilizando a opção “create controlfile”, onde o DBA recria os “controlfiles” reapontando os “datafiles” mudando o nome do banco de dados e eventualmente o banco foi copiado (aberto) on-line, ou o backup estã inconsistente;
Quando numa queda inesperada do banco de dados, o DBA ao tentar levantar o banco de dados os arquivos de “redo logs” ficam desatualizados e são sobrescritos;
Ou por problemas no armazenamento do banco de dados (erros em discos, por exemplo).


Mensagem: “ORA-01194: file 1 needs more recovery to be consistent ORA-01110: data file 1: '...../system01.dbf'”.

Causa: Uma sessão de restauração (recovery) incompleta foi iniciada, mas um número insuficiente de arquivos de “redo logs” foram aplicados tornando o arquivo inconsistente.

O arquivo não foi fechado corretamente quando ele foi aberto pela última vez pelo banco de dados. A causa mais provável desta mensagem é que o arquivo que foi copiado durante o backup apresentou problemas na restauração indicando o processo como incompleto.

Ação: O arquivo que deve ser recuperado está desatualizado. Devem-se aplicar os “archives” até que o arquivo fique consistente ou deve-se restaurar o arquivo de um backup mais antigo.


Se você como DBA já enfrentou esse tipo de erro, após fazer uma restauração do backup com sucesso pode ser necessário utilizar o parâmetro não documentado "_allow_resetlogs_corruption"

Porém antes de utilizar esse parâmetro vamos a uma explicação do que este parâmetro pode fazer.

Antes de pensar sobre o uso do parâmetro não documentado "_allow_resetlogs_corruption", todas as possibilidades de restauração devem ter sido esgotadas. Porque este parâmetro força a abertura dos arquivos de dados mesmo se suas informações não coincidirem. Ele não verificará a consistência dos arquivos de “redo logs”. Durante o próximo “checkpoint” do banco de dados os valores antigos do SCN serão sobrescritos. Isso pode deixar o banco de dados em um estado desconhecido (unknown state).

Depois de utilizar este método de recuperação, quando o banco de dados for aberto, o DBA deve exportar os dados e reconstruir o seu banco de dados. Porque neste método de recuperação algum arquivo será deixado para traz, acarretando problemas futuros com os dados, impossibilitando a abertura futura. Após a inicialização e desligamento do banco de dados o gerenciador irá solicitar a recuperação dos “redologs” antigos (archive logs) passando por todos os “redologs” disponíveis (on-line), inviabilizando a recuperação (geralmente o arquivo solicitado é o “id#1” referente a tablespace SYSTEM, sem esse arquivo o banco fica impossibilitado de abrir).

Mensagens mais comuns:

ORA-01194: file 1 needs more recovery to be consistent ORA-01110: data file 1: '..../system01.dbf'

ou

ORA-01547: warning: RECOVER succeeded but OPEN RESETLOGS would get error below ORA-01194: file 12 needs more recovery to be consistent ORA-01110: data file 12: ..../data01.dbf'

Se todos os “archive logs” disponíveis foram aplicados e todos os “redologs” disponíveis foram aplicados e o erro não for corrigido, só então que deve-se utilizar o parâmetro "_allow_resetlogs_corruption". Certifique-se de que um bom backup do banco de dados em um estado fechado (conhecido como “cold backup”) tenha sido executado antes da tentativa de recuperação usando o parâmetro "_allow_resetlogs_corruption".

Abaixo seguem os passos a serem executados para tentar a recuperação do banco de dados, utilizando o parâmetro "_allow_resetlogs_corruption".

1) Baixar o banco de dados, usar:
  SQL> SHUTDOWN IMMEDIATE;

2) Alterar o arquivo “init.ora” incluir a cláusula abaixo:
_allow_resetlogs_corruption = true

3) Levantar o banco de dados, usar:
 SQL> STARTUP MOUNT pfile='[caminho]+[nome_init.ora]' ;
 SQL> ALTER DATABASE OPEN RESETLOGS;

4) Se o banco de dados solicitar um “recover”,  deve-se utilizar o comando abaixo:
 
 SQL> RECOVER DATABASE UNTIL CANCEL;
 SQL> digitar [CANCEL]+[teclar ENTER]

Este comando indicará ao gerenciador de banco de dados que o “recover” foi efetuado, permitindo a abertura em sua sequência. Depois deve-se executar o comando abaixo: