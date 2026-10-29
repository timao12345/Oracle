-- Verifica tamanho do datafile SQL Server
SELECT name,
	state_desc, 
	size/128.0 Total_Mb,
	size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS Espaço_utilizado,
	cast(format((((size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0) / (size/128.0))*100),'#.00')as varchar)+'%' as Percentual_utilziado
FROM sys.database_files;