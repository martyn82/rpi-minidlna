# This Dockerfile creates a containerized minidlna production instance.
# It will install and run a minidlna application.

FROM resin/rpi-raspbian:wheezy
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

VOLUME /data/media
EXPOSE 8200 1900/udp

# Add source repository
RUN echo "deb-src http://archive.raspbian.org/raspbian wheezy main contrib non-free" | tee -a /etc/apt/sources.list

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    tar \
    && apt-get build-dep minidlna -y

# Copy app and config
COPY bin/minidlnad.tar.gz minidlnad.tar.gz
COPY minidlna.conf /etc/minidlna.conf
COPY supervisord.conf /etc/supervisord.conf

RUN tar -zxvf minidlnad.tar.gz \
    && cd /minidlna \
    && make install

# Entrypoint
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
