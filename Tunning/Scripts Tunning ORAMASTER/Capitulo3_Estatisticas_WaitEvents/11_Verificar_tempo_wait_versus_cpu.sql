--  VER TEMPO TOTAL DE WAITs E DE CPU DOS EVENTOS DOS ULTIMOS 60 SEGUNDOS (tambem da para ver ultimos 15s). 

alter session set container = cdb$root;

--  Aqui da para ver se BD gastou mais tempo com wait events x cpu e da p/ ver detalhes de onde foi gasto o tempo (executar no CDB):
SELECT  METRIC_NAME, VALUE, metric_unit
FROM    V$SYSMETRIC
WHERE   METRIC_NAME IN ('Database CPU Time Ratio','Database Wait Time Ratio') 
AND     INTSIZE_CSEC = (select max(INTSIZE_CSEC) from V$SYSMETRIC);


