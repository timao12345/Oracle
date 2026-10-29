set serveroutput on size 1000000;

Prompt Informe o diretório para o teste de gravação quando solicitado:

declare
   arq       utl_file.file_type;
   diretorio varchar2(255) := '&diretorio';
begin
   arq := utl_file.fopen(diretorio,'teste.txt','w');
   utl_file.put_line(arq, 'DBA - Teste UTL_FILE como USUARIO: '||USER||' - Utilizando TNS: &_CONNECT_IDENTIFIER' );
   utl_file.fclose_all;

   dbms_output.put_line('-----------------------------------------------------');
   dbms_output.put_line('Arquivo teste.txt gravado no servidor com sucesso!');
   dbms_output.put_line('-----------------------------------------------------');
exception
   when others then
      dbms_output.put_line('-----------------------------------------------------');
      dbms_output.put_line('Erro ao tentar gravar arquivo no servidor!');
      dbms_output.put_line('Mensagem Oracle: ' || sqlerrm);
      dbms_output.put_line('-----------------------------------------------------');
end;
/


 