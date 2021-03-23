.PHONY: build \
				start \
				publish

GIT_COMMIT     	 		 := $(shell git rev-parse --short HEAD)
VERSION				 			 := ${GIT_COMMIT}
IMAGE			 		 			 := sneakycrow/shredder
REGISTRY			 			 := ghcr.io
DOCKERFILE     			 := build/Dockerfile
LOCAL_CONTAINER_NAME := shredder
LOCAL_PORT					 := 3000

publish:
	docker push ${REGISTRY}/${IMAGE}:latest
	docker push ${REGISTRY}/${IMAGE}:${VERSION}

build:
	docker build --build-arg VERSION=${VERSION} -t ${IMAGE}:${VERSION} -f ${DOCKERFILE} .
	docker tag ${IMAGE}:${VERSION} ${REGISTRY}/${IMAGE}:${VERSION}
	docker tag ${IMAGE}:${VERSION} ${REGISTRY}/${IMAGE}:latest

start:
	docker run --name ${LOCAL_CONTAINER_NAME} -p ${LOCAL_PORT}:8080 -d ${REGISTRY}/${IMAGE}:${VERSION}

stop:
	docker stop ${LOCAL_CONTAINER_NAME}
	docker rm ${LOCAL_CONTAINER_NAME}