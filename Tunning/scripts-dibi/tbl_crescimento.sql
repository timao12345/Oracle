set verify off
set feedback off
set lines 600 pages 1000
set head on

col "Create Time" format a20
col name format a30
col curr_size_mb format 99999999.9
col growth_per_day format 99999999.9
col projection_growth_30_days format 99999999.9
col projection_growth_90_days format 99999999.9
col projection_growth_180_days format 99999999.9
col projection_growth_365_days format 99999999.9

break on report
compute sum of curr_size_mb on report
compute sum of growth_per_day on report
compute sum of projection_growth_30_days on report
compute sum of projection_growth_90_days on report
compute sum of projection_growth_180_days on report
compute sum of projection_growth_365_days on report

PROMPT
PROMPT Metrica...: Projecao de Crescimento de Tablespaces (MB)
PROMPT Qt. Dias..: &1
PROMPT

WITH historico_uso AS (
    -- Captura o primeiro e o ultimo tamanho registrado no periodo informado
    SELECT 
        ts.tsname AS tablespace_name,
        MIN(su.tablespace_usedsize * dt.block_size) / 1024 / 1024 AS tamanho_inicial_mb,
        MAX(su.tablespace_usedsize * dt.block_size) / 1024 / 1024 AS tamanho_final_mb,
        MAX(TRUNC(TO_DATE(su.rtime, 'MM/DD/YYYY HH24:MI:SS'))) - MIN(TRUNC(TO_DATE(su.rtime, 'MM/DD/YYYY HH24:MI:SS'))) AS dias_reais
    FROM 
        dba_hist_tbspc_space_usage su
    JOIN 
        dba_hist_tablespace ts ON su.tablespace_id = ts.ts# AND su.dbid = ts.dbid
    JOIN 
        dba_tablespaces dt ON ts.tsname = dt.tablespace_name
    WHERE 
        TO_DATE(su.rtime, 'MM/DD/YYYY HH24:MI:SS') >= TRUNC(SYSDATE) - &1
    GROUP BY 
        ts.tsname
),
dados_atuais AS (
    -- Captura o tamanho alocado atual e a data de criacao via v$datafile
    SELECT 
        ts.name AS tablespace_name,
        TO_CHAR(MIN(df.creation_time), 'DD/MM/YYYY HH24:MI') AS criacao,
        SUM(df.bytes) / 1024 / 1024 AS tamanho_atual_mb
    FROM 
        v$datafile df 
    JOIN 
        v$tablespace ts ON df.ts# = ts.ts#
    WHERE 
        ts.name NOT LIKE '%UNDO%'
    GROUP BY 
        ts.name
),
calculo_taxa AS (
    SELECT 
        da.tablespace_name,
        da.criacao,
        da.tamanho_atual_mb,
        -- Calcula o crescimento diario real baseado no historico consultado
        CASE 
            WHEN NVL(h.dias_reais, 0) > 0 THEN (h.tamanho_final_mb - h.tamanho_inicial_mb) / h.dias_reais
            ELSE 0 
        END AS crescimento_diario_mb
    FROM 
        dados_atuais da
    LEFT JOIN 
        historico_uso h ON da.tablespace_name = h.tablespace_name
)
SELECT 
    criacao AS "Create Time",
    tablespace_name AS name,
    ROUND(tamanho_atual_mb, 1) AS curr_size_mb,
    ROUND(crescimento_diario_mb, 1) AS growth_per_day,
    ROUND(crescimento_diario_mb * 30, 1) AS projection_growth_30_days,
    ROUND(crescimento_diario_mb * 90, 1) AS projection_growth_90_days,
    ROUND(crescimento_diario_mb * 180, 1) AS projection_growth_180_days,
    ROUND(crescimento_diario_mb * 365, 1) AS projection_growth_365_days
FROM 
    calculo_taxa
ORDER BY 
    name;

set feedback on
