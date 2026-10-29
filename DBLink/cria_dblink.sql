SELECT
'create '||DECODE(U.NAME,'PUBLIC','public ')||'database link '||CHR(10)
||DECODE(U.NAME,'PUBLIC',Null, U.NAME||'.')|| L.NAME||chr(10)    
||'connect to ' || L.USERID || ' identified by '''
||L.PASSWORD||''' using ''' || L.host || ''''   
||chr(10)||';' TEXT
FROM  sys.link$       L,      
sys.user$       U
WHERE L.OWNER# = U.USER# ;

