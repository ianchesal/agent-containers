# OpenAI Codex

## Build Instructions

```bash
docker build -t openai-codex .
```

## Run Instructions

```bash
docker run -it --rm \
  -e OPENAI_API_KEY \
  -v $(pwd):/app:rw \
  openai-codex
```

## References

* [Github](https://github.com/openai/codex)
