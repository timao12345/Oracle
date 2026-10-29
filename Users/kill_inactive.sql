begin
  for cur in (select sid, serial# from v$session a where a.STATUS = 'INACTIVE' ) loop
  
      execute immediate 'alter system kill session ' ||'''' || cur.sid || ', ' || cur.serial# || '''' || ' immediate' ; 
  
  end loop ;
end ;