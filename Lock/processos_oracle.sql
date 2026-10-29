select p.spid "Thread ID",
b.name "Background Process",
s.username "User Name",
s.osuser "OS User",
s.status "STATUS",
s.sid "Session ID",
s.serial# "Serial No.",
s.program "OS Program"
  from v$process p, v$bgprocess b, v$session s
  where s.paddr = p.addr and b.paddr(+) = p.addr;


-- Uso geral de processos (User vs Background)
SELECT
    DECODE(s.username, NULL, 'BACKGROUND', 'USER') AS tipo,
    COUNT(*) AS qtd
FROM v$process p
LEFT JOIN v$session s ON p.addr = s.paddr
GROUP BY DECODE(s.username, NULL, 'BACKGROUND', 'USER');

-- Ranking dos processos de background
SELECT
    p.program,
    COUNT(*) AS total
FROM v$process p
LEFT JOIN v$session s ON p.addr = s.paddr
WHERE s.username IS NULL
GROUP BY p.program
ORDER BY total DESC;

-- Detalhes de cada background
SELECT
    p.spid,
    p.program,
    s.type,
    s.status
FROM v$process p
LEFT JOIN v$session s ON p.addr = s.paddr
WHERE s.username IS NULL
ORDER BY p.program;