#!/bin/bash

SERVICE_HOME=/home/devspace/services/
cp $SERVICE_HOME/mesh-consumer/target/mesh-consumer-1.0-SNAPSHOT.jar /root/dists/mesh-consumer.jar
cp $SERVICE_HOME/mesh-provider/target/mesh-provider-1.0-SNAPSHOT.jar /root/dists/mesh-provider.jar
AGENT_HOME=/home/devspace/agent-demo/
cp $AGENT_HOME/mesh-agent/target/mesh-agent-1.0-SNAPSHOT.jar /root/dists/mesh-agent.jar
ls -l /root/dists
