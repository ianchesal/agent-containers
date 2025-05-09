FROM agent-base

# Install application - this layer will change when versions update
RUN npm install -g @openai/codex && \
    echo "" && \
    echo "\e[34m=================================================================\e[0m" && \
    echo "\e[34m                   OPENAI CODEX VERSION                          \e[0m" && \
    echo "\e[34m=================================================================\e[0m" && \
    echo "\e[34m" && /home/codeuser/.npm-global/bin/codex --version && \
    echo "\e[0m" && \
    echo ""

CMD ["/home/codeuser/.npm-global/bin/codex", "--approval-mode", "auto-edit"]
