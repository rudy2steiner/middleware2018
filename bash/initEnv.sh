
# start etcd

ETCD_HOME=~/workspace/provider/1000/2000/etcd
IP_ADDR=$(ip addr show docker0 | grep 'inet\b' | awk '{print $2}' | cut -d '/' -f 1)
PORT=2379
CLIENT_URL=http://$IP_ADDR:$PORT
rm -rf $ETCD_HOME
mkdir -p $ETCD_HOME
nohup /opt/etcd/etcd   --listen-client-urls $CLIENT_URL     --advertise-client-urls $CLIENT_URL  --data-dir $ETCD_HOME/data > $ETCD_HOME/etcd.log 2>&1 &
echo $! > $ETCD_HOME/run.pid


# start provider for small,middle and large

  cd ~/workspace/provider/1000/2000
            if [[ -d provider-small ]]; then
                rm -rf provider-small
            fi
            mkdir -p provider-small/logs
            cd provider-small
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name provider-small                 --cidfile run.cid                 --cpu-period 50000                 --cpu-quota 30000                 -m 2g                 --network host                 -v ~/workspace/provider/1000/2000/provider-small/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-small
            cd ~/workspace/provider/1000/2000
            if [[ -d provider-medium ]]; then
                rm -rf provider-medium
            fi
            mkdir -p provider-medium/logs
            cd provider-medium
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name provider-medium                 --cidfile run.cid                 --cpu-period 50000                 --cpu-quota 60000                 -m 4g                 --network host                 -v ~/workspace/provider/1000/2000/provider-medium/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-medium
            cd ~/workspace/provider/1000/2000
            if [[ -d provider-large ]]; then
                rm -rf provider-large
            fi
            mkdir -p provider-large/logs
            cd provider-large
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name provider-large                 --cidfile run.cid                 --cpu-period 50000                 --cpu-quota 90000                 -m 6g                 --network host                 -v ~/workspace/provider/1000/2000/provider-large/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo provider-large
            # noqa: E501

            ATTEMPTS=0
            MAX_ATTEMPTS=10
            while true; do
                echo "Trying to connect 127.0.0.1:20889..."
                nc -v -n -w 1 --send-only 127.0.0.1 20889 < /dev/null; r1=$?

                echo "Trying to connect 127.0.0.1:20890..."
                nc -v -n -w 1 --send-only 127.0.0.1 20890 < /dev/null; r2=$?

                echo "Trying to connect 127.0.0.1:20891..."
                nc -v -n -w 1 --send-only 127.0.0.1 20891 < /dev/null; r3=$?

                echo $r1, $r2, $r3
                if [[ $r1 -eq 0 && $r2 -eq 0 && $r3 -eq 0 ]]; then
                    break 
                fi
                if [[ $ATTEMPTS -eq $MAX_ATTEMPTS ]]; then
                    echo "Cannot connect to some of the ports 20889, 20890, 20891 after $ATTEMPTS attempts."
                    exit 1
                fi
                ATTEMPTS=$((ATTEMPTS+1))
                echo "Waiting for 5 seconds... ($ATTEMPTS/$MAX_ATTEMPTS)"
                sleep 5
            done
            
 #Start consumer service  
 
 cd ~/workspace/provider/1000/2000
            if [[ -d consumer ]]; then
                rm -rf consumer
            fi
            mkdir -p consumer/logs
            cd consumer
            cat ~/.passwd | sudo -S -p '' docker run -d                 --name consumer                 --cidfile run.cid                 --cpu-period 50000                 --cpu-quota 200000                 -m 4g                 --network host                 -v ~/workspace/provider/1000/2000/consumer/logs:/root/logs                 registry.cn-hangzhou.aliyuncs.com/ocean18/dubbo-tianchi-agent-demo consumer

            ATTEMPTS=0
            MAX_ATTEMPTS=10
            while true; do
                echo "Trying to connect 127.0.0.1:8087..."
                nc -v -n -w 1 --send-only 127.0.0.1 8087 < /dev/null
                if [[ $? -eq 0 ]]; then
                    exit 0
                fi
                if [[ $ATTEMPTS -eq $MAX_ATTEMPTS ]]; then
                    echo "Cannot connect to port 8087 after $ATTEMPTS attempts."
                    exit 1
                fi
                ATTEMPTS=$((ATTEMPTS+1))
                echo "Waiting for 5 seconds... ($ATTEMPTS/$MAX_ATTEMPTS)"
                sleep 5
            done
            
            

  

  
   
   
   
            
            
 
          
            
