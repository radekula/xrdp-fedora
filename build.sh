#!/bin/bash

docker pull fedora
docker build --no-cache -t xrdp-fedora .
