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
for r1 in (select a.table_name, segment_name 
	from dba_segments b, dba_indexes a
	where b.owner='TRKOWNER'
	AND b.segment_type ='INDEX'
	and b.segment_name=a.index_name
	and b.owner=a.owner
	AND a.table_name IN('CPBACB',
	'CPBALN',
	'CPBCBA',
	'CPBCLI',
	'CPBCON',
	'CPBCTL',
	'CPBDEV',
	'CPBFCB',
	'CPBFLN',
	'CPBINV',
	'CPBLOG',
	'CPBOPM',
	'CPBPCB',
	'CPBPLN',
	'CPBPRO',
	'CPBRI',
	'CPBTEO',
	'CPBTRA',
	'CPBVTA',
	'HUBGRF',
	'PLOG',
	'SYN1CB',
	'SYN1LN')
	order by 1,2) loop
dbms_space.space_usage('TRKOWNER',r1.segment_name, 
                        'INDEX', 
                        unf, unfb, 
                        fs1, fs1b, 
                        fs2, fs2b, 
                        fs3, fs3b, 
                        fs4, fs4b, 
                        full, fullb);
        if  fs2b >1 or fs3b>1 or fs4b>1 then
total_frag:=round((fs2b+fs3b+fs4b)/1024/1024,2);
total_schema:=total_schema+total_frag;
dbms_output.put_line(r1.segment_name);
dbms_output.put_line(total_frag);
		end if;
		end loop;
		dbms_output.put_line('Fragmentação total MB= '||total_schema);
end;
/