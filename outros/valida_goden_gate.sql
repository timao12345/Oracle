OGG login add tabela
dblogin userid oggforbd@r102HNEW, password PWD#oggforbd
miningdblogin userid oggadmds@dbdowndr, password PWD#oggadmds


list comands
https://docs.oracle.com/en/middleware/goldengate/core/21.3/gclir/ggsci-command-line-interface-commands.html#GUID-810596D1-B088-413D-8918-A810ED891962

golden gate
ggsci
subir fila DSCLIEND
start DSCLIEND

Alguns comandos uteis.
view param RSPRODUT
lista o log do serviço
view report RSPRODUT

lista status
info all

retorna o home
ps -ef|grep prm

/* Dentro do home do OGG temos o ./server que é utilizado para subir as portas do OGG exemplo abaixo*/

nohup ./server -p 7809 &

######
# altera o parâmetro de retenção
edit params mgr
 
# faz o refresh online da configuração do mgr
refresh mgr
 
# força a o purge imediato com a nova retenção.
send manager getpurgeoldextracts
send manager purgeoldextracts
######

--27.A) Entrando no Golden Gate
--Entrar no GoldenGate :
ggsci ou ./ggsci

--27.B) Mostrando processos no Golden Gate
info all

--27.C) Mostrando logs de erro no Golden Gate

--Descobrir o diretório do ogg e procurar o log ggserr.log

tail -f ggser.log

--27.D) Mostrar status de um replicação específica 
/*Rodar o comando "Info all" e escolher a replicação a qual quer ver status do ultimo ckpt, local dos trails*/

--Depois rodar "info <GROUP>" para ver as informações, 
--Outro comando com mais informações : "Info <group>, detail"
INFO <GROUP>
SEND <GROUP> STATS, HOURLY

--27.E) Mostrar sequencia de trails existentes para um replicação 
--Usar o comando info all para descobrir o path trail location e usar no comando abaixo:
sh ls -ltr <path trail location>



27.F) Mudar sequencia de leitura de trails



Usar o comando info all para descobrir o path trail location e usar no comando abaixo dentro do ggsci:
sh ls -ltr <path trail location>
a saida do comando acima vai mostar o trail mais antigo até o mais recente ordenado por data e hora
Exemplo: -rw-r  -    1 oracle   dba       199997993 May 19 02:06 ra000365884

Usar a sequencia que deseja que o REPLICAT ou EXTRACT leia, no caso os trails tem a sequencia no final do nome do arquivo : ra "000365884"

Rodar o seguinte comando : "alter <group>, extseqno <sequence>, extrba 0" Após isso dar um start no processo e validar no log (27.D) o status da replicação.



27.G) Mudar sequencia de gravação de trails



Etrollover manda o processo fazer switch para um novo arquivo. Exemplo: se o extrator estava gravando 
no arquivo ta000000009, após o etrollover ele vai iniciar do ta000000010


ALTER EXTRACT <group name>, ETROLLOVER



27.H) infos de log sem entrar no ggsci



echo "INFO *CSTPRD*" | ggsci | grep Lag



27.I) Ignorar erros no ogg



DDLERROR 5678 IGNORE
DDLERROR 1430 IGNORE
DDLERROR 1435 IGNORE
DDLERROR 955 IGNORE


27.J) Kill ogg process



KILL REPLICAT group_name
KILL EXTRACT group_name



27.K) Ver qual arquivo o processo está lendo e escrevendo



send pbdcst2 status



27.L) Ver lag tabelas ogg SASDBPRD



select max(dt_ogg),sysdate - max(dt_ogg) as "LAG em MS" from LOBBY.ITEM_T;



27.L) Comandos de Help do ogg



Ver o range de portas disponiveis para o ogg usar

help send manager
SEND MANAGER GETPORTINFO DETAIL
