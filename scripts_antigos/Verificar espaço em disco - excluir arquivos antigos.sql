Verificar tamanho das pastas
du -sh *

listagem de todos os discos na maquina
df -h

listagem do disco atual
df -h .


--comando  lctr

ls -lctr

-- apagar arquivos antigos
find . -type f -name \*.trc -mtime -1 -exec rm {} \;
find . -type f -name \*.trm -mtime -1 -exec rm {} \;
find . -type f -name \*.xml -mtime -1 -exec rm {} \; 
find . -type f -name \*.aud -mtime -1 -exec rm {} \;  


-- Mostrar local aonde está sendo gravado os logs do banco de dados.
show parameter back