VENDORNAME=returnnull
PROJECTNAME=hellogba
CONTAINERNAME=dkp_compiler
USER=$(shell whoami)
UID=$(shell id -u $(USER))

# build the docker image
.PHONY: build_image
build_image: clean_docker
	DOCKER_BUILDKIT=1 docker build -f docker/$(CONTAINERNAME)/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev --build-arg uid=$(UID) --build-arg user=$(USER)

# deletes the docker images
.PHONY: clean_docker
clean_docker:
	docker image rm -f $(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev

# compile the .gba file and run in in your emulator
.PHONY: run
run: compile
	mgba-qt -4 $$(pwd)/out/game.gba

# compiles the code into a .gba files, found in the /out folder
.PHONY: compile
compile: clean_out clean_sound
	docker run \
		-v $$(pwd)/code:/${USER} \
		-v $$(pwd)/out:/out \
		$(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev

# gets include files from libgba and libtonc to the include folder
.PHONY: getincludes
getincludes:
	-@docker run \
		--cidfile=c.cid \
		$(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev \
		"echo" "getting c.cid"
	docker cp $$(cat c.cid):/opt/devkitpro/libgba/include $$(pwd)/code/
	docker cp $$(cat c.cid):/opt/devkitpro/libtonc/include $$(pwd)/code/
	-@rm c.cid


# all png images in code/img will be converted to c files which can be used in the game
.PHONY: grit_all
grit_all:
	for file in code/img/*.png; \
	   do test -f $${file%.*}.h || \
	   make grit img=$${file#*/} args="-ftc -gb -gB16"; \
	done

# same as grit_all, but overwrite
.PHONY: grit_all_force
grit_all_force:
	for file in code/img/*.png; \
	    do make grit img=$${file#*/} args="-ftc -gb -gB16"; \
	done

# example "make grit_gB16 img=img/pong_tc.png"
.PHONY: grit_mode3
grit_mode3:
	make grit img=$(img) args="-ftc -gb -gB16"


# example "make grit img=img/pong_tc.png args="-ftc -gb -gB16""
.PHONY: grit
grit:
	docker run \
		-v $$(pwd)/code:/${USER} \
		-v $$(pwd)/out:/out \
		$(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev \
		"/opt/devkitpro/tools/bin/grit" $(img) $(args) "-o$(img)"

# removes files from the out folder and the files from the build folder
.PHONY: clean_all_files
clean_all_files: clean_out
	rm -rf $$(pwd)/code/build/*.d
	rm -rf $$(pwd)/code/build/*.o
	rm -rf $$(pwd)/code/build/*.h
	rm -rf $$(pwd)/code/build/*.bin
	rm -rf $$(pwd)/code/build/*.map

# removes the files from the out folder
.PHONY: clean_sound
clean_sound:
	rm -f $$(pwd)/code/build/soundbank*

.PHONY: clean_out
clean_out:
	rm -f $$(pwd)/out/*.elf
	rm -f $$(pwd)/out/*.gba
#	rm -f $$(pwd)/out/*.sav

# delete all h files from the include folder (from devkitarm)
.PHONY: deleteincludes
deleteincludes:
	rm $$(pwd)/code/include/*.h

# ubuntu only
.PHONE: install_mgba
install_mgba:
	wget -q --spider https://s3.amazonaws.com/mgba/mGBA-build-latest-ubuntu64-$(shell lsb_release -sc).tar.xz &&\
	wget -O /tmp/mgba.tar.xz https://s3.amazonaws.com/mgba/mGBA-build-latest-ubuntu64-$(shell lsb_release -sc).tar.xz &&\
	mkdir /tmp/mgba ||\
	tar -xf /tmp/mgba.tar.xz -C /tmp/mgba --strip-components 1 &&\
	sudo dpkg -i /tmp/mgba/libmgba.deb &&\
	sudo dpkg -i /tmp/mgba/mgba-qt.deb
