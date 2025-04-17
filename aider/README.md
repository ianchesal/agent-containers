# Aider

## Installation Instructions

```bash
docker pull paulgauthier/aider
```

## Run Instructions

```bash
docker run -it --rm \
  --user $(id -u):$(id -g) \
  -e OPENAI_API_KEY \
  -v $(pwd):/app:rw \
  -e ANTHROPIC_API_KEY \
  paulgauthier/aider
```

## References

* [Aider](https://aider.chat)
* [Docs](https://aider.chat/docs/)
* [Github](https://github.com/Aider-AI/aider)
