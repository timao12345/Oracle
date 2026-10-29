-- OCI CLI

-- Atualizar a versão do python
yum install python3 -Y

-- caso ocorra erro de repositorio do YUM irá precisar de um arquivo de outro servidor que fique no mesmo TENANCY que funcione o YUM.
-- Caminhos.

/etc/yum.repos.d

-rw-r--r-- 1 root root 16402 Mar 25 19:57 public-yum-ol7.repo
[root@ndbambcomp10 yum.repos.d]# cd /etc/yum.repos.d
[root@ndbambcomp10 yum.repos.d]# ll
total 20
-rw-r--r-- 1 root root 16402 Mar 25 19:57 public-yum-ol7.repo
[root@ndbambcomp10 yum.repos.d]#

-- Mandar o arquivo para o servidor que não está funcionando o YUM

--Instalar o CLI
seguir o procedimento
-- pode ocorrer de precisar executar o comando abaixo quando termina de instalar o CLI
oci setup repair-file-permissions --file /root/.oci/oci_api_key.pem

