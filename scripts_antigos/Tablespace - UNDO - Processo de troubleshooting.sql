-- DESCRIÇÃO (exemplo):

-- Description:
-- AESAS3: Tablespace Used Space: 
-- UNDOTBS4/PCT_USED: 80

-- SOLUÇÃO:
-- A tablespace de UNDO tem um comportamento diferente das tablespaces
-- permanentes e temporárias. Considerando que ela está cheia e não pode crescer mais (já está 100%) 
-- ela pode reutilizar outros segmentos que estiverem
-- marcados pelo banco de dados como 'expired' (reutiliza SEMPRE mesmo com espaço livre) e 'unexpired' (NEM SEMPRE reutiliza e veremos
-- mais ou menos a mecânica por trás disso).
-- Portanto, o banco não vai, obrigatoriamente, printar erros na tela do usuário, ou parar
-- simplesmente pelo fato de batido essa marca percentual, muito pelo contrário, o banco
-- tem várias cartas na manga para lidar com a pressão de falta de espaço.
--
-- Portanto, uma série de outros eventos e configurações após isso é que vão determinar o impacto que o usuário possa ter.
-- Nesse sentido, apenas criar datafiles para "parar de alarmar" pode na realidade não estar
-- resolvendo problema algum como quero mostrar.

-- Muito bem. Então algumas dúvidas que eu quero elucidar são: 
-- 1) Como eu sei quando a UNDO tem problema ou não? 
-- 2) Ela está alarmando 80%, devo aumentar?

-- Antes de responder essas questões temos que entender alguns conceitos básicos antes de prosseguirmos, senão
-- não vai dar pra entender nada:
-- 1) O que é a UNDO afinal de contas?
-- 2) Quais são as propriedades e como se comportam os blocos da UNDO?
-- 3) Como tratar os erros da UNDO?
-- 4) Dimensionando UNDO.

-- Beleza, vamos lá:

-- Número um: 
-- A UNDO nada mais é do que uma tablespace especial que guarda imagens antigas dos dados quando você
-- executa uma DML (UPDATE, DELETE, MERGE, INSERT e etc...) em cima delas. A UNDO é a solução da Oracle para passar 
-- no teste ACID, mas na verdade, na verdade mesmo,
-- a UNDO é a implementação para passar pelas três primeiras letras "ACI" o "D" já trata de outro elemento: o REDO
-- que não nos interessa agora. Todo modelo de banco relacional PRECISA passar nesse teste, caso contrário, ele não pode ser considerado
-- um banco relacional.
-- A -> ATOMICITY: Não existe meio update, meio insert, meio delete... Ou a transação acontece, ou não acontece.
-- por isso você inicia uma DML o banco VAI GERAR UNDO, por que se acontecer qualquer merda no banco o ROLLBACK vai ser possível.
-- C -> CONSISTENCY: As leituras tem que fazer sentido no momento exato que você mandou a query. Por exemplo,
-- Rodrigo iniciou um update numa tabela às 9h mas esse update leva, sei lá, 1h pra terminar, Yago fez um select nessa mesma tabela 
-- às 9h30, mas esse select leva 3h, pelo princípio da consistência ele não pode ler os dados como estão na tabela às 9h30 e nem
-- retornar dados da tabela da maneira que ela vai estar às no final do update porque esses dados não refletem o estado
-- dos dados no MOMENTO DO SELECT, ou seja, você quer saber como eles tão agora ou antes, não no futuro! Logo dados estão estavam
-- consistentes às 9h, então o banco GERA UNDO para comtemplar essa propriedade.
-- I -> ISOLATION: Somente a sessão que executou a DML consegue ver sua própria alteração, todo resto simplesmente
-- não faz ideia da alteração. O isolamento decorre das duas propriedade acima, somente o cara que executou a DML
-- sabe quando os dados vão ficar certos, a alteração do cara pode mudar várias tabelas e as outras sessões não fazem
-- ideia de quando tudo vai estar ok, então o banco GERA UNDO pra que outras sessões possam coletar
-- dados consistentes. Enquanto a sessão que executou a alteração pode verificar se os dados estão consistentes
-- em termos de regra de negócio durante sua transação.

-- Assim percebemos que a solução ORACLE para isso é a UNDO, outras tecnologias tem implementações diferentes pra isso.
-- O que é importante você tirar disso é entender que tanto o SELECT como UPDATE, INSERT e DELETE são afetados pelo estado
-- da UNDO. Via de regra, se você tem um banco que está tendo um comportamento muito OLTP (muitas transações DML) talvez o seu select pode
-- ser impactado e o inverso também pode acontecer se seu banco de dados é muito focado em Warehousing (muita leitura) talvez
-- haja um comprometindo dos seus DML. Em suma, quanto maior o comportamento OLTP menos poder você vai ter pros seus selects,
-- quanto mais Warehousing menos poder você tem para DML - em teoria (por default o banco sempre dá preferência
-- para que as DML's rodem com sucesso), e vendo as propriedades dos blocos de UNDO vamos
-- entender o porquê.

-- Número dois:
-- Existem três tipos de blocos de UNDO: ACTIVE, EXPIRED, UNEXPIRED.
-- ACTIVE: Toda transação não comitada vai gerar blocos marcados como ativo na UNDO.
-- UNEXPIRED: Todo bloco de uma transação COMITADA e que tem tempo menor do que (depende) o parâmetro UNDO_RETENTION e/ou TUNED_UNDORETENTION
-- EXPIRED: Todo bloco COMITADO e que está além do UNDO_RETENTION e/ou TUNED_UNDORETENTION
-- Não entendeu nada? Vamos ver um exemplo com algun cenários agora para ficar mais claro como os blocos
-- são gerenciados em situação "desconfortáveis" pro banco:
-- Temos um tablespace de undo tem 1000 blocos que já está 100% de utilização e autoextend off.
-- Desses 1000 blocos, 600 são ACTIVE, 200 são UNEXPIRED e 200 são EXPIRED.
-- Mais uma sessão se conecta no banco de dados para rodar mais uma DML, essa vai custar
-- 200 blocos pro banco. O algortimo vai olhar pra tablespace e ver que tem 200 blocos
-- EXPIRED e 200 blocos UNEXPIRED, ele vai dar preferência em pegar esses 200 EXPIRED.
-- Portanto, agora temos 800 blocos ACTIVE e 200 UNEXPIRED.
-- Em seguida, mais uma conexão entra no banco também quer executar mais uma DML e pegar mais 200 blocos.
-- pra ela só vai ter disponível agora 200 blocos UNEXPIRED e é aqui que as configurações do banco vão
-- começar a fazer diferença. Se o parâmetro GUARANTEE da UNDO estiver ligado, BOOM, já era,
-- essa sessão vai tomar um "ORA-30036 unable to extend segment in Undo tablespace", porque
-- esse parâmetro GARANTE que blocos UNEXPIRED estão sempre disponíveis para leitura, se você
-- tentar criar mais blocos ACTIVE com eles você estaria violando essa garantia. Em miúdos,
-- com esse parâmetro ligado SELECTS nunca vão falhar por "ORA-1555: snapshot too old" - por culpa da UNDO.
-- Mas vamos supor agora que a tablespace - e o default é assim - que o GURANTEE está desligado,
-- o banco vai olhar pra esse blocos e entregar pra DML. Agora temos 1000 blocos utilizados como
-- ACTIVE, qualquer DML a mais agora vai causar ORA-30036.
-- Bom, quando o cara tentou colocar essa DML a mais o banco crashou? Na visão do usuário, sim,
-- porque toda sessão que entrar agora pra executar alguma DML vai travar, e alguns selects que 
-- não vão poder fazer "read consistency" também causando ORA-1555, porque como a tbs não podia mais
-- crescer o banco roubou os blocos UNEXPIRED que seriam lidos, mas, sendo bem filho da puta, o banco ainda está up ;).
-- E maior prova disso é que quando algumas DML's terminarem novos blocos UNEXPIRED e EXPIRED vão ser
-- gerados e é o que aconteceu no nosso exemplo. 800 blocos que estavam ACTIVE foram liberados,
-- ou seja, comitados. Para o banco de dados agora basta classificá-los como EXPIRED ou UNEXPIRED.
-- E como ele faz isso? Ele vai olhar o valor que está contido no UNDO_RETENTION se o banco tiver
-- versão menor que 10g ou vai olhar para TUNED_UNDORETENTION se o banco igual ou acima de 10g
-- com AUTOMATIC UNDO MANAGEMENT habilitado.
-- Nesse caso, vamos supor que o banco não em AUM. O UNDO_RETENTION está setado com valor de 20000 segundos,
-- aquelas DML's que comitaram e geraram 800 blocos, 500 deles duraram 15000 segundos e os outros 300
-- duraram 21000 segundos. E você já sabe o que vai acontecer, certo? Os 500 vão ficar marcados como
-- UNEXPIRED e vão ter mais 5000 segundos neste estado antes de serem marcados como EXPIRED, e os 300 que duraram 21000 já estão todos
-- marcados como EXPIRED.
-- Logo, se temos incidentes "ORA-1555" e "ORA-30036" Estes sim são fortes indícios de que alguma coisa está
-- errada na UNDO. O problema é que eles já ocorreram, o usuário já tomou eles na tela, mas ele muito provavelmente
-- não vai abrir um ticket imediatamente, ele vai primeiro tentar rodar a query ou DML e dessa vez vai dar certo,
-- porque como vimos com passar do tempo alguns blocos vão sendo liberados, mas perceba que se nada for feito,
-- a experiência do usuário tem forte tendência a ficar cada vez mais deteriorada até que ele vai se encher e abrir o ticket e você como DBA 
-- vai precisar tomar algumas das seguintes ações...


-- Numero Três:
-- 1) Verificar o valor correto do UNDO_RETENTION:
--          
-- Como saber se UNDO_RETENTION está correto? Simples ele deve ser ligeramente maior do que select mais demorado do banco!
-- Como assim? Pensa bem, suponha que você tenha um tabela que toda hora tem alguém atualizando-a, muito provavelmente
-- esse select demorado vai tentar ler essa tabela justamente no momento do update. Pra ter uma leitura consistente
-- ele vai precisar chamar blocos do undo, o que significa que ele vai precisar ler blocos UNEXPIRED, mas se esse blocos
-- viram EXPIRED mais rapidamente da execução da query, isso quer dizer que ele não vai garantir um leitura consistente,
-- porque já expirou tudo antes mesmo dele terminar a consulta. Logo para o UNDO_RETENTION é só ajustar o valor 10% maior
-- que o tempo do maior select "should do the trick". E como é possível ver o tamanho da query mais demorada? Numa dessas duas views:
-- V$UNDOSTAT ou se você tem o Diagnostic Pack habilitado DBA_HIST_UNDOSTAT (dá pra analisar por um período maior com essa)

-- Eis o select:

select max(maxqerylen)
  from v$undostat


-- @fonte: http://blog.oracle48.nl/oracle-database-undo-space-explained/
-- Banco de dados SEM AUMTOMATIC UNDO MANAGEMENT:

-----------------
-- Para ORA-1555:
-----------------
-- Use o select para determinar o valor do UNDO_RETENTION:
select round( 1.10 * max(maxquerylen), 0) as "UNDO_RETENTION" 
  from v$undostat;
-- Se o valor estiver correto, verificar a coluna UNXPSTEALCNT da V$UNDOSTAT.
-- Se houver muitas aparições de valores diferente de zero isso significa que a tablespace
-- não tem tamanho suficiente, porque os blocos expired estão sendo todos consumidos, a tablespace
-- não pode crescer e aí começa a comer blocos unexpired também. Aumente-a.
-- Se o valor estiver errado (menor) apenas aumente para o valor correto.
-- Se o valor estiver errado (maior) corrija-o e aumente a tablespace.

------------------
-- Para ORA-30036:
------------------
-- Use o select para determinar o valor do UNDO_RETENTION:
select round( 1.10 * max(maxquerylen), 0) as "UNDO_RETENTION" 
  from v$undostat;
-- Se o valor estiver correto, verificar a coluna NOSPACEERRCNT da V$UNDOSTAT.
-- Se houver muitas aparições de valores diferente de zero isso significa que a tablespace
-- está tentando crescer e não consegue mais usar nem blocos EXPIRED nem UNEXPIRED. Aumente-a.
-- Se o valor estiver errado (menor) aumente para o valor correto e aumente a tablespace.
-- Se o valor estiver errado (maior) diminua e aumente a tablespace.

-- Observaçao importante: Estamos considerando que o parâmetro GUARANTEE da tablespace está desligado.

-- Banco de dados COM AUMTOMATIC UNDO MANAGEMENT:

-----------------
-- Para ORA-1555:
----------------
-- Aumente o tamanho da tablespace. (Certificar que o UNDO_RETENTION não está muito alto)

------------------
-- Para ORA-30036:
------------------
-- Aumente o tamanho da tablespace.

-- Observação importante: Como podemos ver o gerenciamento de UNDO com o auxiliar da ORACLE
--                        envolve muito menos decisões do DBA.


-- Conclusão: Assim, vemos que, EM CASO DE ERROS, ambientes sem AUM corrija UNDO_RETENTION e mexa na tablespace se necessário.
-- 			  Com AUM basta aumentar a tablespace na maioria dos casos.

-- Para alterar o valor do UNDO_RETENTION (Alteração ONLINE) :
alter sytem set UNDO_RETENTION = [valor]

-- Número quatro:
-- Bom, agora que você sabe como ver se a tablespace está com UNDO_RETENTION correto, resta saber se a tablespace
-- de UNDO tem um valor razoável. E como sabemos isso? É meio dificil constatar na verdade, mas temos alguns métodos!
-- Esses métodos se baseiam em algumas premissas que tem seus pontos fortes e fracos.

-- PREMISSA 1 (super-segura)
-- O valor correto do tamanho da UNDO deve ser suficientemente grande para comportar a maior quantidade de blocos
-- ACTIVE sem causar ORA-30036 e dentro dessa demanda permitir a leitura mais demorada dos mesmos sem causar ORA-1555. Assim concluímos que o tamanho
-- da UNDO pode ser calculado pela fórmula abaixo:

-- UNDO_SIZE = UNDO_RETENTION * max(UNDO_BLOCKS_PER_SECOND) * DB_BLOCK_SIZE + OVERHEAD
-- @variáveis:
-- UNDO_SIZE                 : Tamanho da tablespace
-- UNDO_RETENTION            : Valor em segundos do tempo em que o banco de dados vai ser esforçar
--                             para manter blocos como UNEXPIRED
-- UNDO_BLOCKS_PER_SECOND    : Taxa por segundo de geração de undo no pico de utilização dados
--                             um período no passado
-- DB_BLOCK_SIZE             : Tamanho do bloco do banco de dados     
-- OVERHEAD                  : Gordura em cima do resultado

-- Lembrando que esta fórmula funciona muito bem para ambientes SEM AUM. Se ele tiver AUM não adianta muito
-- usar porque ele usa o parâmetro TUNED_UNDORETENTION que está sendo toda hora modificado e pode assumir
-- valores muito diferentes do UNDO_RETENTION.
-- Assim para ambientes COM AUM o melhor a se fazer é utilizar um dos dois seguintes valores
-- max(TUNED_UNDORETENTION) ou max(MAXQUERYLEN), ambos valores encontrados na v$undostat.
-- E mesmo assim você pode encontrar valores inconcebíveis (super-seguros) e vamos ver por que.

-- Bem, assumindo que seu UNDO_RETENTION já está correto utilize as seguintes querys
-- para determinar o tamanho da UNDO.

-- QUERY 1:

-- @fonte: http://www.fabioprado.net/2012/11/configurando-o-undo-tablespace.html <-- Script levemente modificado
-- Contexto no qual a query deve ser utilizada:
-- 1) O banco de dados deve não pode estar usando AUTOMATIC UNDO MANAGEMENT
--    - e se ele não estiver, ou é uma versão antes do 10g, ou é muito mal administrado ;)
-- 2) Em ambientes RAC você vai ter que rodar a query em cada nó. E escolher o maior
-- de todos para colocar o mesmo valor em todas as tablespaces ou modificar a query
-- para pegar gv$ (MAS CUIDADO, com isso você pode estar pegando valores
-- errados porque a query contém muitos joins... É meio complexa).
-- 3) Para saber se usa ou não AUM, use a seguinte query. O valor do paràmetro
-- é auto-explicatório.

select name,
       value
  from v$parameter
 where upper(name) = 'UNDO_MANAGEMENT'
	   
-- Eis a query para dimensionamento do tamanho da UNDO:
SELECT d.undo_size/( 1024 * 1024 * 1024) "TAMANHO_REAL_DA_UNDO [GB]",
       SUBSTR( e.value , 1 , 25) "UNDO RETENTION [S]",
       ( TO_NUMBER(e.value) * TO_NUMBER(f.value) * g.undo_block_per_sec) / (1024*1024) "TAMANHO_NECESSARIO_DA_UNDO [GB]"
  FROM ( SELECT SUM(a.bytes) undo_size
           FROM v$datafile a
           inner join v$tablespace b
                   on a.ts# = b.ts#
                inner join dba_tablespaces c
                        on b.name = c.tablespace_name
                     WHERE c.contents = 'UNDO'
                       AND c.status = 'ONLINE') d,
               v$parameter e,
               v$parameter f,        
               ( SELECT MAX (undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
                       FROM v$undostat) g
  WHERE e.name = 'undo_retention'
    AND f.name = 'db_block_size';

-- Pontos fracos dessa query:
-- 1) Se baseia na v$undostat, ou seja, apenas considera o workload de mais ou menos dois dias.
-- 2) Não é representativo pra ambientes com AUM
-- 3) Em RAC não funciona
-- 4) Pode te informar um valor que na realidade é muito maior do necessário se o seu UNDO_RETENTION estiver errado.
-- Pontos fortes:
-- 1) Não precisa de Diagnostic Pack licensiado, então é boa pra utilizar em ambientes "mais simples".

-- QUERY 2:

-- @fonte: http://satya-dba.blogspot.com.br/2009/09/undo-tablespace-undo-management.html e "My Oracle Support" --> Doc ID 262066.1
-- Este script abaixo foi criado por mim para determinar o tamanho SUPER-SEGURO da UNDO tablespace
-- assumindo as seguintes premissas:
-- 1) O banco de dados utiliza AUTOMATIC UNDO MANAGEMENT 
-- 2) O banco de dados é RAC
-- 3) O banco de dados tem licensa do DIAGNOSTIC PACK

-- Fórmula adaptada para AUTOMATIC UNDO MANAGEMENT:

-- UNDO_SIZE = max(TUNED_UNDORETENTION) * max(UNDO_BLOCKS_PER_SECOND) + OVERHEAD
-- @Variáveis:
-- UNDO_SIZE             : Tamanho da tablespace
-- TUNED_UNDORETENTION   : Valor em segundos em que o banco de dados vai ser esforçar
--                         em manter blocos UNEXPIRED.
-- UNDO_BLOCKS_PER_SECOND: Taxa por segundo de geração de undo no pico de utilização dados
--                         um período no passado
-- OVERHEAD:             : Tamanho do bloco do banco de dados

-- Baseado nessas informações é possível utilizar a seguinte query para determinar o tamanho
-- de cada undo tablespace:
  
with undo_blocks_per_second as 
(
-- Capturando o pico de geração de UNDO do banco para cada instância
-- em blocos por segundo
select instance_number, 
       round(max(undoblks)/10/60,0) as "RATIO"
  from dba_hist_undostat 
 group by instance_number
), db_block_size as
(
-- Coletando o tamanho do bloco do banco de dados
select value as "DB_BLOCK_SIZE"
  from v$parameter 
 where name = 'db_block_size'
), undo_retention as
(
-- Capturando o maior valor de TUNED_UNDORETENTION do banco
select instance_number,
       max(tuned_undoretention) AS "TUNED_UNDORETENTION"
  from dba_hist_undostat
 group by instance_number
)
select u.instance_number, 
-- Aplicando a fórmula mencionada (UNDO EM GB)
       u.ratio,
	   r.tuned_undoretention,
	   d.db_block_size,
       round (u.ratio * r.tuned_undoretention * d.db_block_size / 1024 / 1024 / 1024 , 0) as "UNDO_SIZE"
 from undo_blocks_per_second u,
      undo_retention r,
      db_block_size d
where u.instance_number = r.instance_number

-- Assumindo que o valor do threshold da monitoração é 80% multiplique o maior valor
-- encontrado por 1.3, e esse vai ser seu valor de UNDO mais a gordura do OVERHEAD.

-- Pontos fortes:
-- 1) Consulta um grande período de tempo (meses) para determinar o valor da UNDO.
-- 2) Funciona em RAC
-- Pontos fracos:
-- 1) Tem que ajustar pra funcionar em single instance.
-- 2) Pode te entregar um valor absurdo porque não é de se esperar que o momento em que
-- está executando a query mais demorada também é o momento em que o banco está com maior
-- atividade DML. Portanto esse é um resultado para o PIOR CENÁRIO do banco de dados
-- que dependendo de como ele é usando nunca vai acontecer porque ao se modelar um banco
-- de dados (e ainda mais es for muito grande) não é eficiente ter um banco
-- muito transacional e muito não-transacional ao mesmo tempo.

-- PREMISSA 2:
-- Agora vamos tentar dimensionar uma UNDO menor, supondo um cenário mais "real"
-- com valor "menos seguro" que seria pegar o valor da query mais longa no range do horário
-- do maior pico de geração de blocos UNDO ACTIVE. (Perceba, isso é diferente de
-- de pegar o maior select em qualquer horário do dia)

-- QUERY 1:
-- UNDO_SIZE = at_max_undo_blocks(MAXQUERYLEN) * max(UNDO_BLOCKS_PER_SECOND) + OVERHEAD
-- @Variáveis:
-- UNDO_SIZE             : Tamanho da tablespace
-- TUNED_UNDORETENTION   : Valor em segundos em que o banco de dados vai ser esforçar
--                         em manter blocos UNEXPIRED.
-- UNDO_BLOCKS_PER_SECOND: Taxa por segundo de geração de undo no pico de utilização dados
--                         um período no passado
-- OVERHEAD:             : Gordura

with undo_blocks_per_second as 
(
-- Capturando o pico de geração de UNDO do banco para cada instância
-- em blocos por segundo
select instance_number,
       round(max(undoblks)/10/60,0) as "RATIO"
  from dba_hist_undostat  
 group by instance_number
), db_block_size as
(
-- Coletando o tamanho do bloco do banco de dados
select value as "DB_BLOCK_SIZE"
  from v$parameter 
 where name = 'db_block_size'
), undo_retention as
(
-- Capturando o valor  médio do MAXQUERLYLEN no banco no
-- momento de execução da maior carga de DML.
select u.instance_number,
       round(avg(u.maxquerylen),0) as "MAXQUERYLEN"
  from dba_hist_undostat u,
       ( select t.begin_time + 1/48 as "UPPER_BOUND",
                t.begin_time - 1/48 as "LOWER_BOUND"
                        from ( select s.instance_number, 
                                      s.begin_time
                                 from dba_hist_undostat s
                                where undoblks in ( select max(undoblks) as "UNDOBLKS"
                                                      from dba_hist_undostat  
                                                     group by instance_number) ) t ) l
 where begin_time between l.lower_bound and l.upper_bound
 group by instance_number
 order by instance_number asc 
)
select u.instance_number, 
-- Aplicando a fórmula mencionada (UNDO EM GB)
       u.ratio,
	   r.maxquerylen,
	   d.db_block_size,
       round (u.ratio * r.maxquerylen * d.db_block_size / 1024 / 1024 / 1024 , 0) as "UNDO_SIZE"
  from undo_blocks_per_second u,
       undo_retention r,
       db_block_size d
 where u.instance_number = r.instance_number
 order by instance_number
 
-- Assumindo que o valor do threshold da monitoração é 80% multiplique o maior valor
-- encontrado por 1.3, e esse vai ser seu valor de UNDO mais a gordura do OVERHEAD.


-- CONCLUSÃO:
-- Se chegar um chamado de tablespace com 80% de utilização o que deve ser feito na prática?
-- 1) Verificar o valor do UNDO_RETENTION e consertar se tiver não tiver AUM, caso tenha,
--    Verificar se ele está com um valor MUITO ALTO.
-- 2) Verificar na view v$undostat e/ou dba_hist_undostat se as colunas NOSPACEERRCNT e UNXPSTEALCNT 
--    apresentam alguma contagem, se apresentarem, aumente a tablespace.
-- Coisas importantes que podemos tirar desse troubleshooting:
-- 1) Uma tablespace com muito espaço livre pode causar erros de snapshot too old mesmo assim
-- 2) A monitoração deveria focar muito mais no valor do UNDO_RETENTION e este não é monitorado
-- 3) Em ambientes com AUM se blocos UNEXPIRED não estão sendo roubados então não precisa nem meter a mão
--    na tablespace.

-- observação1: Diante disso tudo eu acho que o ideal seria na verdade uma monitoração para tablespace
--              de UNDO quando estiver acima de 95% (claro que quanto maior a tablespace mais podemos
--              subir esse valor). O que é mais crítico ser monitorado mesmo não é, o valor do UNDO_RETENTION,
--              mas a ferramenta da monitoração não tem esse poder de customização.
-- observação2: O Oracle possui o Tunning Undo Advisor mas ele envolve o uso de uma série de procedures
--              tanto documentadas como não documentadas para chegar tamanho de UNDO e valor de TUNED_UNDORETENTION
--              e é algo que preciso pesquisar mais pra saber como usar efetivamente.

-- Scripts adicionais:

-- Scripts encontrados no My Oracle Support (Doc ID 262066.1)

-- UNDO_SIZE = UR * (UPS * DBS)
-- Pre 10g
SELECT (UR * (UPS * DBS)) AS "Bytes"
     FROM (SELECT value AS UR FROM v$parameter WHERE name = 'undo_retention'),
          (SELECT undoblks/((end_time-begin_time)*86400) AS UPS
           FROM v$undostat
           WHERE undoblks = (SELECT MAX(undoblks) FROM v$undostat)),
          (SELECT block_size AS DBS
           FROM dba_tablespaces
           WHERE tablespace_name = (SELECT UPPER(value) FROM v$parameter WHERE name = 'undo_tablespace'));

-- Pos 10g
SELECT (UR * (UPS * DBS)) AS "Bytes"
FROM (select max(tuned_undoretention) AS UR from v$undostat),
(SELECT undoblks/((end_time-begin_time)*86400) AS UPS
FROM v$undostat
WHERE undoblks = (SELECT MAX(undoblks) FROM v$undostat)),
(SELECT block_size AS DBS
FROM dba_tablespaces
WHERE tablespace_name = (SELECT UPPER(value) FROM v$parameter WHERE name = 'undo_tablespace'));
 