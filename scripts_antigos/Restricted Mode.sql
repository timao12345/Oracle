André Henrique Tonet Moreno	para os job_quee

alter system set job_queue_processes=0 scope=both sid='*';
Retornando# alter system set job_queue_processes=1000 scope=both sid='*';

	distinct username na gv$session
	
	lock em todo mundo
	
	executa o comando de kill geral
	
	for i in 'ps -ax|grep -i AESAS|grep LOCAL=NO|cut -d? -f1'; do kill -9 $i; done 
	
	verifica se todos morreram
	
	alter system flush shared_pool...varias vezes
	alter system flush buffer_cache....varias vezes
	
	conecta no pl com o SYS as sysdba
	
	ALTER SESSION SET CURRENT_SCHEMA=SIAE 
	
	antes disso abre o sql window
	
	ALTER SESSION SET CURRENT_SCHEMA=SIAE 
	
#############################################################################################

alter system flush shared_pool;
alter system flush buffer_cache;



1 – Parar todas as instancias. 
srvctl stop database -d AESAS

2 – Start de todas as instancias em modo restrito 

srvctl start database -d AESAS -startoption restrict 
 
Quando o banco de dados subir, conecte em cada instancia para verificar se está em modo restrito:

select instance_name, status, logins from gv$instance;
(A coluna logins deve retornar “Restricted” ) 

3 – Para executar as RDM’s, devemos conectar pelo plsql, porém, como o banco de dados estará em modo restrito não conseguiremos, então, será necessário tirar uma das instancias do modo restrito, conectar no pls/sql e colocar em modo restrito novamente pelo pl/sql. 

Conecte no sqlplus e para tirar do modo restrito rode o comando:
ALTER SYSTEM DISABLE RESTRICTED SESSION;
ALTER SYSTEM ENABLE RESTRICTED SESSION;
 

Conecte no banco de dados pelo pl/sql com o usuario “PRODUCAO” ou “SYS”.
Rode o comando para habilitar novamente o modo restrito:
ALTER SYSTEM ENABLE RESTRICTED SESSION;
Confira se está em modo restrito mesmo.

4 – Ao desabilitar o modo restrito, muitas conexões entrarão no banco de dados, então, será necessário derrubar todas essas sessões para iniciar as RDM’s. 
Eu fiz da seguinte forma:
Rodei o comando abaixo e matei todas a sessões.

SELECT 'ALTER SYSTEM KILL SESSION '||''''||sid ||','|| serial#||',@'|| INST_ID||''''||' immediate;'
 FROM gv$session
 WHERE type != 'BACKGROUND';

select 'alter system kill session'||''''||sid||','||serial#||''''||' immediate;'
from v$session where username not in ('SYS','PRODUCAO');
#########################################################################################################
######## NÃO ESQUECER!!! Retornando# alter system set job_queue_processes=1000 scope=both sid='*'; ######
#########################################################################################################
