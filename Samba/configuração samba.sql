-- config padrão
[global]
  workgroup = WORKGROUP
  netbios name = ATAKAREJO
  server string = ATAKAREJO - MYSQL database server - linux
  bind interfaces only = no
  security = user
#  min protocol = SMB2
  map to guest = Bad Password
  guest account = mysql
  csc policy = disable
  time server = yes
  hide special files = yes
  create mask = 0774
  directory mask = 0775
  force create mode = 0664
  force directory mode = 0775
  map archive = no
  map hidden = no
  map read only = no
  map system = no
  log level = 1
  printing = bsd
# ---

[SOCIN]
  comment = SOCIN_HML - diretorio publico
  read only = no
  force group = mysql
  path = /mnt/server-mysql
  guest ok = yes


-- verificar status dos serviços
service smb status
service nmb status

-- Adicionar regras para o SAMBA
iptables -I INPUT -p udp -m udp --dport 137 -j ACCEPT
iptables -I INPUT -p udp -m udp --dport 138 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 139 -j ACCEPT
iptables -I INPUT -p tcp -m tcp --dport 445 -j ACCEPT

iptables -A INPUT -p tcp --dport 1521 -j ACCEPT


service iptables save

iptables -A INPUT -i bondeth1 -p tcp --dport 1521 -j ACCEPT
service iptables save



LISTENER=(DESCRIPTION= (ADDRESS_LIST= (ADDRESS=(PROTOCOL=IPC)(KEY=LISTENER))(ADDRESS = (PROTOCOL = TCP)(HOST = 100.70.52.34)(PORT = 1521))))


LISTENER =(DESCRIPTION_LIST =(DESCRIPTION =(ADDRESS = (PROTOCOL = IPC)(KEY = LISTENER))(ADDRESS = (PROTOCOL = TCP)(HOST = 100.70.52.32)(PORT = 1521))))