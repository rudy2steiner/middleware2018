#!/bin/bash

if [[ "$1" == "docker" ]]; then
   echo "start to press to docker"

    sleep 5
    wrk -t2 -c512 -d30s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos/invoke

    # Pressure with 64 connections.

       sleep 5
       wrk -t2 -c128 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos/invoke

    # Pressure with 128 connections.

       sleep 5
       wrk -t2 -c256 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos/invoke


    #Pressure with 256 connections.

      sleep 5
      wrk -t2 -c512 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos/invoke
elif [[ "$1" == "phy" ]]; then
  echo "start to press to physical"
  sleep 5
  wrk -t2 -c512 -d30s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke

# Pressure with 64 connections.

   sleep 5
   wrk -t2 -c128 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke

# Pressure with 128 connections.

   sleep 5
   wrk -t2 -c256 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke


#Pressure with 256 connections.

  sleep 5
  wrk -t2 -c512 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke
  exit 0
fi
