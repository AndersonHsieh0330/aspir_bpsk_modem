### How to build and run
```
# cd to the directory where the Dockerfile is
docker build -t fpga_dev_en
docker run --mount type=bind,src="$(pwd)",target=/root/src --rm -it fpga_dev_env # -it makes it interactive, fpga_dev_en is the image name, --rm removes container if it already exist, meaning we start fresh every single time
note: $(pwd) only works in powershell, if you are in windows terminal change the command to <....src="%cd%"> instead
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

### Installation Prerequisites
- Vivado 2023.2
- GNU make for windows