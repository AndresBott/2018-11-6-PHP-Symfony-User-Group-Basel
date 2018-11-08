#!/usr/bin/env bash

renum='^[0-9]+$'
k="K"

# get total mem
totalmem=`grep MemTotal /proc/meminfo | awk '{print $2}'`

## get nginx user mem
#nginxid=`ps axf | grep "nginx: master" | grep -v grep | awk '{print $1}'`
	nginxmem=`ps -eo args,pcpu,rss,vsz | grep nginx | grep -v grep  | awk '{for (i=4;i<=6;i++) sum[i]+=$i;}; END{ for (i in sum) printf "%s;",sum[i] }'`
	IFS=';' read -r -a nginxmemvals <<< "$nginxmem"
	nginxthread=`ps -faux | grep nginx | grep -v grep | wc -l`


## get nginx user mem
#fpmpid=`ps axf | grep "php-fpm: master" | grep -v grep | awk '{print $1}'`
        fpmmem=`ps -eo args,pcpu,rss,vsz | grep php-fpm | grep -v grep  | awk '{for (i=4;i<=6;i++) sum[i]+=$i;}; END{ for (i in sum) printf "%s;",sum[i] }'`
        IFS=';' read -r -a fpmmemvals <<< "$fpmmem"
        fpmthread=`ps -faux | grep php-fpm | grep -v grep | wc -l`





echo "total:$totalmem $k |nginx_cpu:${nginxmemvals[0]} |nginx_thr:$nginxthread |nginx_rss:${nginxmemvals[1]} $k |nginx_vsz:${nginxmemvals[2]} $k |fpm_cpu:${fpmmemvals[0]} |fpm_thr:$fpmthread |fpm_rss:${fpmmemvals[1]} $k |fpm_vsz:${fpmmemvals[2]} $k"
echo "total memory,nginx_cpu,nginx_thread_count,nginx_rss,nginx_vsz,fpm_cpu,fpm_thread_count,fpm_rss,fpm_vsz"
echo "$totalmem,${nginxmemvals[0]},$nginxthread,${nginxmemvals[1]},${nginxmemvals[2]},${fpmmemvals[0]},$fpmthread,${fpmmemvals[1]},${fpmmemvals[2]}"





