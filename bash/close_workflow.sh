#!/bin/bash

echo Stop consumer service.
# Script to execute:

            # noqa: E501

            CID_FILE=~/workspace/shuke/1000/2000/consumer/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/shuke/150641/368269/consumer/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE


echo Stop provider services.
# Script to execute:

            # noqa: E501

            CID_FILE=~/workspace/shuke/1000/2000/provider-small/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/shuke/1000/2000/provider-small/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            # noqa: E501

            CID_FILE=~/workspace/shuke/1000/2000/provider-medium/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/shuke/1000/2000/provider-medium/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            # noqa: E501

            CID_FILE=~/workspace/shuke/1000/2000/provider-large/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/shuke/1000/2000/provider-large/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
#
echo Stop etcd service.
# Script to execute:

            # noqa: E501

            CID_FILE=~/workspace/shuke/1000/2000/etcd/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/shuke/1000/2000/etcd/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE


#
echo  Unlock remote task home.
# Script to execute:

            if [[ -f ~/workspace/shuke/1000/2000/.lock ]]; then
                rm -f ~/workspace/shuke/1000/2000/.lock
            fi
            exit 0
