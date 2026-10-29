*************************************************
-- Ver carga da cpu e memoria atraves do utilitario top  
*************************************************

Utilizar utilitario top (nao requer privilegios especiais):
    > top

--------------------------------------------------------
DESCRICAO DAS PRINCIPAIS COLUNAS DE SAIDA DO TOP
--------------------------------------------------------
PID         Identificador do processo de usuario
USER        Nome do usuario do SO executando o processo
PR          Prioridade do processo
NI          Valor do processo. Numero negativo indica alta prioridade, valor positivo indica baixa prioridade
VIRT        Total de memoria virtual usada pelo processo
RES         Memoria fisica usada pelo processo
SHR         Memoria compartilhada usada pelo processo
S           Status do processo ('D' = uninterruptible sleep, 'R' = running, 'S' = sleeping, 'T' = traced or stopped, 'Z' = zombie)
%CPU        Percentual de consumo de CPU
%MEM        Percentual de consumo de memoria fisica 
TIME+       Tempo total de CPU em centesimos de segundos
--------------------------------------------------------
    
-- teclas de atalho do top:
    - d                     para mudar tempo de refresh: 
    - barra de espacos      atualizar refresh instantaneamente
    - B                     negrito para principais valores
    - h                     ver help
    - 1                     para ver consumo de cpu "por cpu" (e nao total geral)
    - c                     para ver detalhes dos nomes/caminhos dos processos
    
    
--------------------------------------------------------
IDENTIFICANDO PROBLEMAS
--------------------------------------------------------
-- 1a linha exibe: hora atual, uptime da maquina, qtde. usuarios logados e load average.
-- Load average exibe carga da cpu em 3 amostragens diferentes (ultimo minuto, 10m e 15m). 


Obs.: Um notebook com uma carga proxima igual a 2 pode estar uma carroca, porem um servidor Intel Xeon com carga de 8 pode ainda trabalhar muito bem.
      Tudo depende da quantidade de CPUs que a maquina possui.
    

     
LISTAR TOP 10 CPU:
    > ps -e -o pcpu,pid,user,tty,args | sort -n -k 1 -r | head

LISTAR TOP 10 MEMORY:
    > ps -e -o pmem,pid,user,tty,args | sort -n -k 1 -r | head
    
    