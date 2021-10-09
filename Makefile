OWNER := marcopaspuel
PROJECT := datascience-notebook
VERSION := 0.0.1
OPV := $(OWNER)/$(PROJECT):$(VERSION)

SHELL := /bin/bash

.PHONY: install
install:
	poetry install

## Build Docker Image
.PHONY: docker-build
docker-build:
	docker build -f docker/Dockerfile -t $(OPV) .

## Run Notebook Container
.PHONY: docker-run
docker-run:
	docker run --rm -d --name datascience-notebook -p 8888:8888 -v "${PWD}":/home/jovyan/work $(OPV)
	sleep 5
	docker logs datascience-notebook

## Stop Notebook Container
.PHONY: docker-stop
docker-stop:
	docker stop datascience-notebook
