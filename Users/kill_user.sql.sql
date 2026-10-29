begin
  for cur in (select sid, serial# from v$session a where a.username like '%&1%' ) loop
  
      execute immediate 'alter system kill session ' ||'''' || cur.sid || ', ' || cur.serial# || '''' ; 
  
  end loop ;
end ;