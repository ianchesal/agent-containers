FROM node:23-slim

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG LOCAL_TOOLS="git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick build-essential"

RUN groupadd --gid=${HOST_GID} --non-unique codeuser && \
  useradd --uid=${HOST_UID} --gid=${HOST_GID} --non-unique --create-home codeuser

RUN apt-get update && \
  apt-get install -y ${LOCAL_TOOLS} && \
  rm -rf /var/lib/apt/lists/* && \
  echo "Node version: $(node -v)" && \
  echo "npm version:  $(npm -v)"

WORKDIR /app

RUN chown -R codeuser:codeuser /app

USER codeuser

COPY ./.bash_aliases /home/codeuser/.bash_aliases

RUN \
  mkdir -p /home/codeuser/.npm-global && \
  npm config set prefix /home/codeuser/.npm-global && \
  echo '' >> /home/codeuser/.bashrc && \
  echo 'export PATH=/home/codeuser/.npm-global/bin:$PATH' >> /home/codeuser/.bashrc && \
  npm install -g @openai/codex && \
  echo "" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m                   OPENAI CODEX VERSION                          \e[0m" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m" && /home/codeuser/.npm-global/bin/codex --version && \
  echo "\e[0m" && \
  echo ""

CMD ["/home/codeuser/.npm-global/bin/codex", "--approval-mode", "auto-edit"]
