#!/bin/bash

# count strings in php error log with @error word
# restart php process if errors too much in last 5 minutes


 THISMINUTE=$(date '+%d-%b-%Y %H:%M')
 LASTMINUTE=$(date '+%d-%b-%Y %H:%M' --date="5 minute ago")

 dt=`(date '+%d/%m/%Y %H:%M:%S')`

 #echo /$LASTMINUTE/,/$THISMINUTE/

 errorsc=`tail -n 10000 /var/log/rtb/php/ini_php_dmp_error.log | sed -n "/$LASTMINUTE/,/$THISMINUTE/p" | grep "error" | wc -l`

 #errorsc=`tail -n 10000 /var/log/rtb/php/ini_php_dmp_error.log |grep "$THISMINUTE" | grep -i "error" | wc -l`


 if [[ $errorsc -ge 100 ]];then

         echo $dt php_dmp errors count $errorsc, restarting... >> /var/log/php.log
         /etc/init.d/php-dmp restart

 else
         echo $dt php_dmp errors count $errorsc
         echo ok


 fi
