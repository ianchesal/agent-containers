# Build stage
FROM agent-base AS builder

# Install build dependencies and Claude Code
RUN npm install -g @anthropic-ai/claude-code && \
  echo "Installed Claude Code version: $(/home/codeuser/.npm-global/bin/claude --version)"

# Runtime stage
FROM agent-base

# Copy the installed Claude Code from builder
COPY --from=builder /home/codeuser/.npm-global /home/codeuser/.npm-global

# Display version information
RUN echo "" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m                   CLAUDE CODE VERSION                           \e[0m" && \
  echo "\e[34m=================================================================\e[0m" && \
  echo "\e[34m" && /home/codeuser/.npm-global/bin/claude --version && \
  echo "\e[0m" && \
  echo ""

CMD ["/home/codeuser/.npm-global/bin/claude"]
