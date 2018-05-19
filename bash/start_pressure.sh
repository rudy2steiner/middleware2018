# warm up


  sleep 5
  wrk -t2 -c256 -d20s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke
  
# Pressure with 64 connections.

   sleep 5
   wrk -t2 -c64 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke
       
# Pressure with 128 connections.

   sleep 5
   wrk -t2 -c128 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke
  
   
#Pressure with 256 connections.

  sleep 5
  wrk -t2 -c256 -d60s -T5                 --script=./benchmark/wrk.lua                 --latency http://provider.tcentos:8087/invoke
  exit 0
  
