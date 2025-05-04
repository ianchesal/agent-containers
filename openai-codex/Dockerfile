FROM node:23-slim

RUN apt-get update && \
  apt-get install -y git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick && \
  rm -rf /var/lib/apt/lists/* && \
  node -v && \
  npm -v && \
  useradd -m codeuser

WORKDIR /app

RUN chown -R codeuser:codeuser /app

USER codeuser

RUN \
  mkdir -p /home/codeuser/.npm-global && \
  npm config set prefix /home/codeuser/.npm-global && \
  echo 'export PATH=/home/codeuser/.npm-global/bin:$PATH' >> /home/codeuser/.bashrc && \
  npm install -g @openai/codex

CMD ["/home/codeuser/.npm-global/bin/codex", "--approval-mode", "auto-edit"]
