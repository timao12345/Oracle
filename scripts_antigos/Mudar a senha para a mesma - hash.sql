--Verificar se o usuario existe
SELECT password FROM dba_users WHERE username='UOLDIVEO_DBA';


--Buscar a senha "criptografata" do usuario, hash do usuario.
select password,spare4 from user$ where name='UOLDIVEO_MON';


--Altera senha do usuario utilizando o hash encontrado na query acima. 
alter user UOLDIVEO_MON identified by values 'A83546811780FB0F';



