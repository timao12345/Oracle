mount.cifs //10.101.92.110/samba /mnt/samba -o username=teste, password=Sky#Sky#12345, sec=ntlm,nosetuids,noperm,dir_mode=777

mount.cifs //10.101.92.110/shares /mnt/samba -o username=teste, password=Sky#Sky#12345, rw,file_mode=0777,dir_mode=0777
mount.cifs //10.101.92.110/shares  /mnt/server-mysql -o username=teste, password=Sky#Sky#12345, rw,file_mode=0777,dir_mode=0777


mount.cifs //10.101.92.110/shares/ADM_FIN/TI/SISTEMAS/SISTEMA_PDV_SOCIN/HOMOLOGACAO/BACKUP_DUMP_MSYQL /mnt/server-mysql -o username=skydb, password=SkyOne#19922#, rw,file_mode=0777,dir_mode=0777

mount.cifs //10.101.92.110/shares /mnt/server-mysql -o username=skydb, password=SkyOne#19922#, rw,file_mode=0777,dir_mode=0777


mount.cifs //10.101.92.110/shares /mnt/server-mysql -o user=iis,dom=atak,password=iis@atak!2020,rw,file_mode=0777,dir_mode=0777


skydb
SkyOne#19922#


opc
K!cjC@5Et[]mNas1g6ynL,H!z


-- Caso a senha contenha caractere especial colocar a senha manuamente da seguinte forma com usuario e dominio
mount.cifs //10.101.92.110/shares /mnt/server-mysql -o user=iis,dom=atak, sec=ntlm,nosetuids,noperm,dir_mode=777

-- Caso a senha contenha caractere especial colocar a senha manuamente da seguinte forma com usuario e dominio
mount -v -t cifs //10.101.92.110/Shares /mnt/server-mysql -o dom=atak,user=iis,rw,file_mode=0777,dir_mode=0777
iis@atak!2020

mount -v -t cifs //10.101.92.110/shares /mnt/server-mysql -o dom=local,user=skydb,rw,file_mode=0777,dir_mode=0777




mount -v -t cifs //10.100.8.132/Netbackup/ /mnt/  -o dom=local,ro,file_mode=0777,dir_mode=0777

mount -t cifs //10.100.8.132/Netbackup/ /mnt/ -o user=root,domain=rootbrasil.intranet,vers=1.0,nodfs

mount -t cifs //10.100.8.132/Netbackup/NetBackup_8.2_Linux /mnt/ -o domain=rootbrasil.intranet,vers=1.0,nodfs

vers=3.0 