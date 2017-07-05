#!/bin/bash
source ~/.bash_profile
nginxpid="/var/run/"
logs_path="/usr/local/letv/"
logdate=`date '+%Y%m%d%H%M' -d "-1 hours"`
cd $logs_path
mv  access.log  access_${logdate}.log
kill -USR1 `cat ${nginxpid}nginx.pid`
tar czvf  access_${logdate}.tar.gz  access_${logdate}.log
rm -rf  access_${logdate}.log
find . -name "access_*.gz"   -mtime +2 -exec rm  {} \;
find . -name "access_*.*.tmp"  -exec rm  {} \;
