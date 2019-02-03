## Spring Boot WebSocket Chat Appplication


## Reference/Credit

This project is used for me to play with Docker and Kubernetes. 
Please see the original source at https://www.callicoder.com/spring-boot-websocket-chat-example/

A Live demo of the application is at https://spring-ws-chat.herokuapp.com/

![Application Screenshot](https://github.com/ylee457/spring-boot-docker/blob/master/screenshot.png)

## Requirements

1. Java - 1.8.x

2. Maven - 3.x.x

## Steps to Setup

**1. Clone the application**

```bash
git clone https://github.com/callicoder/spring-boot-websocket-chat-demo.git
```

**2. Build and run the app using maven**

```bash
cd spring-boot-websocket-chat-demo
mvn clean install package
java -jar target/websocket-demo-0.0.1-SNAPSHOT.jar
```

Alternatively, you can run the app directly without packaging it like so -

```bash
mvn spring-boot:run
```


**3. Create a Docker Image and inspect its content**

```bash
$ pwd
/Users/ylee/eclipse-workspace-photon/spring-boot-websocket-chat
$ docker build -t websock-demo:1 .

$ docker image ls
$ docker image inspect websock-demo:1
```

**3a. Other helpful Docker commands to work with images**

To list images (same as "docker image ls")

```
$ docker images
```

To get only the image ID with filter using the grep command
```
$ docker images | grep "SNAPSHOT" | awk '{print $3}'
```

To remove images with filtered results
```
$ docker rmi $(docker images | grep "SNAPSHOT" | awk '{print $3}')
```

To list dangling images (images with none in Tag)

```
$ docker images --filter "dangling=true" 
$ docker images --filter "dangling=true" -q
$ docker images --filter "dangling=true" -q --no-trunc
```
To remove dangling images

```
$ docker rmi $(docker images --filter "dangling=true" -q)
```
or

```
$ docker system prune
```

**4. Run the Docker image**

```
$ docker run --rm -d -p 8080:8080 websock-demo:1
```

**5. See Docker container which is running the image**

```
$ docker ps
or
$ docker ps | grep websock
```

**6. Stop the Docker container**

```
$ docker stop 1e4512b11c42
or
$ docker stop $(docker ps | grep websock | awk '{print $1}')
```

**6. Log on to  Docker registry to push image**

```
$ docker login
```

**7. Associate the local image with a Docker repository**

Note: Repository in Docker registry uses format: user-Docker-ID/docker-repository:tag
Syntax: docker tag local-image:tag user-Docker-ID/docker-repository:tag

```
$ docker tag websock-demo:1 ylee457/wsock:101
```

**8. Push the image to Docker hub**

```
$ docker push ylee457/wsock:101
```

**9. Verify the pushed image pull from Docker hub**

```
# remove the container whose image is "ylee/wsock:101"
$ docker rm $(docker ps -a | grep "ylee457/wsock:101" | awk '{print $1}')

# remove the local image
$ docker rmi ylee457/wsock:101

# retrieve the image from Docker hub
$ docker pull ylee457/wsock:101

# run the image
$ docker run -p 8080:8080 ylee457/wsock:101
```


