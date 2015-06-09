#!/bin/bash

docker run -d -p 8200:8200 -p 1900:1900/udp -v /data/media:/mnt/media martyn82/rpi-minidlna
