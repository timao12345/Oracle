set lines 150
select 'NLS_LANG='
|| ( select value from v$nls_parameters where parameter='NLS_LANGUAGE' )
|| '_'
|| ( select value from v$nls_parameters where parameter='NLS_TERRITORY' )
|| '.'
|| ( select value from v$nls_parameters where parameter='NLS_CHARACTERSET' )
language#
from dual;
