#!/bin/bash


if [ -n "$LANGUAGE" ]
then
    echo "LANG=$LANGUAGE.UTF-8" > /etc/locale.conf
    localedef -c -i $LANGUAGE -f UTF-8 $LANGUAGE.UTF-8
fi


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
