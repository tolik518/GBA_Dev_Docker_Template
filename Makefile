VENDORNAME=returnnull
PROJECTNAME=hellogba
COMPOSE=PROJECTNAME=$(PROJECTNAME) VENDORNAME=$(VENDORNAME) docker-compose -p $(PROJECTNAME) -f docker/compose/docker-compose.yml

.PHONY: build_image
build_image:
	docker build -f  docker/dkp/Dockerfile . \
	-t $(VENDORNAME)/$(PROJECTNAME)/devkitpro:dev --build-arg uid=1000

.PHONY: run
run:
	VisualBoyAdvance code/developer.gba

.PHONY: compile
compile:
	$(COMPOSE) up 
	docker ps

.PHONY: stop
stop:
	$(COMPOSE) down --remove-orphans
	docker ps

.PHONY: logs
logs:
	$(COMPOSE) logs
