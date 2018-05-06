# stop consumer Script to execute:

            # noqa: E501
            CID_FILE=~/workspace/provider/1000/2000/consumer/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/provider/1000/2000/consumer/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            
# Stop provider services.
# Script to execute:

            # noqa: E501
            CID_FILE=~/workspace/provider/1000/2000/provider-small/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/provider/1000/2000/provider-small/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            # noqa: E501
            CID_FILE=~/workspace/provider/1000/2000/provider-medium/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/provider/1000/2000/provider-medium/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            # noqa: E501
            CID_FILE=~/workspace/provider/1000/2000/provider-large/run.cid
            CID=$(cat $CID_FILE)
            cat ~/.passwd | sudo -S -p '' docker stop $CID
            cat ~/.passwd | sudo -S -p '' docker logs $CID > ~/workspace/provider/1000/2000/provider-large/logs/docker.log
            cat ~/.passwd | sudo -S -p '' docker rm $CID
            rm -f $CID_FILE
            exit 0



