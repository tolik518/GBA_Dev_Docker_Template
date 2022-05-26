VENDORNAME=returnnull
PROJECTNAME=hellogba
CONTAINERNAME=devkitpro
COMPOSE=CONTAINERNAME=$(CONTAINERNAME) PROJECTNAME=$(PROJECTNAME) VENDORNAME=$(VENDORNAME) docker-compose -p $(PROJECTNAME) -f docker/compose/docker-compose.yml

.PHONY: build_image
build_image:
	docker build -f  docker/$(CONTAINERNAME)/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/$(CONTAINERNAME):dev --build-arg uid=1000

.PHONY: run
run: compile
	VisualBoyAdvance --show-speed-detailed --video-3x code/developer.gba

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
	rm -rf $$(pwd)/code/build; rm $$(pwd)/code/*.elf; rm $$(pwd)/code/*.gba
	
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
