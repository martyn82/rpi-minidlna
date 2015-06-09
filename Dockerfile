FROM resin/rpi-raspbian:wheezy
MAINTAINER Martijn Endenburg <martijn.endenburg@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

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
    /usr/src/minidlna \
    && wget -O /usr/src/minidlna/minidlna-1.1.4.tar.gz http://sourceforge.net/projects/minidlna/files/minidlna/1.1.4/minidlna-1.1.4.tar.gz \
    && cd /usr/src/minidlna \
    && tar -xvf minidlna-1.1.4.tar.gz \
    && cd minidlna-1.1.4 \
    && ./configure && make && make install

# Configuration
COPY minidlna.conf /etc/minidlna.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN groupadd -r user && \
    useradd -r -g user user

USER user

VOLUME /data/media
EXPOSE 8200 1900/udp

# Entrypoint
CMD ["/usr/bin/supervisord"]
