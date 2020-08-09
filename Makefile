.PHONY: *

PACKAGE_NAME := chapar
DOCKERFILE_PATH := deployment/Dockerfile
DOCKER_IMAGE_TAG := ${PACKAGE_NAME}

drun = docker run -it --rm -v $(shell pwd):/code ${DOCKER_IMAGE_TAG}
# drun = docker run -it --rm ${DOCKER_IMAGE_TAG}

export DOCKER_BUILDKIT=1

help:  ## Print help and exit
	@echo Usage:
	@printf "  make \033[36m[target]\033[0m"
	@echo
	@echo Targets:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'


cleanup:  ## Cleanup the dist folder
	rm -rf dist/* 2> /dev/null

build: cleanup  # Build the docker image for doing things 
	docker build \
		-f ${DOCKERFILE_PATH} \
		-t ${DOCKER_IMAGE_TAG} \
		.

build-pkg: cleanup build  ## Build the Python package wheel and zip file
	$(drun) \
		python setup.py sdist bdist_wheel

check-pkg: build-pkg ## Sanity check the package
	$(drun) \
		twine check dist/*

publish: check-pkg  ## Upload the package to repo
	$(drun) \
		twine upload dist/*

ls: ## list all the files in the package:
	$(drun) \
		tar tzf dist/*.gz