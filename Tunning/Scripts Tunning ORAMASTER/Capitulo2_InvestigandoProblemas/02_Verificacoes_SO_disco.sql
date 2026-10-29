*************************************************
-- Ver carga de I/O por dispositivo (device) atraves do utilitario iostat
*************************************************

Utilizar utilitario iostat (nao requer privilegios especiais):
    > iostat -m 5 10

-- O primeiro valor (5) indica o delay (tempo de atualizacao)
-- O segundo valor (10) indica o contador (quantidade de repeticoes) e é opcional. Se nao for fornecido fica monitorando ininterruptamente.
    
Outros exemplos:    
    > iostat -m 1               ---> executar continuamente com delay de 1s
    > iostat -xm 2              ---> mostra estatisticas extendidas (x) em MB com delay de 2s
    
    
--------------------------------------------------------
DESCRICAO DAS PRINCIPAIS COLUNAS DE SAIDA DO IOSTAT
--------------------------------------------------------
device          Nome do dispositivo (disco ou parte de um disco)
tps             Qtde. de operacoes de I/O por segundo
MB_read/s       MB lidos por segundo
MB_wrtn/s       MB escritos por segundo
MB_read         MB total lidos
MB_wrtn         MB total escritos


-- Ver mapeamento de device p/ LV
    sudo lvdisplay|awk  '/LV Name/{n=$3} /Block device/{d=$3; sub(".*:","dm-",d); print d,n;}'

-- Ver mapeamento de LV X particoes
    df -h -P


--------------------------------------------------------
IDENTIFICANDO PROBLEMAS
--------------------------------------------------------
-- qtde leitura deve ser bem maior que escrita 
-- "%iowait" (avg-cpu) alto indica gargalo na escrita

EXEMPLO:
    estatisticas tps com iostat : tmp: 170.65,  dados: 297.06,  logs: 623.77, indices: 11.85, ctrlfile: 2.69, undotemp: 0.89
	

Obs.: iostat depende de instalacao do pacote sysstat e configuracoes especiais no arquivo /etc/sudoers (!requiretty, visiblepw e oracle(ALL))