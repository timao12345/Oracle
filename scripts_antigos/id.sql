define sql_prompt=idle
column user_sid new_value sql_prompt
select lower(user) || '@' || 
'&_CONNECT_IDENTIFIER' user_sid from dual;
set sqlprompt '&sql_prompt> '