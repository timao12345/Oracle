----------------------------------------------------------------------------------------
-- NLS_LANG DA BASE
----------------------------------------------------------------------------------------
select value 
from nls_database_parameters 
where parameter in ('NLS_LANGUAGE', 'NLS_TERRITORY','NLS_CHARACTERSET')
/

