# ![icon](/.github/readme/docker_dev_template_v3_original.png)GBA Developement Docker Template

## What is this?
This is a template so you can start developing GameBoy Advance games without the need of installing [devkitPro](https://devkitpro.org/) or any other dependencies. The only thing you'll need is [docker](https://www.docker.com/get-started/), which many developers already have and you'll need a [GameBoy Advance emulator](https://www.addictivetips.com/ubuntu-linux-tips/play-nintendo-gameboy-games-on-linux/#:~:text=The%20VisualBoy%20Advance%20Emulation%20tool,Color%20and%20the%20Gameboy%20Advance.) to fire up the game.

There is also a workflow-script included to compile a gba file after every push and releasing an artifact which could be used for nightly builds.

## How to Start Development (on Linux)
* prerequisites: get [docker](https://www.docker.com/get-started/) and [docker-compose](https://docs.docker.com/compose/install/)
* clone repository
* go to the root of the repository
* build docker image with `make build_image`
* optional: get include files with `make getincludes` (`make deleteincludes` to remove them)
* recommended: install [mGBA](mgba.appimage)

## How to Start Development (on Windows)
[please add this part]

## How to Start the Game
* use `make compile` to compile the source (you'll find it in the /out folder)
* or use `make run` to compile and run the compiled game
    * probably needs to be configured for your emulator in case you use an other than `mgba-qt`


_____

###### Repository originally maintained by [tolik518](https://github.com/tolik518). Dockerfile based on the Dockerfile from [Nathan Chowning](https://github.com/nchowning/dockerfiles/tree/master/switchdev). The Makefile is a mashup of the original from [devkitPro](https://github.com/devkitPro/gba-examples) and from [coranac](https://www.coranac.com/tonc/text/toc.htm).
