--TRACE ORACLE

--RODAR A QUERY ABAIXO PARA VERIFICAR O OSPID DO USU�RIO
column line format a79
set heading off
select 'ospid: ' || p.spid || ' # ''' ||s.sid||','||s.serial#||''' '||
  s.osuser || ' ' ||s.machine ||' '||s.username ||' '||s.program line
from v$session s , v$process p
where p.addr = s.paddr
and s.type = 'RMS';


--usu�rio em quest�o: 247488
ospid: 25990 # '69,55338' matera VMPAPPTB775 FINPAC JDBC Thin Client
ospid: 12945 # '190,40131' matera VMPAPPTB775 307267 JDBC Thin Client
ospid: 26388 # '245,43363' matera VMPAPPTB775 SDIMIO JDBC Thin Client
ospid: 5479 # '369,15801' matera VMPAPPTB775 308623 JDBC Thin Client
ospid: 5551 # '430,55497' matera VMPAPPTB775 308623 JDBC Thin Client
ospid: 3512 # '6,45497' matera VMPAPPTB775 247488 JDBC Thin Client
ospid: 30120 # '76,46946' matera VMPAPPTB775 SDBANCO JDBC Thin Client



--SETAR O OSPID NO ORADEBUG
oradebug setospid <spid>
oradebug setospid 3512

--RODAR OS COMANDOS ABAIXO
oradebug unlimit

oradebug event 10046 trace name context forever,level 12


--VERIFICAR ONDE O DUMP SER� GERADO
show parameter dump

background_core_dump                 string      partial
background_dump_dest                 string      /u02/app/oracle/diag/rdbms/mat
                                                 era/matera1/trace
core_dump_dest                       string      /u02/app/oracle/diag/rdbms/mat
                                                 era/matera1/cdump
max_dump_file_size                   string      unlimited
shadow_core_dump                     string      PARTIAL
--OP��O ABAIXO � ONDE SER� GERADO TRACE
user_dump_dest                       string      /u02/app/oracle/diag/rdbms/matera/matera1/trace


--LOCALIZAR O ARQUIVO GERADO PARA O TRACE
--no diret�rio do dump: /u02/app/oracle/diag/rdbms/matera/matera1/trace> 
ls -ltr *3512*

tail -f matera1_ora_3512.trc


--AP�S T�RMINO DO PROCEDIMENTO, RODAR O COMANDO ABAIXO PARA FINALIZAR O PROCEDIMENTO
tkprof arquivo.trc arquivo.txt

tkprof matera1_ora_3512.trc matera1_ora_247488.txt