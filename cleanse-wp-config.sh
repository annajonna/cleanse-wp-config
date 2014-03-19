#!/bin/bash

for APACHEFILE in /etc/httpd/vhosts.d/*.conf ; do
    APACHEDR=$(grep DocumentRoot $APACHEFILE | head --lines=1 | sed 's/^[ \t]*//;s/[ \t]*$//;/^$/d;/^#/d' | sed -r 's#(^[a-zA-Z]*[ \t]*(.*$))#\2#g'); 
    for SKRA in $APACHEDR/wp-config.php; do
        if [ -e $SKRA ]; then 
            echo SKRA: $SKRA
# Any settings with upload_tmp_dir in wp-config.php will be brutally deleted
            sed '/upload_tmp_dir/d' -i $SKRA; 
            sed '/ini_get/d' -i $SKRA; 
        fi
    done    
done 

