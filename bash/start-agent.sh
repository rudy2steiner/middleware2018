#!/bin/bash

ETCD_HOST=$(ip addr show docker0 | grep 'inet\b' | awk '{print $2}' | cut -d '/' -f 1)
ETCD_PORT=2379
ETCD_URL=http://$ETCD_HOST:$ETCD_PORT

echo ETCD_URL = $ETCD_URL

if [[ "$1" == "consumer" ]]; then
  echo "Starting consumer agent..."
  nohup java -jar \
       -Xms1536M \
       -Xmx1536M \
       -Dtype=consumer \
       -Dserver.port=20000\
       -Detcd.url=$ETCD_URL \
       -Dlogs.dir=/root/logs/consumer/ \
       /root/dists/mesh-agent.jar \
       > /dev/null 2&>1 &
elif [[ "$1" == "provider-small" ]]; then
  echo "Starting small provider agent..."
nohup  java -jar \
       -Xms512M \
       -Xmx512M \
       -Dtype=provider \
       -Dcpu.period=50000 \
       -Dprovider.cpu.quota=30000 \
       -Dprovider.memory=2 \
       -Dserver.port=30000 \
       -Ddubbo.protocol.port=20889 \
       -Detcd.url=$ETCD_URL \
       -Dlogs.dir=/root/logs/small/ \
       /root/dists/mesh-agent.jar \
       > /dev/null 2&>1 &
elif [[ "$1" == "provider-medium" ]]; then
  echo "Starting medium provider agent..."
nohup  java -jar \
       -Xms1536M \
       -Xmx1536M \
       -Dtype=provider \
       -Dcpu.period=50000 \
       -Dprovider.cpu.quota=60000 \
       -Dprovider.memory=4 \
       -Dserver.port=30001\
       -Ddubbo.protocol.port=20890 \
       -Detcd.url=$ETCD_URL \
       -Dlogs.dir=/root/logs/medium/ \
       /root/dists/mesh-agent.jar \
       > /dev/null 2&>1 &
elif [[ "$1" == "provider-large" ]]; then
  echo "Starting large provider agent..."
nohup  java -jar \
       -Xms2560M \
       -Xmx2560M \
       -Dtype=provider \
       -Dcpu.period=50000 \
       -Dprovider.cpu.quota=90000 \
       -Dprovider.memory=6 \
       -Dserver.port=30002\
       -Ddubbo.protocol.port=20891 \
       -Detcd.url=$ETCD_URL \
       -Dlogs.dir=/root/logs/large/ \
       /root/dists/mesh-agent.jar  \
       > /dev/null 2&>1 &
else
  echo "Unrecognized arguments, exit."
  exit 1
fi
