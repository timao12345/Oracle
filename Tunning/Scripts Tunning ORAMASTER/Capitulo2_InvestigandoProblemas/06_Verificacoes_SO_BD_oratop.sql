*** ORATOP *** utilitario free para monitoramento:
- Funciona a partir do 11GR2 (11.2.0.3)
- Somente SOs Unix e Linux


-- Execute:
$   oratop -f -i 1 / as sysdba

-- ou para informacoes em tempo real (nao cumulativa) e com refresh de 1s:
$   oratop -f -d -i 1 / as sysdba


Parametros:
    -f: formato detalhado
    -d: eventos de espera em tempo real
    -i: frequencia de atualizacao em segundos


ID        [c,N]: inst_id (instance id)    
%CPU      [m,N]: host cpu busy %(busy/busy+idle). (red if > 90%)
LOAD      [m,N]: current os load. (red if > 2*#cpu & high cpu)   
%DCU      [m,N]: db cpu otusef as %host cpu. (red if > 99% & high AAS)    
AAS       [s,N]: Average Active Sessions. (red if > #cpu)    
ASC       [c,N]: active Sessions on CPU    
ASI       [c,N]: active Sessions waiting on user I/O    
ASW       [c,N]: active Sessions Waiting, non-ASI (red if > ASC+ASI)    
ASP       [m,N]: active parallel sessions (F/G)    
AST       [c,N]: Active user Sessions Total (ASC+ASI+ASW)    
UST       [c,N]: user Sessions Total (ACT/INA)    
MBPS      [m,N]: i/o megabytes per second (throughput)    
IOPS      [m,N]: i/o requests per second    
IORL      [m,T]: avg synchronous single-block read latency. (red > 20ms)    
LOGR      [s,N]: logical reads per sec    
PHYR      [s,N]: physical reads per sec 
PHYW      [s,N]: physical writes per sec    
%FR       [s,N]: shared pool free %    
PGA       [s,N]: total pga allocated    
TEMP      [s,N]: temp space used    
UTPS      [s,N]: user transactions per sec    
UCPS    [c,m,N]: user calls per sec    
SSRT    [c,m,T]: sql service response time (T/call)    
DCTR      [m,N]: database cpu time ratio    
DWTR      [m,N]: database wait time ratio. (red if > 50 & high ASW)    
%DBT      [s,N]: instance %Database Time (e.g. non-rac shows 100%)


ATENÇÃO: Com o oratop sendo executado pressione a tecla "x" e forneça o SQL_ID de um SQL desejado para ver o seu plano de execução