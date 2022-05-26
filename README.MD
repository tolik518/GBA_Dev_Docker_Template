# GBA Developement Docker Template

### What is this?
This is a template so you can start developing GameBoy Advance games without the need of installing [devkitPro](https://devkitpro.org/) or any other dependencies. The only thing you'll need is [docker](https://www.docker.com/get-started/), which many developers already have and you'll need a [GameBoy Advance emulator](https://www.addictivetips.com/ubuntu-linux-tips/play-nintendo-gameboy-games-on-linux/#:~:text=The%20VisualBoy%20Advance%20Emulation%20tool,Color%20and%20the%20Gameboy%20Advance.) to fire up the game.

### How to Start Development (on Linux)
* prerequisites: get [docker](https://www.docker.com/get-started/) and [docker-compose](https://docs.docker.com/compose/install/)
* clone repository
* go to the root of the repository
* build docker image with `make build`
* optional: get include files with `make getincludes` (`make deleteincludes` to remove them)
* `sudo apt install visualboyadvance` to install a GBA emulator

### How to Start Development (on Linux)
[please add this part]

### How to Start the Game
* use `make compile` to compile the source (you'll find it in the /out folder)
* or use `make run` to compile and run the compiled game
    * probably needs to be configured for your emulator in case you use an other than `visualboyadvance`
* `make cleanup` to delete all the build data again


_____

Dockerfile based on the Dockerfile from [Nathan Chowning](https://github.com/nchowning/dockerfiles/tree/master/switchdev). 
The code/Makefile template comes directly from [devkitPro](https://github.com/devkitPro/gba-examples).