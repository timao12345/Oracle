-- verifica estatistica de tabelas.
SELECT
   S.Owner As "Schema"
  ,S.Table_Name As "Objeto"
  ,S.Object_Type As "Tipo do Objeto"
  ,S.Num_Rows As "Qtd. de Linhas"
  ,To_Char(S.Last_Analyzed, 'yyyy-MM-dd HH24:mm:ss') As "Ultima Coleta"
FROM
  sys.dba_tab_statistics S
WHERE
  S.Owner Not In('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
ORDER BY
  S.Last_Analyzed;
  
-- verifica estatistica de indice.
SELECT
   S.Owner As "Schema"
  ,S.Table_Name As "Objeto"
  ,S.Object_Type As "Tipo do Objeto"
  ,S.Num_Rows As "Qtd. de Linhas"
  ,To_Char(S.Last_Analyzed, 'yyyy-MM-dd HH24:mm:ss') As "Ultima Coleta"
FROM
  sys.dba_ind_statistics S
WHERE
  S.Owner Not In('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
ORDER BY
  S.Last_Analyzed;