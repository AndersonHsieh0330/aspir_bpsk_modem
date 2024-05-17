### How to build and run
```
# cd to the directory where the Dockerfile is
docker build -t fpga_dev_env .
docker run -it fpga_dev_env # -it makes it interactive
```

## How to restart and attach to the container
```
# after entering the "exit" command in ubuntu
docker start fpga_dev_env
docker attach fpga_dev_env
```

### Some useful docker Commands
```
docker images # check all built images in the system
docker image rm <image id> # remove an image
docker rm <container id> # remove a container
docker ps -a # check all containers, including running and stopped ones
```