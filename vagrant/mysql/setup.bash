#!/usr/bin/env bash
## add a better bashrc for root shell
sudo cp /host_project/var/rootbashrc /root/.bashrc
sudo chown root:root /root/.bashrc

## install apps
apt-get install -y joe htop curl


sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server
#sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES; SET GLOBAL max_connect_errors=10000;"
sudo /etc/init.d/mysql restart




## Ending Provisioning
IP=`ip addr show eth0 | grep -Po 'inet \K[\d.]+'`

echo ""
echo ""
echo ""
echo "mysql machine configured with IP: $IP"