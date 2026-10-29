-- configurando db_file_multiblock_read_count no nivel da sessao:
alter session set db_file_multiblock_read_count = 8;

-- para voltar valor default
alter system reset db_file_multiblock_read_count;

-- Obs.: O valor default configura auto tuning deste parametro (recomendado a partir do 10gR2)
