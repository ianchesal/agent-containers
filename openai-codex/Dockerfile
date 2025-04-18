FROM node:23-slim

RUN useradd -m codeuser

RUN apt-get update && \
  apt-get install -y git && \
  rm -rf /var/lib/apt/lists/*


RUN npm install -g @openai/codex

WORKDIR /app

RUN chown -R codeuser:codeuser /app

USER codeuser

# Change this to alter the default start-up behavior
# of codex when it launches.
CMD ["codex", "--approval-mode", "auto-edit"]
