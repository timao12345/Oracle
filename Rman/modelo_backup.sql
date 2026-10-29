run {
sql 'alter system archive log current';
allocate channel backup_disk1 type disk;
allocate channel backup_disk2 type disk;
backup tag 'LONDON' SPFILE format '/backup/rman/LONDON_BKP_SPFILE_t%t_s%s_p%p_T%T';
backup database plus archivelog tag 'LONDON' format '/backup/rman/LONDON_BKP_FULL_df_t%t_s%s_p%p_T%T';
backup current controlfile format '/backup/rman/LONDON_cf_%d_%t.bkp';
}



run {
allocate channel ch1 type disk format '/u06/backup/%d_%I_%p_%s';
backup database plus archivelog format '/u06/backup/BKP_FULL_df_t%t_s%s_p%p_T%T';
backup spfile format '/u06/backup/BKP_SPFILE_t%t_s%s_p%p_T%T';
backup current controlfile format '/u06/backup/cf_%d_%t.bkp';
}