-------------------------------------------------------------------------------------------
--			 Procedimento para adição de discos no ASM em servidores Linux 				 --
-------------------------------------------------------------------------------------------

-- Passo-a-Passo

-- Pré-requisito:

1. Verificar os discos já existentes no diskgroup alvo para verificar qual o último adicionado e seguir com a sequencia, por exemplo: DATA1, DATA2, DATA3... 

select a.group_number, a.disk_number, a.name, b.name as DISKGROUP, a.path, a.label, a.header_status, a.mount_status, a.mode_status, a.state, a.os_mb, a.total_mb, a.free_mb from v$asm_disk a, v$asm_diskgroup b where a.group_number=b.group_number order by a.group_number, a.disk_number;


2.	Rotular os novos discos com o ASMLib (create disk)
Depois de receber o nome do dispositivo do time Unix, entrar na conta "root" (pode ser via sudo também) e usar o comando "createdisk" */

$ oracleasm createdisk DISCO1 /dev/sdxx
-- Ou 
$ sudo /usr/sbin/oracleasm createdisk ...

O nome do disco varia:
    * /dev/mapper ou /dev/dm-xxx: Quando usa o multipath nativo do linux (existem casos onde o fornecedor especifica o nome, por exemplo, EMC) ;
    * /dev/sdxxxx: Se for ambiente VMWare, que entrega SCSI mesmo (o multipath fica na camada VM). */

______________________________________________________________________________________________________________________	
	
3.	Validação dos novos LUN´s:
Primeiro cria-se um diskgroup de teste com os discos novos:

# Na instance +ASM
$ sqlplus / as sysasm
sql> create diskgroup TESTE external redundancy DISK 'ORCL:','ORCL:DISCOx';
-- Obs: todos os discos novos devem ter o mesmo tamanho

E depois valida-se a integridade do disco com uma ação de I/O:
# Na instance RDBMS
SQL> alter database backup controlfile to '+TESTE';

Finalmente, podemos remover o diskgroup de teste para liberar os discos:
# Na instance ASM
SQL> drop diskgroup TESTE INCLUDING CONTENTS;
-- Validar a situação dos discos (coluna HEADER_STATUS deve ser "FORMER")
sql> select group_number, path, state, header_status from v$asm_disk where header_status <> 'MEMBER';

______________________________________________________________________________________________________________________

4.	Alocar LUN´s no DG alvo :
 
# Na instance RDBMS
-- Os mesmos discos alocados anteriormente 
SQL> alter diskgroup XXXXX add disk 'ORCL:DISCO','ORCL:DISCOx' rebalance power N;

Em atividades de movimentação de dados (usando drop disk e add disk na mesma mudança, por exemplo), sugere-se usar balance 0 na ação "drop disk" e balance > 0 na ação "add disk", pois não é necessário esperar necessariamente pelo sucesso da remoção dos discos ao adicionar novos. Se este tipo de atividade envolver discos de tamanhos diferentes, deve-se usar um valor conservador no balance (1 ou 2, por exemplo) a fim de evitar o erro ORA-015041.

______________________________________________________________________________________________________________________

5.	Acompanhar o rebalanceamento:

# Na instance ASM 
sql> select * from v$asm_operation;

Enquanto estiver executando, o valor de SOFAR irá diminuir e no final da operação, o resultado será vazio; nesse caso,validar a situação dos discos como "FORMER", como no exemplo do item (2).
 
