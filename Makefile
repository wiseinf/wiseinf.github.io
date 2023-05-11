GOOS ?= $(shell go env GOOS)

GIT_VERSION ?= $(shell git describe --tags --always)
GIT_COMMIT_HASH ?= $(shell git rev-parse HEAD)
GIT_TREESTATE = "clean"
GIT_DIFF = $(shell git diff --quiet >/dev/null 2>&1; if [ $$? -eq 1 ]; then echo "1"; fi)
ifeq ($(GIT_DIFF), 1)
    GIT_TREESTATE = "dirty"
endif
BUILDDATE = $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')

# Images management
REGISTRY ?= registry.cn-hangzhou.aliyuncs.com
REGISTRY_NAMESPACE ?= wiseinf
REGISTRY_USER_NAME?=""
REGISTRY_PASSWORD?=""

WISEINF_SITE_IMG ?= "${REGISTRY}/${REGISTRY_NAMESPACE}/wiseinf-site:${GIT_VERSION}"

DOCKERHUB_NAMESPACE ?= wiseinf
DOCKERHUB_USER ?= ""
DOCKERHUB_PASSWORD ?= ""
DOCKERHUB_WISEINF_SITE_IMG ?= "${DOCKERHUB_NAMESPACE}/wiseinf-site:${GIT_VERSION}"

# Get the currently used golang install path (in GOPATH/bin, unless GOBIN is set)
ifeq (,$(shell go env GOBIN))
GOBIN=$(shell go env GOPATH)/bin
else
GOBIN=$(shell go env GOBIN)
endif

SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: all
all: build

.PHONY: build
build: build-wiseinf-site ## Build all. 

.PHONY: build-wiseinf-site
build-wiseinf-site: ## Build wiseinf site. 
	hugo -D

.PHONY: build-images
build-images: build-image-wiseinf-site ## Build all images.

.PHONY: build-image-wiseinf-site
build-image-wiseinf-site: ## Build wiseinf-site image.
	docker build --build-arg LDFLAGS=$(LDFLAGS) --build-arg PKGNAME=wiseinf-site -t ${WISEINF_SITE_IMG} .

.PHONY: push-images 
push-images: push-image-wiseinf-site ## Push all images.

.PHONY: push-image-wiseinf-site
push-image-wiseinf-site: ## Push wiseinf-site image.
ifneq ($(REGISTRY_USER_NAME), "")
	docker login -u $(REGISTRY_USER_NAME) -p $(REGISTRY_PASSWORD) ${REGISTRY}
endif
	docker push ${WISEINF_SITE_IMG}
	docker tag ${WISEINF_SITE_IMG} ${DOCKERHUB_WISEINF_SITE_IMG}
ifneq ($(DOCKERHUB_USER), "")
	docker login -u $(DOCKERHUB_USER) -p $(DOCKERHUB_PASSWORD)
endif
	docker push ${DOCKERHUB_WISEINF_SITE_IMG}

.PHONY: clean
clean: ## Clean node module directory.
	rm -rf node-modules

##@ Run

.PHONY: run
run: run-wiseinf-site ## Run all binaries.

.PHONY: run-wiseinf-site
run-wiseinf-site: ## Run wiseinf-site binary (dev).
	npm run start

.PHONY: run-images
run-images: run-image-wiseinf-site ## Run all image.

.PHONY: run-image-wiseinf-site
run-image-wiseinf-site: ## Run wiseinf-site image (dev).
	docker rm -f wiseinf-site; \
	docker run --name wiseinf-site -p 8000:80 ${WISEINF_SITE_IMG}
