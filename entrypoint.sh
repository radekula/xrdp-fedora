#!/bin/bash

if [ -n "$USER" ]
then
    USER_ID=$(id -u $USER)
    if [ -z "$USER_ID" ]
    then
        useradd $USER --create-home --shell /bin/bash
        usermod -aG wheel $USER
        if [ -n "$PASSWD" ]
        then
            echo "$USER:$PASSWD" | chpasswd
        else
            echo "$USER:passwordxrdp" | chpasswd
        fi
    fi
fi

echo "Starting XRDP server"
rm -f /var/run/xrdp/xrdp-sesman.pid
rm -f /var/run/xrdp/xrdp.pid
xrdp-sesman
xrdp
read
