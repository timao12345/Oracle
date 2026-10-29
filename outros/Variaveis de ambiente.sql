-- windows
set ORACLE_HOME=C:\app\Parceiro\product\18.0.0\dbhomeXE\bin
set ORACLE_HOME=C:\app\Parceiro\product\18.0.0\dbhomeXE\bin

set Path=C:\Oracle\product\19.0.0\client_1\bin;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Amazon\cfn-bootstrap\;C:\Users\lmelo.accenture\AppData\Local\Microsoft\WindowsApps;

SET PATH=%ORACLE_HOME%/bin;%PATH%

-- linux
export ORACLE_BASE=/oracle/GRID
export ORACLE_HOME=/oracle/GRID/19C_64
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=+ASM

--ou

export ORACLE_BASE=/u03/app/oracle
export ORACLE_HOME=/u03/app/oracle/product/19.0.0.0/dbhome_2
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=kpvqa


PATH="/u03/app/oracle/product/19.0.0.0/dbhome_2/bin:/home/oracle/.local/bin:/home/oracle/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"

ORABASE_EXEC=/oracle/GRID/19C_64/bin/orabase
ORACLE_BASE=/oracle/GRID
ORACLE_HOME=/oracle/GRID/19C_64
ORACLE_SID=+ASM
ORAHOME=/oracle/GRID/19C_64
 ---
declare -x CLASSPATH="/u02/app/oracle/product/19.0.0.0/dbhome_1/JRE:/u02/app/oracle/product/19.0.0.0/dbhome_1/jlib:/u02/app/oracle/product/19.0.0.0/dbhome_1/rdbms/jlib"
declare -x GRID_HOME_19="/u01/app/19.0.0.0/grid"
declare -x HISTCONTROL="ignoredups"
declare -x HISTSIZE="1000"
declare -x HOME="/home/oracle"
declare -x HOSTNAME="vmlnxhom015.adcorp.intranet"
declare -x LANG="en_US.UTF-8"
declare -x LD_LIBRARY_PATH="/u03/app/oracle/product/19.0.0.0/dbhome_2/lib/"
declare -x LESSOPEN="||/usr/bin/lesspipe.sh %s"
declare -x LOGNAME="oracle"
declare -x LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.m4a=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.oga=01;36:*.opus=01;36:*.spx=01;36:*.xspf=01;36:"
declare -x MAIL="/var/spool/mail/oracle"
declare -x OH="/u02/app/oracle/product/19.0.0.0/dbhome_1"
declare -x OLDPWD
declare -x ORACLE_BASE="/u03/app/oracle"
declare -x ORACLE_HOME="/u03/app/oracle/product/19.0.0.0/dbhome_2"
declare -x ORACLE_HOME_19_6="/u02/app/oracle/product/19.0.0.0/dbhome_1"
declare -x ORACLE_HOSTNAME="vmlnxhom015.adcorp.intranet"
declare -x ORACLE_SID="kpvqa"
declare -x ORACLE_UNQNAME="kpvpprd"
declare -x PATH="/sbin:/bin:/usr/sbin:/usr/bin:/u03/app/oracle/product/19.0.0.0/dbhome_2/bin:/u02/app/oracle/product/19.0.0.0/dbhome_2/OPatch"
declare -x PWD="/home/oracle"
declare -x SHELL="/bin/bash"
declare -x SHLVL="1"
declare -x S_COLORS="auto"
declare -x TERM="xterm"
declare -x TNS_ADMIN="/u02/app/oracle/product/19.0.0.0/dbhome_6/network/admin/kpvpprd"
declare -x USER="oracle"
declare -x which_declare="declare -f"
