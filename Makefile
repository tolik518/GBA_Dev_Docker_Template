VENDORNAME=returnnull
PROJECTNAME=hellogba
COMPOSE=PROJECTNAME=$(PROJECTNAME) VENDORNAME=$(VENDORNAME) docker-compose -p $(PROJECTNAME) -f docker/compose/docker-compose.yml

.PHONY: build_image
build_image:
	docker build -f  docker/devkitpro/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/devkitpro:dev --build-arg uid=1000

.PHONY: run
run:
	VisualBoyAdvance code/developer.gba

.PHONY: compile
compile:
	$(COMPOSE) up 
	docker ps

.PHONY: getincludes
getincludes:
	$(COMPOSE) up  
	docker cp devkitpro:/opt/devkitpro/libgba/include $$(pwd)/code/
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
