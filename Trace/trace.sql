declare
   nSid    number ;
   nSerial number ;
begin

   nSid := &1 ;
   select serial# into nSerial from v$session where sid= nSid ;

   sys.dbms_system.set_bool_param_in_session(sid=>  nSid,  serial# => nSerial, parnam  => 'timed_statistics', bval    => true);
   sys.dbms_system.set_int_param_in_session(sid=>  nSid, serial# => nSerial, parnam=>'max_dump_file_size',intval=> 2147483647);
   sys.dbms_system.set_bool_param_in_session( nSid, nSerial,'sql_trace',true);
   sys.dbms_support.start_trace_in_session( nSid, nSerial, waits=>true, binds=>true);
 --    dbms_support.stop_trace_in_session(sid=> nSid, serial  => nSerial);
end;
/


--============== PROC MARCIO ======================================

select username, program, terminal, sid, serial#
        , (select spid from v$process where addr=v$session.paddr) 
  from v$session
where username = 'RMS'
/


--3 - Habilitar o trace para 1 sess�o
--Com base nos dados obtidos via item 2, executar:

execute dbms_system.set_sql_trace_in_session( &sid, &serial, true );
commit;

--ou para varios... selecionando por sess�o para gerar os comandos...

select 'execute dbms_system.set_sql_trace_in_session( ' || sid || ',' || serial# || ', true );'
from v$session where sid in ( xxx, xxx, xxx );


--4 - Desativar o trace 

--mesmo comando do item 3, trocando o "true" por "false", o ideal � solicitar para o cliente desconectar e automaticamente ser� gerado o trace, sem necessidade de "desligar" o mesmo. Lembrando que o Trace morre junto com a sess�o.


--5 - Encontrando o arquivo gerado

--a) Identificar onde � gerando o arquivo
show parameter user_dump_dest

--b) Identificar o arquivo
--Na querie do item 2, tem a coluna SPID, o arquivo ser� gerado contendo em seu nome o n�mero desta coluna, por exemplo "ora_ebp_123112.trc"

execute dbms_system.set_sql_trace_in_session('9013','34325',true);
execute dbms_system.set_sql_trace_in_session('59','46334',true);

--inicio
EXEC SYS.DBMS_SUPPORT.START_TRACE_IN_SESSION( &sid , 0, waits=>TRUE, binds=>TRUE );

-- termino
exec sys.DBMS_SUPPORT.STOP_TRACE_IN_SESSION(&sid,null);