*************************************************
-- Verificando gargalos de I/O, cpu e memoria atraves do utilitario vmstat
*************************************************

Utilizar utilitario "vmstat" (nao requer privilegios especiais):
     vmstat 5 10 
   
-- O primeiro valor (5) indica o delay (tempo de atualizacao)
-- O segundo valor (10) indica o contador (quantidade de repeticoes)

--------------------------------------------------------
DESCRICAO DAS PRINCIPAIS COLUNAS DE SAIDA DO VMSTAT
--------------------------------------------------------
*   r       Numero de processos aguardando execucao
*   b       Numero de processos em espera interrompiveis 
    swpd    Qtde. de memoria virtual em kb
    free    Qtde. de memoria livre em kb
    buff    Qtde. de buffer de memoria em kb
    cache   Qtde. de cache de memoria em kb
*   si      Qtde de memoria carregada (in) em swap (disk/second)
*   so      Qtde de memoria gravada (out) em swap (disk/second)
    bi      Blocos lidos por segundo 
    bo      Blocks escritos por segundo 
    us      Percentual de tempo de cpu usada por processos de usuario
    sy      Percentual de tempo de cpu usada pelo sistema
*   id      Percentual de tempo de cpu ociosa
*   wa      Tempo de cpu esperando por I/O
--------------------------------------------------------

--------------------------------------------------------
IDENTIFICANDO PROBLEMAS
--------------------------------------------------------
1- o valor de "r" nao deve ser maior que qtde de cpus ou nucleos do servidor
2- se "b" (processes sleeping) eh consistentemente maior que 0 entao nao ha CPU suficiente para executar todos as tarefas existentes
3- se "so"  (swap out) and "si" (swap in) sao consistententemente maior que 0 isso indica que ha pouca memoria
4- se "id" eh consistentemente igual a 0 entao nao ha CPU suficiente 
5- "wa" alto indica contencao de I/O no disco/storage

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache       si   so    bi    bo   in   cs   us sy id wa st
 1  0 5320768 7586096     40 42887732    1    1   605   111    0    0   14  5 81  0  0
 0  0 5320512 7558272     40 42887844   30    0    52    36 7109  6322   8  7 85  0  0
 0  0 5320512 7569356     40 42888360    3    0    42   252 9370  8100   9 12 79  0  0
 2  0 5320512 7565344     40 42888472   11    0    13   162 9499  9062  10 10 80  0  0
 7  0 5320256 7041360     40 42888572   27    0  2606    62 11323 8180  41 19 39  1  1
 8  0 5320000 6556700     40 42889148   79    0   506   130 11745 6037  61 17 22  0  1
 6  0 5319744 6494700     40 42889368   45    0    74    71 10872 5081  77 12 11  0  0
 4  0 5319744 6554072     40 42889540   43    0   454    53 10472 5287  70  9 20  0  0
 5  0 5319488 6433472     40 42890176   25    0    82    85 10369 6446  58 15 27  0  0
 5  0 5319488 6305928     40 42890364   31    0   114    79 9691  5736  53 10 37  0  0



[root@alvoradanew ~]# vmstat 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache      si   so    bi    bo     in  cs  us sy id wa st
13  0 407380 4479416 516980 40252416    0    0  4278   784      0    0 42  6 49  2  0
 9  0 407380 4649620 516980 40251560    0    0 41159 26594 39899 32002 51 18 29  2  0
17  2 407380 4953316 516980 40252508    0    0 17202  5924 39517 32758 58 18 22  2  0
 9  0 407380 4955332 516980 40252604    0    0 17056  8785 42904 34261 55 14 29  2  0
14  0 407380 4976216 516980 40252504    0    0 18549  3990 41963 35215 49 13 36  2  0
