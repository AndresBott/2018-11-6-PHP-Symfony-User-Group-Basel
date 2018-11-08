#!/usr/bin/env bash
#=============================================================================================================
## add a better bashrc for root shell
#=============================================================================================================
sudo cp /host_project/var/rootbashrc /root/.bashrc
sudo chown root:root /root/.bashrc

#=============================================================================================================
## install apps
#=============================================================================================================
apt-get install -y  apache2 libapache2-mod-php7.0 joe htop curl



#=============================================================================================================
# Create phpuser1
#=============================================================================================================
USER="phpuser1"
sudo id -u $USER &>/dev/null || useradd -d /vhosts -u 1100 $USER
sudo usermod -a -G $USER www-data
sudo mkdir -p /vhosts/$USER/
# clean up if provisioned again
if [ -d "/vhosts/$USER/public_html/" ]; then
    rm -R /vhosts/$USER/public_html/
fi
sudo cp -R /host_project/php/ /vhosts/$USER/public_html/

sudo chown -R $USER:$USER /vhosts/$USER/
sudo chmod -R 770 /vhosts/$USER/

#=============================================================================================================
# Create phpuser2
#=============================================================================================================
USER="phpuser2"
sudo id -u $USER &>/dev/null || useradd -d /vhosts -u 1101 $USER
sudo usermod -a -G $USER www-data

sudo mkdir -p /vhosts/$USER/
# clean up if provisioned again
if [ -d "/vhosts/$USER/public_html/" ]; then
    rm -R /vhosts/$USER/public_html/
fi
sudo cp -R /host_project/php/ /vhosts/$USER/public_html/

sudo chown -R $USER:$USER /vhosts/$USER/
sudo chmod -R 770 /vhosts/$USER/

#BINDMOUNT="/host_project_user2/ /vhosts/$USER/public_html/ none defaults,bind 0 0"
#sudo grep -q -F "$BINDMOUNT" /etc/fstab || echo "$BINDMOUNT" >> /etc/fstab
#sudo mount -a


#=============================================================================================================
# configure Apache
#=============================================================================================================
sudo cp /vagrant/user1-site.conf /etc/apache2/sites-available/
sudo ln -sf /etc/apache2/sites-available/user1-site.conf /etc/apache2/sites-enabled/user1-site.conf

sudo cp /vagrant/user2-site.conf /etc/apache2/sites-available/
sudo ln -sf /etc/apache2/sites-available/user2-site.conf /etc/apache2/sites-enabled/user2-site.conf

sudo rm -f /etc/apache2/sites-enabled/000-default.conf

sudo /etc/init.d/apache2 restart


#=============================================================================================================
# configure goshell
# used for cpu and memory output on port 8090 (guest)
#=============================================================================================================

sudo mkdir -p /goshell/
sudo cp /host_project/goshell/goshell /goshell/goshell
sudo cp /vagrant/goshell.sh /goshell/goshell.sh
sudo chown -R root:root /goshell/
sudo chmod -R 750 /goshell/


#BINDMOUNT='/host_project/goshell/ /goshell/ none defaults,bind 0 0'
#sudo grep -q -F "$BINDMOUNT" /etc/fstab || echo "$BINDMOUNT" >> /etc/fstab
#sudo mount -a

sudo cp /host_project/goshell/goshellservice /lib/systemd/system/goshell.service
sudo systemctl enable goshell.service
sudo systemctl start goshell

sudo cp "/vagrant/goshell.sh" "/goshell"
#=============================================================================================================
# Ending Provisioning
#=============================================================================================================
IP=`ip addr show eth0 | grep -Po 'inet \K[\d.]+'`

echo ""
echo ""
echo ""
echo "Apache machine configured with IP: $IP"