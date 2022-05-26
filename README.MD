# Hello GBA

#### How to Start Development (Linux)
* clone repository
* `sudo apt install visualboyadvance` to install a GBA emulator
* build docker image with `make build`
* use `make compile` to compile the source
* `make run` to run the compiled game

#### Todo (DevOps)
* compiled .gba and .elf files should be in /out folder instead of /code


Dockerfile on the Dockerfile from [Nathan Chowning](https://github.com/nchowning/dockerfiles/tree/master/switchdev). 
The code/Makefile template comes directly from [devkitPro](https://github.com/devkitPro/gba-examples).