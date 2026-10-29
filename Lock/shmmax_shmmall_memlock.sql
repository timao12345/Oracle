Caso de Uso de mem�ria:

MEMLOCK 
Limita a mem�ria que pode ser usada, no exemplo de um servidor de 142G, deixa em m�dia 6G para o SO e configura 136G para o memlock, 
� este o valor de mem�ria que ser� utilizado pelo banco ou qualquer aplica��o dentro do servidor.

SHMMAX | maximum bytes in one shared memory segment | 4294967295
Limita a SGA dentro do memlock (60% da SGA), deve ser calculado em bytes, com base no exemplo acima seria de 88046829568 bytes.


HUGEPAGES
O valor da HugePages deve caber dentro do SHMMAX, o calculo abaixo de Huge Pages n�o tem a ver com os parametros acima

CALCULO HUGEPAGES
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[oracle@leotb-dbo1 ~]$ cat /proc/meminfo | grep ^Huge
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     2048 kB


SQL> show parameter memory

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
memory_max_target                    big integer 0
memory_target                        big integer 0


SQL> show parameter sga

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
sga_max_size                         big integer 12000M
sga_target                           big integer 12000M


SGA IN BYTES    /    ( Hugepagesize: 2048 kB *1024) = Huge Pages
12582912000     /                   2097152          = 6000


--> Configura��o de huge pages:

Servidor
/etc/sysctl.conf
vm.nr_hugepages = 16128
sysctl -p
ipcs -m

Calculando a quantidade de processos de acordo com valor de mem�ria do servidor:
Ex:

RAM: 142G
SGA: 12G
Media de Gb que o Servidor utiliza: 6G

Calculo: 142G - 12G - 6G = 124G
Tenho 124G livre para utilizar para os processos, em m�dia s�o 15Mb por sess�o, ent�o divido os 124G/15 = 8.200 Processos.

Calculando a mem�ria SGA de acordo com a quantidade de processos:

Media de Mb por processo = 15Mb * quantidade de processos que ira gerar emplo acima igual 8.200







