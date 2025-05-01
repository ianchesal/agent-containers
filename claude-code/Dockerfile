FROM python:3.13-slim

RUN useradd -m codeuser

RUN apt-get update && \
  apt-get install -y nodejs npm git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN chown -R codeuser:codeuser /app

USER codeuser

RUN mkdir -p ~/.npm-global && \
  npm config set prefix ~/.npm-global && \
  echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc && \
  npm install -g @anthropic-ai/claude-code@0.2.90

CMD ["/home/codeuser/.npm-global/bin/claude"]
