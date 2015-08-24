# Trusty 
FROM ubuntu:14.04

MAINTAINER Ron Kurr <kurr@kurron.org>

ENV DEBIAN_FRONTEND noninteractive

# Install BitTorrent Sync
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget && \
    apt-get clean && \
    wget --quiet \
         --output-document=/btsync.tar.gz \
         --no-check-certificate \
         --no-cookies \
         https://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz && \
    mkdir -p /opt/btsync && \
    tar --gunzip --extract --verbose --file /btsync.tar.gz --directory /usr/bin && \
    rm -f /btsync.tar.gz && \
    chown -R root:root /opt/btsync

# where to write bookkeeping files to
VOLUME /mnt/bookkeeping

# where to read/write files
VOLUME /mnt/sync

# export meta-data about this container
ENV KURRON_BTSYNC_VERSION 2.0.104 

ADD config.json /opt/btsync/config.json

RUN chown -R root:root /opt/btsync

EXPOSE 1234
EXPOSE 8888

ENTRYPOINT ["/usr/bin/btsync", "--nodaemon"]
CMD ["--config", "/opt/btsync/config.json"]
