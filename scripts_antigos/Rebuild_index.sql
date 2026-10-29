-- Rebuild index
Select 'alter index '||owner||'.'||index_name||' rebuild ONLINE;' from dba_indexes d where D.TABLE_NAME ='PROVIDE_TABLE_NAME' and D.OWNER='PROVIDE_OWNER';

-- Rebuild Partition index
Select 'alter index '||index_owner||'.'||index_name||' rebuild partition '||partition_name||' ONLINE;' from dba_ind_partitions where INDEX_NAME='PROVIDE_INDEX_NAME';


-- Rebuild Sub Partition index
Select 'alter index '||index_owner||'.'||index_name||' rebuild subpartition '||subpartition_name||' ONLINE;' from dba_ind_subpartitions where INDEX_NAME='PROVIDE_INDEX_NAME';
