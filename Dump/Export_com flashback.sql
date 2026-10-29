Export com flashback, gera dados consistentes					
					
					Para diretorio com diskgroup 
										
										
										
										
					 expdp \"/as sysdba\" 
					 job_name=BK_PRE_DIARIA \
					 directory=DATA1 \ 
					 dumpfile=BK_PRE_DIARIA_$TIMESTAMP_%U \ 
					 logfile=PATH_LOGS:BK_PRE_DIARIA_$TIMESTAMP.log \ 
					 schemas=RCVRY \
                     parallel=20 \compression=all \
                     flashback_time=systimestamp \
                     status=60

					 
					 Para diretorio com file system
				nohup	 expdp \"/as sysdba\" job_name=TABELAS_C452847 \
                     directory=dp_C452847 \
                     dumpfile=TABELAS_C452847_$TIMESTAMP_%U \
                     logfile=TABELAS_C452847_$TIMESTAMP.log \
                     tables=ENPGIA.MOVIMENTACAO_ATIVO_FISICO,ENPGIA.ATIVO_FISICO,ENPGIA.DEMANDA_ITEM_ATIVO \
                     parallel=2 \
                     compression=all \
                     flashback_time=systimestamp \
                     status=60 &

					 Para diretorio com file system sem compress e sem paralelismo
					 
					 nohup	 expdp \"/as sysdba\" job_name=TABELAS_C452847 \
                     directory=dp_C452847 \
                     dumpfile=TABELAS_C452847_$TIMESTAMP_%U \
                     logfile=TABELAS_C452847_$TIMESTAMP.log \
                     tables=ENPGIA.MOVIMENTACAO_ATIVO_FISICO,ENPGIA.ATIVO_FISICO,ENPGIA.DEMANDA_ITEM_ATIVO \
                     flashback_time=systimestamp \
                     status=60 &

					 



					 