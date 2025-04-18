# agent-containers

A bunch of container-ed AI agents with some simple instructions for running
them against your local code in slightly safer ways.

Where possible, I've documented how to persist configuration from session to
session as well. As a lot of these agents store your API credentials _in_ their
configuration files, you should be really cautious about checking in config to
some place like your dotfiles repo.

## Building

To build all the containers:

```bash
make all
```

To build any specific container use the directory name. For example:

```bash
make claude-code
```

## Running

See the README files in the sub-directories for instructions on initial setup,
configuration persistence and executing the AI agents in their container
environments.

## See Also

* [My dotfiles](https://github.com/ianchesal/dotfiles)
