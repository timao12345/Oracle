create or replace procedure sendmail (  
      from_name     varchar2                     :='lucas.souza@caixavidaeprevidencia.com.br'
      ,to_name       varchar2                    :='lucas.souza@caixavidaeprevidencia.com.br'
      ,subject       varchar2                    :='Status ORACLE ExaC'
      ,message       varchar2                    :='Status ORACLE ExaC'
      ,max_size      number   default 9999999999
      ,filename1  in varchar2                    :='/home/oracle/dba/health_check.html'
      ,debug         number   default 0 ) 

is

  v_smtp_server                          varchar2(30)                              :='10.100.8.188';
  v_smtp_server_port                     number                                    := 25;
  v_directory_name                       varchar2(100);
  v_file_name                            varchar2(100);
  v_line                                 varchar2(1000); 
  crlf                                   varchar2(2)                               := chr(13) || 
  chr(10);
  mesg                                   varchar2(32767);

  conn                                   UTL_SMTP.CONNECTION;                                        

  type varchar2_table  is table of       varchar2(200) index by binary_integer;
  file_array                             varchar2_table;
  
  i                                      binary_integer;
  v_file_handle                          utl_file.file_type;
  v_slash_pos                            number;
  mesg_len                               number;
  mesg_too_long                          exception;
  invalid_path                           exception;
  mesg_length_exceeded                   boolean                                   := false;


begin

   -- Carregando os arquivos dentro do ARRAY
   -- --------------------------------------- 
   file_array(1) := filename1;

   -- Abrindo Conexão SMTP e HTTP
   -- ----------------------------
   conn  := utl_smtp.open_connection( v_smtp_server, v_smtp_server_port );

   -- Comunicando SMTP
   -- ------------------
   utl_smtp.helo( conn, v_smtp_server );
   utl_smtp.mail( conn, from_name );
   utl_smtp.rcpt( conn, to_name );
   utl_smtp.open_data ( conn );

   -- Criando Cabeça do E-mail
   -- -----------------------------------
    mesg:= 'Date:'   || TO_CHAR( SYSDATE, 'dd Mon yy hh24:mi:ss' )                     || crlf ||
        message                                                                        || crlf ;

   mesg_len := length(mesg);

   if mesg_len> max_size then
      mesg_length_exceeded := true;
   end if;

   utl_smtp.write_data ( conn, mesg );

   -- Anexando Arquivos
   -- ------------------
   for i in  1..3 loop

       -- Sair se ultrapassar o tamanho de mensagem
       -- -----------------------------------------
       exit when mesg_length_exceeded;          

       if file_array(i) is not null then

          begin
              
             -- Localiza a "/" ou "\" no caminho
             -- ---------------------------------
             v_slash_pos := instr(file_array(i), '/', -1 );

             if v_slash_pos = 0 then
                v_slash_pos := instr(file_array(i), '\', -1 ); -- Valor Retornado = 3

             end if;

             -- Separa o arquivo do diretório
             -- ------------------------------
             v_directory_name := substr(file_array(i), 1, v_slash_pos - 1);
             v_file_name      := substr(file_array(i), v_slash_pos + 1 );

             -- Abrir Arquivo
             -- --------------
             v_file_handle := utl_file.fopen(v_directory_name,v_file_name,'w');

             -- Gera a linha MIME boundary
             -- --------------------------
             mesg := crlf || '--DMW.Boundary.605592468' || crlf ||
             'Content-Type:              application/octet-stream; name=' ||v_file_name  || crlf ||
             'Content-Disposition:       attachment;               filename=' ||v_file_name  || crlf ||
             'Content-Transfer-Encoding: 7bit'                                              || crlf || 
              crlf ;

             mesg_len := mesg_len + length(mesg);
             utl_smtp.write_data ( conn, mesg );

             -- Anexa o conteúdo do arquivo ao corpo da mensagem
             -- ------------------------------------------------

             loop
   
                 utl_file.get_line(v_file_handle, v_line);
   
                 if mesg_len + length(v_line)> max_size then

                    mesg := '*** truncado ***' || crlf;

                    utl_smtp.write_data ( conn, mesg );

                    mesg_length_exceeded := true;

                    raise mesg_too_long;

                 end if;

                 mesg := v_line || crlf;

                 utl_smtp.write_data ( conn, mesg );
   
                 mesg_len := mesg_len + length(mesg);

             end loop;

          exception

             when utl_file.invalid_path then
                 if debug> 0 then
                    dbms_output.put_line('Erro anexando arquivo ! '|| file_array(i));
                 end if;              

             -- Todas EXCEPTIONS ignoradas
             when others then null;

          end;

          mesg := crlf;

          utl_smtp.write_data ( conn, mesg );

          -- Fecha Arquivo
          -- --------------
          utl_file.fclose(v_file_handle);

        end if;

   end loop;

   -- Fechando a Cabeça do E-mail
   -- ----------------------------
   mesg := crlf || '--DMW.Boundary.605592468--' || crlf;
   utl_smtp.write_data ( conn, mesg );

   -- Fechando conexão SMTP
   -- -----------------------
   utl_smtp.close_data( conn );
   utl_smtp.quit( conn );

end;