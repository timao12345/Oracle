O ORATOP me pareceu bem prático para capturar problemas pontuais de performance no banco de dados.
Mostra em única tela os Top events e os SQL_Ids causadores, além de informações do servidor.

ORATOP - Utility for Near Real-time Monitoring of Databases, RAC and Single Instance (Doc ID 1500864.1)

1) Download: Doc ID 1500864.1

2) Copiar para o servidor /home/oracle/oratop
      mkdir oratop
      cd oratop
      scp oratop.RDBMS_11.2_LINUX_X64 oracle@<servername>:/home/oracle/oratop

3) Permissão
      chown oracle:oinstall
      chmod 750 oratop

4) Renomear o arquivo 
      mv oratop.RDBMS_11.2_LINUX_X64 oratop

5) Definir ORACLE_HOME, ORACLE_SID, LD_LIBRARY_PATH
      export LD_LIBRARY_PATH=$ ORACLE_HOME /lib


Exemplo:
	  
LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib; export LD_LIBRARY_PATH
CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib; export CLASSPATH
	  
	  
	  
	  
6) Executar
      cd /home/oracle/oratop
      ./oratop -i 10 / as sysdba
