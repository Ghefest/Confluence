sudo yum update -y
sudo yum install epel-release -y
sudo yum -y update
sudo yum install nginx -y
sudo su - 
echo "

192.168.1.30  app localhost 
">> /etc/hosts

echo "
events {
  worker_connections  1024;  ## Default: 1024
}
http {
 server {
    listen    80 default ipv6only=off;
    server_name localhost;
    charset utf8;
    location / {
          proxy_pass http://192.168.1.30:8090/;
#          proxy_redirect off;
 #         proxy_set_header Host \$http_host;
  #        proxy_set_header X-NginX-Proxy true;
   #       proxy_set_header X-Real-IP \$remote_addr;
    #      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
     #     proxy_set_header X-Forwarded-Proto http;
      #    port_in_redirect off;
       #   proxy_connect_timeout 600;

    }
 }
} " > /etc/nginx/nginx.conf

systemctl enable nginx && nginx -t && systemctl start nginx