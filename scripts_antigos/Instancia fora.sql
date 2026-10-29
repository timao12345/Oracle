-- Alertas de instancia fora verificar abaixo:

--verificar Listener do oracle 
 
SYS> LSNRCTL 
ou 
SYS> LSNRCTL status (nome da instancia)

--Verificar status do banco

select * from v$instance;

--Verificar se foi atingido maximo de login no servidor

verificar script "Sessões ativas.sql"

--Verificar o ADRCI (ADRCI - Automatic Diagnostic Repository)

$adrci

adrci> show Alert
selecionar o numero desejado para ver o log do banco

teclas SHIFT+g redireciona para o fim, tambem podendo utilziar as teclas PAGE UP e PAGE DOWN, 

para sair digite :q!


-- Verificar crsctl (crsctl - Clusterware Control)
-- mudar para o usuario root
$ sudo su -
$> crsctl status res -t

-- Verificar o ASM se encheu algum ( ASM - Automatic Storage Management)
--mudar para o usuario oracle e setar variavel do ASM ---   +ASM

oracle@MICHIGAN: /home/oracle # . oraenv
ORACLE_SID = [cmthmg] ? +ASM

oracle@MICHIGAN: /home/oracle # asmcmd lsdg


--Para dar um stop nas instancias
$> crsctl stop has
.
.
.
--Para dar um start nas instancias

$> crsctl start has
.
.
.

executar comando abaixo para verificar as instancias que já subiram

$>ps -ef | grep pmon

--Verificar o Listener
$>ps -ef | grep tns

root 30015978 10748294   0 21:09:20  pts/0  0:00 grep tns
oracle 65798460        1   0 20:47:37      -  0:00 /u01/app/oracle/product/12.2.0/grid/bin/tnslsnr LISTENER -no_crs_notify -inherit

lsnrctl status LISTENER