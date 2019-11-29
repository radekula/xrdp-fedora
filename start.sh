#!/bin/bash

docker run \
 --name xrdp-fedora \
 -itd \
 -p 3489:3389 \
 -e USER=xrdp \
 -v "$PWD"/home:/home \
 -v "$PWD"xrdp:/etc/xrdp \
 -v /dev/shm:/dev/shm \
 --cpus=6.0 \
 xrdp-fedora
