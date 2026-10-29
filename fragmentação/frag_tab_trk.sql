set serveroutput on
undef Nam

declare 
 unf number; 
 unfb number; 
 fs1 number; 
 fs1b number; 
 fs2 number; 
 fs2b number; 
 fs3 number; 
 fs3b number; 
 fs4 number; 
 fs4b number; 
 full number; 
 fullb number;
 total_frag number;
 total_schema number;
 begin 
 total_schema:=0;
for r1 in (select segment_name 
	from dba_segments
	where owner='KIPREV'
	AND segment_type ='TABLE'
	AND SEGMENT_NAME ='FO_MONITOR_DETA_HIST'
	order by 1) loop
dbms_space.space_usage('KIPREV',r1.segment_name, 
                        'TABLE', 
                        unf, unfb, 
                        fs1, fs1b, 
                        fs2, fs2b, 
                        fs3, fs3b, 
                        fs4, fs4b, 
                        full, fullb);
        if  fs2b >1 or fs3b>1 or fs4b>1 then
total_frag:=round((fs2b+fs3b+fs4b)/1024/1024,2);
total_schema:=total_schema+total_frag;
dbms_output.put_line('Objeto = '||r1.segment_name);
dbms_output.put_line('Fragmentacao Objeto = '||total_frag);
		end if;
		end loop;
		dbms_output.put_line('Fragmentacao total MB= '||total_schema);
end;
/