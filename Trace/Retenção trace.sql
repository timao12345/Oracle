-- procedimentp para configurar retenção do trace files (trc e trm)

/*##### Entrando no ADRCI

esse é o passo mais difícil então muita atenção digite.

adrci

pronto agora que você entrou no shell do adrci e deve estar rindo vamos ao trabalho */

 
 
--##### Mostrar configuração atual

adrci> show homes

ADR Homes:

diag/rdbms/<<Diretorio>>/<<Diretorio>>

diag/tnslsnr/<<BANCO>>/listener


--##### Definindo a configuração a ser trabalhada

adrci> set homepath diag/tnslsnr/<<BANCO>>/listener

 

--##### Confirmando as configuração vigentes.

adrci> show control

 

ADR Home = /u01/app/grid/diag/crs/node2/crs:

*************************************************************************

ADRID                SHORTP_POLICY        LONGP_POLICY         LAST_MOD_TIME                            LAST_AUTOPRG_TIME                        LAST_MANUPRG_TIME                        ADRDIR_VERSION       ADRSCHM_VERSION      ADRSCHMV_SUMMARY     ADRALERT_VERSION     CREATE_TIME
-------------------- -------------------- -------------------- ---------------------------------------- ---------------------------------------- ---------------------------------------- -------------------- -------------------- -------------------- -------------------- ----------------------------------------
406854955            720                  8760                 2021-09-14 21:51:57.414111 -03:00                                                 2021-10-29 11:51:20.738377 -03:00        1                    2                    107                  1                    2021-09-14 21:51:57.414111 -03:00

 
 
--SHORTP_POLICY - Para retenção dos trace files, core dump files
--LONGP_POLICY - Para retenção dos alert logs, incidents dumps, incidents information
 

--##### Vamos mudar 

SHORTP_POLICY de 720 horas => 30 dias

LONGP_POLICY  de 8760      => 365 dias

--##### Para 

SHORTP_POLICY de 168 horas => 7 dias

LONGP_POLICY  de 360 horas => 15 dias


adrci> set control (shortp_policy = 168);

adrci> set control (longp_policy = 8760);

adrci> show control;

 
--Agora se quiser excluir todos os arquivos de rastreamento com mais de 21600 minutos (15 dias) na instancia atual. 

--Tipo agora, urgente, então manda ver. 

adrci> purge -age  21600 -type TRACE;
adrci> PURGE -age 43200 -type ALERT;