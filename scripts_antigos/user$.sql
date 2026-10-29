select sqltext from
(
    select name, 'alter user '||name||' identified by values '''||password||''';' sqltext from sys.user$ where spare4 is null and password is not null
    union
    select name, 'alter user '||name||' identified by values '''||spare4||';'||password||''';' sqltext from sys.user$ where spare4 is not null and password is not null
) where name = 'TECH4B';