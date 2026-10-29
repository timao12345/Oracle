Gerar PFILE from V$SPPARAMETER:

set head off 
select sid||'.'||rtrim(ltrim(name))||' = '||rtrim(ltrim(VALUE)) from V$SPPARAMETER where isspecified='TRUE' order by name;
