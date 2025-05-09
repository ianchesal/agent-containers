.PHONY: all clean deep-clean base claude-code openai-codex

# Determine container engine (podman or docker)
CONTAINER_ENGINE := $(shell which podman 2>/dev/null || which docker 2>/dev/null)

# UID/GID
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)

# Tools to install in to the containers with apt-get
LOCAL_TOOLS := "git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick build-essential python3 python3-pip"

# Build options for caching control (set to 1 to disable cache)
DISABLE_CACHE ?= 0
CACHE_FROM ?=

# Cache control flag based on DISABLE_CACHE
CACHE_FLAG := $(if $(filter 1,$(DISABLE_CACHE)),--no-cache,)
CACHE_FROM_FLAG := $(if $(CACHE_FROM),--cache-from $(CACHE_FROM),)

# Ensure we have a container engine
ifeq ($(CONTAINER_ENGINE),)
$(error No container engine (podman/docker) found in PATH)
endif

all: base claude-code openai-codex

base:
	@echo "Building base image"
	$(CONTAINER_ENGINE) build \
		--build-arg HOST_UID=$(HOST_UID) \
		--build-arg HOST_GID=$(HOST_GID) \
		--build-arg LOCAL_TOOLS=$(LOCAL_TOOLS) \
		$(CACHE_FLAG) \
		$(CACHE_FROM_FLAG) \
		-t agent-base \
		-f base/Dockerfile base

claude-code: base
	@echo "Building claude-code"
	$(CONTAINER_ENGINE) build \
		$(CACHE_FLAG) \
		$(CACHE_FROM_FLAG) \
		-t claude-code \
		-f claude-code/Dockerfile claude-code

openai-codex: base
	@echo "Building openai-codex"
	$(CONTAINER_ENGINE) build \
		$(CACHE_FLAG) \
		$(CACHE_FROM_FLAG) \
		-t openai-codex \
		-f openai-codex/Dockerfile openai-codex

clean:
	@echo "Removing container images"
	@if $(CONTAINER_ENGINE) image inspect claude-code > /dev/null 2>&1; then \
		echo "Removing claude-code"; \
		$(CONTAINER_ENGINE) rmi -f claude-code; \
	else \
		echo "Image claude-code does not exist, skipping"; \
	fi
	@if $(CONTAINER_ENGINE) image inspect openai-codex > /dev/null 2>&1; then \
		echo "Removing openai-codex"; \
		$(CONTAINER_ENGINE) rmi -f openai-codex; \
	else \
		echo "Image openai-codex does not exist, skipping"; \
	fi
	@if $(CONTAINER_ENGINE) image inspect agent-base > /dev/null 2>&1; then \
		echo "Removing agent-base"; \
		$(CONTAINER_ENGINE) rmi -f agent-base; \
	else \
		echo "Image agent-base does not exist, skipping"; \
	fi
	@echo "Removing dangling images (unused layers)..."
	@$(CONTAINER_ENGINE) image prune -f

deep-clean: clean
	@echo "Removing all build cache (use with caution)..."
	@$(CONTAINER_ENGINE) builder prune -f --filter until=24h

