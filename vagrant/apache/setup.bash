#!/usr/bin/env bash
## add a better bashrc for root shell
sudo cp /host_project/var/rootbashrc /root/.bashrc
sudo chown root:root /root/.bashrc

## install apps
apt-get install -y  apache2 libapache2-mod-php7.0 joe htop curl


sudo id -u phpuser1 &>/dev/null || useradd -d /vhosts -u 1100 phpuser1
sudo mkdir -p /vhosts/phpuser1/public_html
sudo chown -R phpuser1:phpuser1 /vhosts/phpuser1/
sudo chmod -R 750 /vhosts/phpuser1/
#
sudo usermod -a -G phpuser1 www-data


BINDMOUNT='/host_project/php/ /vhosts/phpuser1/public_html/ none defaults,bind 0 0'
sudo grep -q -F "$BINDMOUNT" /etc/fstab || echo "$BINDMOUNT" >> /etc/fstab
sudo mount -a


# configure Aapache
sudo cp /vagrant/user1-site.conf /etc/apache2/sites-available/
sudo ln -sf /etc/apache2/sites-available/user1-site.conf /etc/apache2/sites-enabled/user1-site.conf
sudo rm -f /etc/apache2/sites-enabled/000-default.conf

sudo /etc/init.d/apache2 restart


# configure goshell
# used for cpu and memory output on port 8090 (guest)
sudo mkdir /goshell/
BINDMOUNT='/host_project/goshell/ /goshell/ none defaults,bind 0 0'
sudo grep -q -F "$BINDMOUNT" /etc/fstab || echo "$BINDMOUNT" >> /etc/fstab
sudo mount -a

sudo cp /host_project/goshell/goshellservice /lib/systemd/system/goshell.service
sudo systemctl enable goshell.service
sudo systemctl start goshell

sudo cp "/vagrant/goshell.sh" "/goshell"

## Ending Provisioning
IP=`ip addr show eth0 | grep -Po 'inet \K[\d.]+'`

echo ""
echo ""
echo ""
echo "Apache machine configured with IP: $IP"