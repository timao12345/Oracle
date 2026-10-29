-- V$SYSSTAT: Contem estatisticas globais de varias partes do BD, incluindo rollback, I/O fisico e logico e outros. 
--            Pode ser usada p/ calcular hit ratio de areas de memoria, tais como a buffer cache.
-- V$SYSMETRIC: Contem metricas de sistema capturadas em 2 intervalos de tempo (INTSIZE_CSEC): ultimos 15 segundos ou ultimos 60 segundos
-- V$SYSMETRIC_SUMMARY: media ultima hora (ultimo snapshot)
-- DBA_HIST_SYSMETRIC_SUMMARY: resumo da ultima semana --> depende de licenciamento do AWR

-- ver estatisticas de sistema acumuladas (desde o startup), tais como: rollback, I/O fisico e logico, ou pode ser usada p/ calcular hit ratio de areas de memoria, tais como a buffer cache
SELECT      S.name, S.value --		 deve-se consultar MOS para verificar medida (coluna value)   
FROM        v$sysstat s
order by    value desc;

-- mude para o cdb para ver resultados das V$SYSMETRIC*:
alter session set container = cdb$root;

-- ver media da ultima hora de varias metricas do BD  (ESSA EH bem INTERESSANTE MANTER UM BASELINE)
-- Exemplos: Total PGA Allocated, Physical Read Bytes Per Sec, Redo Generated Per Sec, Network Traffic Volume Per Sec, PGA Cache Hit %, Redo Allocation Hit Ratio 
SELECT    metric_name, average, metric_unit
FROM      V$SYSMETRIC_SUMMARY
ORDER BY  2 DESC;