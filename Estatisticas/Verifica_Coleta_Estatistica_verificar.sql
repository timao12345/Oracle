SELECT
   S.Owner As "Schema"
  ,S.Table_Name As "Objeto"
  ,S.Object_Type As "Tipo do Objeto"
  ,S.Num_Rows As "Qtd. de Linhas"
  ,To_Char(S.Last_Analyzed, 'yyyy-MM-dd HH24:mm:ss') As "Ultima Coleta"
FROM
  sys.dba_tab_statistics S
WHERE
  S.Owner ='BILD' and s.Last_Analyzed < sysdate -30
ORDER BY
  S.Last_Analyzed desc;

  --S.Owner Not In('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')

SELECT
  S.Owner As "Schema",
  count(S.Table_Name) As "Qtd Objeto"
FROM
sys.dba_tab_statistics S
WHERE
S.Owner Not In('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
group by owner;