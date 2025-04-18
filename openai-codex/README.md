# OpenAI Codex

## Build Instructions

```bash
docker build -t openai-codex .
```

## First time setup

You only need to do this once. It helps persist your configuration between
sessions.

There are no sensitive secrets in the configuration files here so they should
be fine to check in to your dotfiles repository.

Configuration goes in the `config.yaml` file and custom instructions go in
`instructions.md`. See [the
docs](https://github.com/openai/codex?tab=readme-ov-file#configuration) for
more details.

```bash
mkdir -p ~/.config/codex
touch ~/.config/codex/config.yaml
touch ~/.config/codex/instructions.md
```

The local codex configuration path is mounted in at `~/.codex` if you launch
the container as below.

## Run Instructions

```bash
docker run -it --rm \
  -e OPENAI_API_KEY \
  -v ${HOME}/.config/codex:/home/codeuser/.codex:rw \
  -v $(pwd):/app:rw \
  openai-codex
```

## References

* [Github](https://github.com/openai/codex)
* You may prefer [this method for running codex containered](https://github.com/openai/codex/blob/main/codex-cli/scripts/run_in_container.sh). I personally don't like a persistent codex instance like that.
