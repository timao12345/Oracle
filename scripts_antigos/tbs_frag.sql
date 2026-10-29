UNDEFINE ATBS;

ACCEPT TBS   CHAR PROMPT 'Informa a TBS de consulta......:  '

alter tablespace &&TBS coalesce;

select rownum linha, mb
  from (select round(bytes / 1024 / 1024) Mb
          from dba_free_space
         where tablespace_name = '&&TBS'
         order by 1 desc)
 where rownum <= 20;