#!/usr/bin/env bash

renum='^[0-9]+$'
k="K"

# get total mem
totalmem=`grep MemTotal /proc/meminfo | awk '{print $2}'`

## get nginx user mem
nginxid=`ps axf | grep "nginx: master" | grep -v grep | awk '{print $1}'`
if [[ $nginxid =~ $renum ]] ; then
    nginxmem=`pmap $nginxid | grep total | awk '{print $2}'`
fi

## get nginx user mem
fpmpid=`ps axf | grep "php-fpm: master" | grep -v grep | awk '{print $1}'`
if [[ $fpmpid =~ $renum ]] ; then
    fpmmem=`pmap $fpmpid | grep total | awk '{print $2}'`
fi



echo "total:$totalmem$k|nginx:$nginxmem|php:$fpmmem|"





