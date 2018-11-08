# 2018-11-6-PHP-Symfony-User-Group-Basel
All material related to the talk PHP-FPM und nginx Infratruktur

# presentations slides
The slides and material of the presentations is available in doc/presentation 

# php code
you will find the php code used in src/php

# Vagrant
you will find two vagrant projects to start the corresponding apache and nginx php-fpm VMS used in this presentation

```$xslt
# start the vms
vagrant up

# restart if you make changes on the vagrant file
vagrant reload 

# vagrant only provison
vagrant provision

# stop the vms
vagrant halt

# Delete the VM
vagrant destroy

# view base images
vagrant box list

# delete a box
vagrant box remove [--box-version]
```
  
# goshell
for system statistics, I have created a simple go server that will execure a bash script and output the value to a web server.
this values can be gathered with curl or a web browser
you can find the code in src/goshell

#About performance measurement method
Sadly in the time given i was no able to automate this.

Hereby i document the process I followed for gathering the data stored in src/Metrics.ods

## process
I used Jmeter the configuration found in performance_measure

I manually started every test case by changing the thread count.

After 30 seconds of warmup phase, I cleared the summary report and waited again about 30 seconds until the number would have normalized.

Then I took the system load using goshell service and copied the jmeter valued before stopping the test

After every test I restart the web server for getting a clean environment
