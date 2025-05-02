FROM python:3.13-slim

# RUN useradd -m codeuser

RUN \
  apt-get update && \
  apt-get install -y git curl jq ripgrep vim nano make zip unzip ssh-client wget tree imagemagick && \
  rm -rf /var/lib/apt/lists/* && \
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash && \
  apt-get update && \
  apt-get install -y nodejs && \
  node -v && \
  npm -v && \
  mkdir -p /root/.npm-global && \
  npm config set prefix /root/.npm-global && \
  echo 'export PATH=/root/.npm-global/bin:$PATH' >> /root/.bashrc && \
  npm install -g @anthropic-ai/claude-code

WORKDIR /app

# RUN chown -R codeuser:codeuser /app
#
# USER codeuser

CMD ["/root/.npm-global/bin/claude"]
