#!/bin/bash
Q1="CREATE DATABASE IF NOT EXISTS confdb;"
Q2="GRANT ALL ON *.* TO '$confuser'@'%' IDENTIFIED BY 'ConfPassword';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"
mysql -uroot -pRootPassword -hlocalhost:3306 -e "$SQL"
ok() { echo -e '\e[32m'$1'\e[m'; }
ok "Database confdb and user confuser created with a password ConfPassword"


sudo sh -c "echo 'nameserver 1.1.1.1' >> /etc/resolv.conf"

wget https://downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-6.2.0-x64.bin
chmod 755 atlassian-confluence-6.2.0-x64.bin
./atlassian-confluence-6.2.0-x64.bin -q