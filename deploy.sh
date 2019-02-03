#!/bin/bash

# stop the running container
docker stop $(docker ps -a | grep "ylee457/wsock:101" | awk '{print $1}')
docker rm $(docker ps -a | grep "ylee457/wsock:101" | awk '{print $1}')
docker rmi ylee457/wsock:101

mvn package
docker rmi websock-demo:1
docker build -t websock-demo:1 .
docker login
docker tag websock-demo:1 ylee457/wsock:101
docker push ylee457/wsock:101
docker rmi ylee457/wsock:101
docker pull ylee457/wsock:101
docker run --rm -d -p 8080:8080 ylee457/wsock:101

