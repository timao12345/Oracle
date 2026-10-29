select a.*,
decode( a.class,
1, 'User',
2, 'Redo' ,
4, 'Enqueue',
8, 'Cache',
16, 'OS',
32, 'Real Application Clusters',
64, 'SQL',
128, 'Debug', 'Outros') descricao_classe
  from v$sysstat a
--where a.NAME like 'change write time'
Order by 4 Desc
