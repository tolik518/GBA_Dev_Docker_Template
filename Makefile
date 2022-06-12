VENDORNAME=returnnull
PROJECTNAME=hellogba
CONTAINERNAME=dkp_compiler
USER=$(shell whoami)
COMPOSE=USER=$(USER) CONTAINERNAME=$(CONTAINERNAME) PROJECTNAME='$(PROJECTNAME)' VENDORNAME=$(VENDORNAME) PWD=$(shell pwd)\
        docker-compose -p $(PROJECTNAME) -f docker/compose/docker-compose.yml

.PHONY: build_image
build_image:
	docker build -f docker/$(CONTAINERNAME)/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev --build-arg uid=1000 --build-arg user=$(USER)

.PHONY: run
run: compile
	mgba-qt out/game.gba

.PHONY: compile
compile: cleanup
	$(COMPOSE) up --exit-code-from $(CONTAINERNAME)

.PHONY: getincludes
getincludes:
	$(COMPOSE) up 
	docker cp $(CONTAINERNAME):/opt/devkitpro/libgba/include $$(pwd)/code/
	docker cp $(CONTAINERNAME):/opt/devkitpro/libtonc/include $$(pwd)/code/

.PHONY: cleanup
cleanup:
	rm -rf $$(pwd)/code/build; rm -f $$(pwd)/out/*.elf; rm -f $$(pwd)/out/*.gba; rm -f $$(pwd)/out/*.sav
	
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
