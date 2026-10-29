set lin 131 pages 999


select distinct owner from dba_segments
	where lower(owner) not in (
'anonymous',
'bi',
'ctxsys',
'dbsnmp',
'dip',
'dmsys',
'exfsys',
'hr',
'ix',
'lbacsys',
'mddata',
'mdsys',
'mgmt_view',
'odm',
'odm_mtr',
'oe',
'olapsys',
'ordplugins',
'ordsys',
'outln',
'pm',
'scott',
'sh',
'si_informtn_schema',
'sys',
'sysman',
'system',
'tracesrv',
'mtssys',
'oaspublic',
'olapsys',
'websys',
'wk_proxy',
'wksys',
'wk_test',
'wmsys',
'xdb',
'OSE$HTTP$ADMIN',
'AURORA$JIS$UTILITY$',
'AURORA$ORB$UNAUTHENTICATED '
)
order by 1;

exit