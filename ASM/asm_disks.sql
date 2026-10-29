set echo off
rem ==========================================================================
rem ARQUIVO.....: asm_disks.sql
rem FINALIDADE..: Informacoes sobre os ASM Disks
rem ==========================================================================
rem PARAMETROS
rem   Nenhum
rem ==========================================================================
rem MODIFICACOES
rem   2009-04-17  danilo.gimenez   Criacao do script
rem ==========================================================================
set feedback off linesize 168 pagesize 10000

break on asm_dg_name skip 1 on report
column ASM_DG_NAME      format a20
column ASM_DISK_NAME    format a30
column DEVICE           format a35
column HEADER_STATUS    format a12
column STATE            format a10
column TOTAL_MB         format 99g999g999
column FREE_MB          format 99g999g999
column USED_MB          format 99g999g999
column PCT_FREE         format 990d0
column USED_GB          format 999g999
column FREE_GB          format 999g999
column TOTAL_GB         format 999g999

select asm_dg_name
     , redundancy
     , device
     , voting_files
     , decode(grouping(header_status),1,'Total ==>',header_status)          as HEADER_STATUS
     , decode(grouping(state), 1, to_char(count(*))||' discos', state)      as STATE
     , sum(TOTAL_MB)                                                        as TOTAL_MB
     , sum(USED_MB)                                                         as USED_MB
     , sum(FREE_MB)                                                         as FREE_MB
     , decode(grouping(header_status)
             ,1,round(100*sum(FREE_MB)/sum(TOTAL_MB),1)
             ,decode(header_status,'CANDIDATE', to_number(null), PCT_FREE)) as PCT_FREE
     , asm_disk_name
  from ( select distinct
                d.path                                              as device
---           , decode(group_number,0, 'N/A', g.name)               as asm_dg_name
              , g.name                                              as asm_dg_name
              , d.name                                              as asm_disk_name
              , g.voting_files
              , d.header_status
              , d.state
              , g.type as redundancy
              , d.os_mb /*OS_MB=ASM 11g; em ASM 10g=d.total_mb */   as total_mb
              , decode(group_number
                      ,0,to_number(null)
                      ,d.total_mb-d.free_mb)                        as used_mb
              , decode(group_number,0,d.os_mb,d.free_mb)            as free_mb
              , decode(d.total_mb
                      ,0,to_number(null)
                      ,round(100*d.free_mb/d.total_mb,1))           as pct_free
          from v$asm_disk d
          left outer join v$asm_diskgroup g using (group_number) )
-- where device IS NOT NULL
group by rollup (asm_dg_name, (redundancy, device, voting_files, header_status, state, pct_free, asm_disk_name))
order by asm_dg_name, device
/
