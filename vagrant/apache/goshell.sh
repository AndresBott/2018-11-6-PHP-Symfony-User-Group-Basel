#!/usr/bin/env bash

renum='^[0-9]+$'
k="K"

# get total mem
totalmem=`grep MemTotal /proc/meminfo | awk '{print $2}'`

## get nginx user mem
#nginxid=`ps axf | grep "nginx: master" | grep -v grep | awk '{print $1}'`
        apachemem=`ps -eo args,pcpu,rss,vsz | grep apache2 | grep -v grep  | awk '{for (i=4;i<=6;i++) sum[i]+=$i;}; END{ for (i in sum) printf "%s;",sum[i] }'`
        IFS=';' read -r -a nginxmemvals <<< "$apachemem"
        nginxthread=`ps -faux | grep apache2 | grep -v grep | wc -l`



echo "total:$totalmem $k |apache_cpu:${nginxmemvals[0]} |apache_thr:$nginxthread |apache_rss:${nginxmemvals[1]} $k |apache_vsz:${nginxmemvals[2]} $k"
echo "total memory,apache_cpu,apache_thread_count,apache_rss,apache_vsz"
echo "$totalmem,${nginxmemvals[0]},$nginxthread,${nginxmemvals[1]},${nginxmemvals[2]}"
