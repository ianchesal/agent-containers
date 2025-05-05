.PHONY: all clean claude-code openai-codex

# Determine container engine (podman or docker)
CONTAINER_ENGINE := $(shell which podman 2>/dev/null || which docker 2>/dev/null)

# UID/GID
HOST_UID := $(shell id -u)
HOST_GID := $(shell id -g)

# Ensure we have a container engine
ifeq ($(CONTAINER_ENGINE),)
$(error No container engine (podman/docker) found in PATH)
endif

all: claude-code openai-codex

claude-code:
	@echo "Building claude-code"
	$(CONTAINER_ENGINE) build --build-arg HOST_UID=$(HOST_UID) --build-arg HOST_GID=$(HOST_GID) --no-cache -t claude-code -f claude-code/Dockerfile claude-code

openai-codex:
	@echo "Building openai-codex"
	$(CONTAINER_ENGINE) build --build-arg HOST_UID=$(HOST_UID) --build-arg HOST_GID=$(HOST_GID) --no-cache -t openai-codex -f openai-codex/Dockerfile openai-codex

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
	@echo "Removing all build cache to ensure clean builds..."
	@$(CONTAINER_ENGINE) builder prune -af
	@echo "Removing dangling images (cached layers)..."
	@$(CONTAINER_ENGINE) image prune -f

