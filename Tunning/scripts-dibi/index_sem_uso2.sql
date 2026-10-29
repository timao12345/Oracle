-- Verifica se um indice está sendo usado por alguma query

-- Alterar para modo de monitoring
alter index teste_index monitoring usage;

-- Consultar o indice pelo nome
select index_name, used, monitoring 
from v$object_usage
where index_name = 'TESTE_INDEX';

-- desabilitar modo de monitoring
alter index teste_index nomonitoring usage;