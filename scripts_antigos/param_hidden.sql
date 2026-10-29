-- http://www.adp-gmbh.ch/ora/misc/view_hidden_parameters.html
-- http://oracleinaction.com/undocumented-params-11g/

-- Check hidden all parameter in oracle and description and value
UNDEF PARAMETER
COL KSPPSTVL FOR A20
col KSPPINM for a40
col KSPPDESC for a60

select 
  ksppinm,
  ksppstvl,
  KSPPDESC
from 
  x$ksppi a, 
  x$ksppsv b 
where 
  a.indx=b.indx and 
  substr(ksppinm,1,1) = '_'
  and KSPPINM='&PARAMETER';

