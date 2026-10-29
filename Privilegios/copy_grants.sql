declare

     comando varchar2(200);
   
begin

      for usr in (select username from dba_users where created >= '01/01/2007' ) loop
	  
	        -- tabelas e diretorios
	        for priv in (select privilege, grantee, owner, table_name from dba_tab_privs where grantee=usr.username) loop
						
			   comando := 'grant ' || priv.privilege || ' on ' || priv.owner || '.' || priv.table_name || ' to ' || priv.grantee || ';' ;
			   dbms_output.put_line(comando) ;
				
			end loop;
	  
	        -- roles 
	        for priv in (select granted_role, grantee from dba_role_privs where grantee=usr.username) loop
						
			   comando := 'grant ' || priv.granted_role || ' to ' ||  priv.grantee || ';' ;
			   dbms_output.put_line(comando) ;
				
			end loop;
			
			-- privilegios de sistema
			 for priv in (select grantee, privilege from dba_sys_privs where grantee=usr.username) loop
						
			   comando := 'grant ' || priv.privilege || ' to ' ||  priv.grantee || ';' ;
			   dbms_output.put_line(comando) ;
				
			end loop;
			
	  
	  end loop;


end;