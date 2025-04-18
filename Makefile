.PHONY: all clean claude-code openai-codex

all: claude-code openai-codex

claude-code:
	@echo "Building claude-code"
	docker build -t claude-code -f claude-code/Dockerfile claude-code

openai-codex:
	@echo "Building openai-codex"
	docker build -t openai-codex -f openai-codex/Dockerfile openai-codex

clean:
	@echo "Removing Docker images"
	@if docker image inspect claude-code > /dev/null 2>&1; then \
		echo "Removing claude-code"; \
		docker rmi -f claude-code; \
	else \
		echo "Image claude-code does not exist, skipping"; \
	fi
	@if docker image inspect openai-codex > /dev/null 2>&1; then \
		echo "Removing openai-codex"; \
		docker rmi -f openai-codex; \
	else \
		echo "Image openai-codex does not exist, skipping"; \
	fi
	@echo "Removing dangling images (cached layers)..."
	@docker image prune -f
