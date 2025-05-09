# Build stage
FROM agent-base AS builder

# Install OpenAI Codex in the builder stage
RUN npm install -g @openai/codex && \
  echo "Installed Codex version: $(/home/codeuser/.npm-global/bin/codex --version)"

# Runtime stage
FROM agent-base

# Copy the installed Codex from builder
COPY --from=builder /home/codeuser/.npm-global /home/codeuser/.npm-global

# Display version information
RUN echo "" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m                   OPENAI CODEX VERSION                          \e[0m" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m" && /home/codeuser/.npm-global/bin/codex --version && \
  echo "\e[0m" && \
  echo ""

CMD ["/home/codeuser/.npm-global/bin/codex", "--approval-mode", "auto-edit"]
