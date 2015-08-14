#!/bin/bash

if [[ -n $TUTUM_SERVICE_HOSTNAME ]]; then
    if [ -z "$(grep "nameserver 0.0.0.1" /etc/resolv.conf)" ]; then
        echo 'nameserver 0.0.0.0' | cat - /etc/resolv.conf > temp && cp temp /etc/resolv.conf
    fi
fi

/usr/bin/svscan /etc/service/
