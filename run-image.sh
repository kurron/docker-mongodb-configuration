#!/bin/bash

docker run  --detach=true --publish 8888:8888 --publish 1234:1234 --hostname btsync --name btsync --volume /tmp/btsync:/mnt/bookkeeping --volume /tmp/sync:/mnt/sync kurron/bittorrent-sync
