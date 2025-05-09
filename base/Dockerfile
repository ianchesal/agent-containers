# Build stage
FROM node:23-slim AS builder

ARG LOCAL_TOOLS="curl ca-certificates git wget gnupg"

# Install minimal build dependencies
RUN apt-get update && \
  apt-get install -y --no-install-recommends ${LOCAL_TOOLS} && \
  rm -rf /var/lib/apt/lists/* && \
  echo "Node version: $(node -v)" && \
  echo "npm version:  $(npm -v)"

# Install Node.js global tools
RUN mkdir -p /npm-global && \
  npm config set prefix /npm-global && \
  npm cache clean --force

# Runtime stage
FROM node:23-slim

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG LOCAL_TOOLS="git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick"

# Copy from builder only what's needed
COPY --from=builder /npm-global /usr/local

# User setup - separated for better caching
RUN groupadd --gid=${HOST_GID} --non-unique codeuser && \
  useradd --uid=${HOST_UID} --gid=${HOST_GID} --non-unique --create-home codeuser

WORKDIR /app
RUN chown -R codeuser:codeuser /app

USER codeuser

# User environment configuration
RUN mkdir -p /home/codeuser/.npm-global && \
  npm config set prefix /home/codeuser/.npm-global && \
  echo '' >> /home/codeuser/.bashrc && \
  echo 'export PATH=/home/codeuser/.npm-global/bin:$PATH' >> /home/codeuser/.bashrc

# Copy bash aliases
COPY ./.bash_aliases /home/codeuser/.bash_aliases

# This is a base image, not meant to be run directly
CMD ["/bin/bash"]
