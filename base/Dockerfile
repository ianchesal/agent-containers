FROM node:23-slim

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG LOCAL_TOOLS="git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick build-essential"

# System dependencies layer - changes less frequently
RUN apt-get update && \
    apt-get install -y ${LOCAL_TOOLS} && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Node version: $(node -v)" && \
    echo "npm version:  $(npm -v)"

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