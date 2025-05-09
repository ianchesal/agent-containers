FROM agent-base

# Python-specific dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Python version: $(python3 --version)"

# Install application - this layer will change when versions update
RUN npm install -g @anthropic-ai/claude-code && \
    echo "" && \
    echo "\e[34m=================================================================\e[0m" && \
    echo "\e[34m                   CLAUDE CODE VERSION                           \e[0m" && \
    echo "\e[34m=================================================================\e[0m" && \
    echo "\e[34m" && /home/codeuser/.npm-global/bin/claude --version && \
    echo "\e[0m" && \
    echo ""

CMD ["/home/codeuser/.npm-global/bin/claude"]
