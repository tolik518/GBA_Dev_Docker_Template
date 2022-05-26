# Moin GBA


#### How to Start Development (Linux)
* get [docker](https://www.docker.com/get-started/) and [docker-compose](https://docs.docker.com/compose/install/)
* clone repository
* go to the root of the repository
* build docker image with `make build`
* optional: get include files with `make getincludes`
* `sudo apt install visualboyadvance` to install a GBA emulator

#### How to Start the Game
* use `make compile` to compile the source
* or use `make run` to compile and run the compiled game
    * probably needs to be configured for your emulator in case you use an other than `visualboyadvance`
* `make cleanup` to delete all the build data again

#### Todo (DevOps)
* compiled .gba and .elf files should be in /out folder instead of /code


Dockerfile based on the Dockerfile from [Nathan Chowning](https://github.com/nchowning/dockerfiles/tree/master/switchdev). 
The code/Makefile template comes directly from [devkitPro](https://github.com/devkitPro/gba-examples).