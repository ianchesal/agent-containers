.PHONY: all clean

# Automatically find all Dockerfiles
DOCKERFILES = $(shell find . -name "Dockerfile" -type f)

# Extract image names from Dockerfile paths
DOCKER_IMAGES = $(patsubst ./%,%,$(dir $(DOCKERFILES)))

all: build-images

build-images:
	@echo "Building Docker images: $(DOCKER_IMAGES)"
	@for img in $(DOCKER_IMAGES); do \
		echo "Building $$img"; \
		docker build -t $$(basename $$img) -f $$img/Dockerfile $$img; \
	done

clean:
	@echo "Removing Docker images: $(DOCKER_IMAGES)"
	@for img in $(DOCKER_IMAGES); do \
		echo "Checking $$(basename $$img)"; \
		if docker image inspect $$(basename $$img) > /dev/null 2>&1; then \
			echo "Removing $$(basename $$img)"; \
			docker rmi -f $$(basename $$img); \
		else \
			echo "Image $$(basename $$img) does not exist, skipping"; \
		fi; \
	done
	@echo "Removing dangling images (cached layers)..."
	@docker image prune -f
