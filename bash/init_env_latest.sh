#!/bin/#!/usr/bin/env bash

# Create Docker network.

# [DEBUG] Script to execute:

            # noqa: E501

            CID=$(cat ~/.passwd | sudo -S -p '' docker network ls --filter name=benchmarker -q)
            if [[ "$CID" != "" ]]; then
                echo "[WARN] Network named 'benchmarker' already exists, skip creating."
                exit 0
            fi
            cat ~/.passwd | sudo -S -p '' docker network create                 --driver=bridge                 --subnet=10.10.10.0/24                 --gateway=10.10.10.1                 -o "com.docker.network.bridge.name"="benchmarker"                 -o "com.docker.network.bridge.enable_icc"="true"                 benchmarker
            cat ~/.passwd | sudo -S -p '' ifconfig benchmarker 10.10.10.1 netmask 255.255.255.0

#[INFO] >>> Start etcd service.
#  [DEBUG] Script to execute:

            # noqa: E501

            ETCD_HOME=~/workspace/provider/1000/2000/etcd
            rm -rf $ETCD_HOME
            mkdir -p $ETCD_HOME/logs
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name=etcd                 --cidfile=$ETCD_HOME/run.cid                 --cpu-period=50000                 --cpu-quota=20000                 --memory=1g                 --network=benchmarker                 -v $ETCD_HOME/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/aliware2018/alpine-etcd

            echo $IP_ADDR
                ATTEMPTS=0
                MAX_ATTEMPTS=12
            while true; do
                echo "Trying to connect etcd..."
                cat ~/.passwd | sudo -S -p ''                     docker run --rm --network=benchmarker registry.cn-hangzhou.aliyuncs.com/aliware2018/alpine-nmap-ncat                     ncat -v -w 1 --send-only etcd 2379
                if [[ $? -eq 0 ]]; then
                    exit 0
                fi
                if [[ $ATTEMPTS -eq $MAX_ATTEMPTS ]]; then
                      echo "Cannot connect to etcd service after $ATTEMPTS attempts."
                        exit 1
                fi
                ATTEMPTS=$((ATTEMPTS+1))
                echo "Waiting for 5 seconds... ($ATTEMPTS/$MAX_ATTEMPTS)"
                      sleep 5
                done

#[INFO] >>> Start provider services.
#[DEBUG] Script to execute:

            PROVIDER_HOME=~/workspace/provider/1000/2000/provider-small
            rm -rf $PROVIDER_HOME
            mkdir -p $PROVIDER_HOME/logs
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name=provider-small                 --cidfile=$PROVIDER_HOME/run.cid                 --cpu-period=50000                 --cpu-quota=30000                 --memory=2g                 --network=benchmarker                 -v $PROVIDER_HOME/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-small
            PROVIDER_HOME=~/workspace/provider/1000/2000/provider-medium
            rm -rf $PROVIDER_HOME
            mkdir -p $PROVIDER_HOME/logs
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name=provider-medium                 --cidfile=$PROVIDER_HOME/run.cid                 --cpu-period=50000                 --cpu-quota=60000                 --memory=4g                 --network=benchmarker                 -v $PROVIDER_HOME/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-medium
            PROVIDER_HOME=~/workspace/provider/1000/2000/provider-large
            rm -rf $PROVIDER_HOME
            mkdir -p $PROVIDER_HOME/logs
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name=provider-large                 --cidfile=$PROVIDER_HOME/run.cid                 --cpu-period=50000                 --cpu-quota=90000                 --memory=6g                 --network=benchmarker                 -v $PROVIDER_HOME/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-large
              # noqa: E501

              ATTEMPTS=0
              MAX_ATTEMPTS=12
              while true; do
                  echo "Trying to connect provider-small..."
                        cat ~/.passwd | sudo -S -p ''                     docker run --rm --network=benchmarker registry.cn-hangzhou.aliyuncs.com/aliware2018/alpine-nmap-ncat                     ncat -v -w 1 --send-only provider-small 20880; r1=$?
                  echo "Trying to connect provider-medium..."
                        cat ~/.passwd | sudo -S -p ''                     docker run --rm --network=benchmarker registry.cn-hangzhou.aliyuncs.com/aliware2018/alpine-nmap-ncat                     ncat -v -w 1 --send-only provider-medium 20880; r2=$?

                  echo "Trying to connect provider-large..."
                        cat ~/.passwd | sudo -S -p ''                     docker run --rm --network=benchmarker registry.cn-hangzhou.aliyuncs.com/aliware2018/alpine-nmap-ncat                     ncat -v -w 1 --send-only provider-large 20880; r3=$?

                  if [[ $r1 -eq 0 && $r2 -eq 0 && $r3 -eq 0 ]]; then
                        exit 0
                  fi
                  if [[ $ATTEMPTS -eq $MAX_ATTEMPTS ]]; then
                        echo "Cannot connect to some of the provider services after $ATTEMPTS attempts."
                          exit 1
                  fi
                    ATTEMPTS=$((ATTEMPTS+1))
                    echo "Waiting for 5 seconds... ($ATTEMPTS/$MAX_ATTEMPTS)"
                    sleep 5
                  done
