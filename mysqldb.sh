sudo apt-get -y update
sudo sh -c "echo 'nameserver 1.1.1.1' >> /etc/resolv.conf"
sudo apt-get -y remove docker docker-engine docker.io
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql/mysql-server:5.7
sudo docker run --name=mysqlCon -p 3306:3306 -e MYSQL_ROOT_HOST='%' -e MYSQL_ROOT_PASSWORD=RootPassword -d mysql/mysql-server:5.7