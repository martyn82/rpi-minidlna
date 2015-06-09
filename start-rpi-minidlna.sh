#!/bin/bash

docker run -d --net=host -v /mnt/media:/data/media martyn82/rpi-minidlna
