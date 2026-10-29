SET LINES 400
SET PAGES 200
COL FILE_NAME FORMAT A70
COL MAP FORMAT A120
WITH files AS (
SELECT
file_id,
file_name,
blocks
FROM dba_data_files
WHERE tablespace_name = 'PSAPSR3'
),
ranges AS (
SELECT LEVEL AS pos
FROM dual
CONNECT BY LEVEL <= 100
),
file_ranges AS (
SELECT
f.file_id,
f.file_name,
f.blocks,
r.pos,
FLOOR((r.pos -1) * f.blocks / 100) AS start_block,
FLOOR(r.pos * f.blocks / 100) AS end_block
FROM files f
CROSS JOIN ranges r
),
usage_map AS (
SELECT
fr.file_id,
fr.file_name,
fr.pos,
CASE
WHEN EXISTS (
SELECT 1
FROM dba_extents e
WHERE e.file_id = fr.file_id
AND e.block_id <= fr.end_block
AND (e.block_id + e.blocks -1) >= fr.start_block
)
THEN '#'
ELSE '.'
END AS used_flag
FROM file_ranges fr
)
SELECT
file_id,
file_name,
LISTAGG(used_flag,'')WITHIN GROUP (ORDER BY pos) AS map
FROM usage_map
GROUP BY
file_id,
file_name
ORDER BY file_id;