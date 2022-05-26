VENDORNAME=returnnull
PROJECTNAME=hellogba
CONTAINERNAME=devkitpro
COMPOSE=CONTAINERNAME=$(CONTAINERNAME) PROJECTNAME=$(PROJECTNAME) VENDORNAME=$(VENDORNAME) docker-compose -p $(PROJECTNAME) -f docker/compose/docker-compose.yml

.PHONY: build_image
build_image:
	docker build -f  docker/$(CONTAINERNAME)/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev --build-arg uid=1000 --build-arg user=$$USER

.PHONY: run
run: compile
	VisualBoyAdvance --show-speed-detailed --video-3x out/game.gba

.PHONY: compile
compile:
	$(COMPOSE) up --exit-code-from $(CONTAINERNAME)

.PHONY: getincludes
getincludes:
	$(COMPOSE) up  
	docker cp $(CONTAINERNAME):/opt/devkitpro/libgba/include $$(pwd)/code/
	make cleanup

.PHONY: cleanup
cleanup:
	rm -rf $$(pwd)/code/build; rm $$(pwd)/out/*.elf; rm $$(pwd)/out/*.gba
	
.PHONY: deleteincludes
deleteincludes:
	rm $$(pwd)/code/include/*.h

.PHONY: stop
stop:
	$(COMPOSE) down --remove-orphans
	docker ps

.PHONY: logs
logs:
	$(COMPOSE) logs
