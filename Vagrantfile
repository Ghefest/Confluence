# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "ubuntuproxy" do |ubuntuproxy|
    ubuntuproxy.vm.box = "generic/ubuntu1804"
    ubuntuproxy.vm.network "forwarded_port", guest: 80, host: 80
    ubuntuproxy.vm.hostname = 'proxy'

    ubuntuproxy.vm.network "private_network", ip: "192.168.1.40"
    ubuntuproxy.vm.provision "shell", path:"nginx-ubuntu.sh" 
    ubuntuproxy.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "ubuntuproxy"]
    end
  end

  config.vm.define "db" do |db|
    db.vm.box = "generic/ubuntu1804"
    db.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true
    db.vm.hostname = 'db'
    db.vm.box_url = "generic/ubuntu1804"

    db.vm.network "private_network", ip: "192.168.1.20"
    db.vm.provision "shell", inline: <<-SHELL
      sudo sh -c "echo 'nameserver 1.1.1.1' >> /etc/resolv.conf"
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
      sudo sysctl net.ipv6.conf.default.disable_ipv6=1
      sudo sysctl net.ipv6.conf.lo.disable_ipv6=1
    SHELL
    db.vm.provision "shell", path:"mysqldb.sh"
    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 1024]
      v.customize ["modifyvm", :id, "--name", "db"]
    end
  end

  config.vm.define "app" do |app|
    app.vm.box = "generic/ubuntu1804"
    app.vm.network "forwarded_port", guest: 8090, host: 8090
    app.vm.hostname = 'app'
    app.vm.box_url = "generic/ubuntu1804"

    app.vm.network "private_network", ip: "192.168.1.30"
    app.vm.provision "shell", inline: <<-SHELL
      sudo sh -c "echo 'nameserver 1.1.1.1' >> /etc/resolv.conf"
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
      sudo sysctl net.ipv6.conf.default.disable_ipv6=1
      sudo sysctl net.ipv6.conf.lo.disable_ipv6=1
      sudo systemctl restart systemd-resolved
      sudo apt-get -y update
      sudo apt install -y mysql-client
    SHELL
    app.vm.provision "shell", path:"confluence.sh" 
    app.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "app"]
    end
  end
  
end
