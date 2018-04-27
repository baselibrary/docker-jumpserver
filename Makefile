NAME     = baselibrary/jumpserver
REPO     = git@github.com:baselibrary/docker-jumpserver.git
REGISTRY = thoughtworks.io
TAG      = 1.2.1

all: build

build:
	docker build --rm --tag=$(NAME):$(TAG) .;

push:
	docker tag -f ${NAME}:$(TAG) ${REGISTRY}/${NAME}:$(TAG); \
	docker push ${REGISTRY}/${NAME}:$(TAG); \
	docker rmi -f ${REGISTRY}/${NAME}:$(TAG); \

clean:
	docker rmi -f ${NAME}:$(TAG); \
	docker rmi -f ${REGISTRY}/${NAME}:$(TAG); \
