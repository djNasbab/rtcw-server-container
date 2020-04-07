#!/usr/bin/env bash

docker run -d -p 28960:28960 \
    -p 27960:27960/udp \
     rtcw-server:latest