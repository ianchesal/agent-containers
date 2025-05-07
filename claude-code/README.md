# Claude Code

## Build Instructions

Use the top level `Makefile` to build this. It injects things in to the build
so the container works correctly for your user under `podman`.

```bash
make claude-code
```

You can add more local tools to the container to be installed via `apt-get` by
extending the `LOCAL_TOOLS` list in the top-level `Makefile`.

## First time setup

You only need to do this once. It helps persist your configuration between
sessions and ensures you don't have to fetch a new Claude Code API key _every_
time you start a new container instance. Because this file will hold an API key
you should be _very_ careful to protect it! DO NOT check this file in to your
dotfiles repo!

```bash
mkdir -p ~/.config/claude
touch ~/.config/claude/claude.json 
chmod 700 ~/.config/claude
chmod 600 ~/.config/claude/claude.json
```

The first time you run `claude` it will complain about the `config.json` file
being invalid configuration JSON. Just select the "Reset to default" setting
from the options it presents and it will not complain again.

Authorize `claude` once and it'll persist your authorization in the
`~/.config/claude/claude.json` file and not ask again.

You probably want to persist these settings as well:

```
claude config set -g autoUpdaterStatus disabled
```

## Run Instructions

Note: If you're running rootless `podman` you'll need to add `--userns=keep-id`
to these instructions.

Note: See the rep [README](../README.md) for some nice shell functions for
launching these containers.

Run the container:

```bash
docker run -it --rm \
  -v ${HOME}/.config/claude/claude.json:/home/codeuser/.claude.json:rw \
  -v ${HOME}/.config/claude:/home/codeuser/.claude:rw \
  -v $(pwd):/app:rw \
  claude-code
```

You can obviously make that a shell alias for ease of use.

If you want an instance of the container with a shell so you can explore inside
or use the `clause` CLI to change and persist settings and what not just run:

```bash

docker run -it --rm \
  -v ${HOME}/.config/claude/claude.json:/home/codeuser/.claude.json:rw \
  -v ${HOME}/.config/claude/CLAUDE.md:/home/codeuser/.claude/CLAUDE.md:rw \
  -v $(pwd):/app:rw \
  claude-code \
  bash
```

## References

* [Documentation](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
* [Github Repo](https://github.com/anthropics/claude-code)
