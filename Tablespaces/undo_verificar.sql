No artigo de hoje vou mostrar como configurar o UNDO Tablespace para permitir que ele armazene os dados das transações finalizadas, por mais tempo, permitindo deste modo, aumentar a possibilidade de recuperação de dados, via Flashback (meu próximo artigo será sobre Flashback).

Na configuração padrão do BD o O UNDO Tablespace armazena com segurança os dados das transações em processamento, por até 15 minutos. Se uma transação for maior que 15 minutos e/ou se o espaço deste tablespace não permitir armazenar informações suficientes para finalizar uma transação, o BD poderá disparar o famoso erro ORA-01555 Snapshot Too Old.Essa configuração não garante a retenção de dados das transações que já foram finalizadas.

Para evitar o erro ORA-01555, o primeiro passo é configurar o UNDO Tablespace com um tamanho que permita comportar os dados de todas as transações em processamento. Uma boa dica, é configurar o tamanho máximo do UNDO tablespace com um valor de no mínimo o dobro do seu uso médio e configurar um valor de auto-incremento (não muito pequeno, para evitar sobrecarga ao estender múltiplas vezes o tablespace, nem muito grande, para não disperdiçar espaço em disco).

O segundo passo, é configurar um valor de retenção (em minutos) de dados em UNDO, maior que o valor da maior transação do BD. Por exemplo, se a maior transação que ocorre no BD demora 10 minutos, o valor padrão de 15 minutos é maior e portanto não precisará ser alterado. O valor de retenção pode ser configurado através do parâmetro de instância UNDO_RETENTION. Uma BOA DICA para quem deseja facilitar recuperações de dados, usando Flashback, ao invés, de fazer restore/recover de Backup, é aumentar o período de retenção e configurar o tablespace para garantir que dados de transações finalizadas também sejam mantidas no UNDO Tablespace.

Abaixo vou mostrar os passos para configurar um UNDO Tablespace para reter e garantir a retenção dos dados (de transações finalizadas) por 1 semana (configuração normalmente que eu aplico nos BDs de produção que eu administro):

- See more at: http://www.tiespecialistas.com.br/2013/01/configurando-o-undo-tablespace/#sthash.CD8ZEkbQ.dpuf


Passo 1: Aumentando o período de retenção
Para aumentar o período de retenção para guardar os dados pelo período de 1 semana, conecte-se no SQL Plus ou ferramenta de sua preferência, com privilégios de DBA, e altere o valor do parâmetro UNDO_RETENTION para o valor de 604800 (valor em segundos correspondente ao período de 1 semana):
                    ALTER SYSTEM SET UNDO_RETENTION = 604800;

Passo 2: Garantindo o período de retenção

   Só aumentar o período de retenção (realizado no passo anterior) não garante que os dados das transações finalizadas permaneçam no UNDO Tablespace pelo período configurado no parâmetro UNDO_RETENTION. Para garantir a retenção de dados das transações finalizadas, é necessário alterar o tablespace executando o comando abaixo:

                    ALTER TABLESPACE undotbs1 RETENTION GUARANTEE;

Obs.: Substitua undotbs1 pelo nome correspondente do tablespace de UNDO. 

CUIDADO! Ao implementar as configurações acima, o tamanho do UNDO tablespace aumentará considerávelmente, pois será necessário ter espaço adicional para armazenar mais dados, pelo tempo maior configurado. Quanto maior o tempo de retenção, maior poderá ser o tamanho do UNDO Tablespace. Para calcular o tamanho mínimo necessário para ele, conforme configuração do parâmetro UNDO_RETENTION, execute a instrução SQL abaixo e configure-o de forma que ele possa armazenar o valor da coluna “NEEDED UNDO SIZE [MByte]“:

- See more at: http://www.tiespecialistas.com.br/2013/01/configurando-o-undo-tablespace/#sthash.CD8ZEkbQ.dpuf

SELECT     d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MByte]",
                      SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
                      (TO_NUMBER(e.value) * TO_NUMBER(f.value) *
                     g.undo_block_per_sec) / (1024*1024)
                   "NEEDED UNDO SIZE [MByte]"
FROM        (SELECT       SUM(a.bytes) undo_size
                       FROM        v$datafile a
                       inner join  v$tablespace b
                              on      a.ts# = b.ts#
                        inner join  dba_tablespaces c
                              on      b.name = c.tablespace_name
                       WHERE       c.contents = 'UNDO'
                      AND         c.status = 'ONLINE') d,
                      v$parameter e,
                      v$parameter f,        
                     ( SELECT   MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
                       FROM    v$undostat) g
  WHERE   e.name = 'undo_retention'
  AND         f.name = 'db_block_size';

- See more at: http://www.tiespecialistas.com.br/2013/01/configurando-o-undo-tablespace/#sthash.CD8ZEkbQ.dpuf