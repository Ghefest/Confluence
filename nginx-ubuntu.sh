sudo apt-get update -yq
sudo apt install nginx -y

sudo su 
echo "
192.168.1.30    app
">>/etc/hosts
sudo su 

curl https://devopso182yehjan.s3.us-east-2.amazonaws.com/nginx.conf --output nginx.conf
cat nginx.conf > /etc/nginx/nginx.conf

service nginx restart
