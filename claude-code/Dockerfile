FROM python:3.13-slim

RUN useradd -m codeuser

RUN apt-get update && \
  apt-get install -y nodejs npm git curl jq ripgrep vim nano make zip unzip ssh-client wget tree && \
  rm -rf /var/lib/apt/lists/*


RUN npm install -g @anthropic-ai/claude-code

WORKDIR /app

RUN chown -R codeuser:codeuser /app

USER codeuser

# Change this to alter the default start-up behavior
# of claude when it launches.
CMD ["claude"]
