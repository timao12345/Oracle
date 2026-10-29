-- NUMERO DE CONEXOES

select count(*) as conexoes from v$session  where username is not null
and username not in('WMSYS', 'EXFSYS', 'SYSTEM', 'SYSMAN', 'DBSNMP', 'SYS', 'OUTLN', 'MDSYS', 'XDB', 'TSMSYS', 'ORDSYS');
	