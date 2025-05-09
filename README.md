# agent-containers

A bunch of container-ed AI agents with some simple instructions for running
them against your local code in slightly safer ways.

Where possible, I've documented how to persist configuration from session to
session as well. As a lot of these agents store your API credentials _in_ their
configuration files, you should be really cautious about checking in config to
some place like your dotfiles repo.

## Prerequisites

You'll need either [Docker](https://www.docker.com/) (preferably running
rootless) or [podman](https://podman.io/) installed on your system to build and
launch these containers.

## Building

To build all the containers:

```bash
make all
```

To build any specific container use the directory name. For example:

```bash
make claude-code
```

### Build Options

The build system supports caching control options:

```bash
# Build with caching (default)
make claude-code

# Build without cache
make claude-code DISABLE_CACHE=1

# Build using a specific image as cache source
make claude-code CACHE_FROM=claude-code:latest
```

### Cleaning

To remove built images:

```bash
# Remove images but preserve build cache
make clean

# Remove images and prune build cache older than 24h
make deep-clean
```

## Running

See the README files in the sub-directories for instructions on initial setup,
configuration persistence and executing the AI agents in their container
environments.

For launching the containers, I recommend a small set of shell functions. These
will work in `zsh` or `bash` and automatically adjust for `podman` and
`docker`.

```bash
function __ai_container_launcher() {
  if type podman >/dev/null; then
    LAUNCHER="podman run --userns=keep-id"
  else
    LAUNCHER="docker run"
  fi
  echo $LAUNCHER
}

function claude() {
  eval "$(__ai_container_launcher) --tty --interactive -v ${HOME}/.config/claude/claude.json:/home/codeuser/.claude.json:rw \
    -v ${HOME}/.config/claude:/home/codeuser/.claude:rw \
    -v $(pwd):/app:rw \
    claude-code $@"
}

function codex() {
  eval "$(__ai_container_launcher) --rm --tty --interactive -e OPENAI_API_KEY -v $(pwd):/app:rw openai-codex $@"
}
```

Put those some place in your `.zshrc` or `.bashrc` file and you'll be able to
launch the agent in a working directory with a call to `claude` or `codex`. You
can test they work by getting a bash shell in them with `claude bash` or
`claude codex`.

## See Also

* [My dotfiles](https://github.com/ianchesal/dotfiles)
