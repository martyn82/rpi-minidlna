# This Dockerfile creates a containerized minidlna build instance.
# It will compile and package a minidlna application.

FROM resin/rpi-raspbian:wheezy
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

VOLUME /build

# Add source repository
RUN echo "deb-src http://archive.raspbian.org/raspbian wheezy main contrib non-free" | tee -a /etc/apt/sources.list

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    tar \
    wget \
    && apt-get build-dep minidlna -y

# Download, unpack, and compile minidlna
RUN mkdir -p \
    /minidlna \
    && wget --no-check-certificate -O /minidlna/minidlna-1.1.4.tar.gz http://sourceforge.net/projects/minidlna/files/minidlna/1.1.4/minidlna-1.1.4.tar.gz \
    && cd /minidlna \
    && tar -xvf minidlna-1.1.4.tar.gz \
    && cd minidlna-1.1.4 \
    && ./configure && make

RUN cd /minidlna \
    && mv minidlna-1.1.4 minidlna \
    && tar -zcf minidlnad.tar.gz minidlna

CMD cp /minidlna/minidlnad.tar.gz /build/minidlnad.tar.gz
