#!/bin/bash

docker run \
 --name xrdp-fedora \
 -itd \
 -p 3489:3389 \
 -e USER=radek \
 -e LANGUAGE=pl_PL \
 -v "$(pwd)"/../xrdp-fedora-home:/home \
 -v /dev/shm:/dev/shm \
 --cpus=6.0 \
 xrdp-fedora
