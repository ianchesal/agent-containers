.PHONY: all clean claude-code openai-codex

# Determine container engine (podman or docker)
CONTAINER_ENGINE := $(shell which podman 2>/dev/null || which docker 2>/dev/null)

# Ensure we have a container engine
ifeq ($(CONTAINER_ENGINE),)
$(error No container engine (podman/docker) found in PATH)
endif

all: claude-code openai-codex

claude-code:
	@echo "Building claude-code"
	$(CONTAINER_ENGINE) build -t claude-code -f claude-code/Dockerfile claude-code

openai-codex:
	@echo "Building openai-codex"
	$(CONTAINER_ENGINE) build -t openai-codex -f openai-codex/Dockerfile openai-codex

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
	@echo "Removing dangling images (cached layers)..."
	@$(CONTAINER_ENGINE) image prune -f

