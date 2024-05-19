# Some notes about using docker
I was going to dockerize the whole environment and project the fpga from a ubuntu environment. Doing this avoids any deviation in software version and makes everything guarantee to work. However for various reason I've decided to postpone this. See below

### Why didn't I dockerize everything
- Everybody in the group uses Windows
- If we want to do debugging and view waveform in a GUI application like GTKwave in docker, we'd need an X server. You CAN make docker work and GUI application but it's just not built for that, a VM is better
- With vivado installation, gtkwave, and setting up the X server so we can do all the development and debugging in Ubuntu, the docker image size will get pretty big
- Extra complicity in setting up the docker file

### How to build and run
```
# cd to the directory where the Dockerfile is
docker build -t fpga_dev_en
docker run --mount type=bind,src="$(pwd)",target=/root/src --rm -it fpga_dev_env
```
-it makes it interactive, fpga_dev_en is the image name, --rm removes container if it already exist, meaning we start fresh every single time
note: $(pwd) only works in powershell, if you are in windows terminal change the command to <....src="%cd%"> instead

### How to restart and attach to the container
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

### Useful Repositories
- This repo has good example for dockerfile with vivado [phwl/docker-vivado](https://github.com/phwl/docker-vivado/tree/master)