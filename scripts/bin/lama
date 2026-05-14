#!/usr/bin/env bash

##
## Connect to local ollama server, and ask some stuff
##


# Check arguments
if [ -z "$1" ]; then
    echo "Usage: $(basename $0) <prompt>"
    exit 1
fi

OLLAMA_ENDPOINT_GENERATE="http://localhost:11434/api/generate"
MODEL="gemma3:4b"
PROMPT="$*"

stdbuf -oL curl -s $OLLAMA_ENDPOINT_GENERATE \
  -d "{\"model\":\"$MODEL\",\"prompt\":\"You are a bash assistant, please make your answers concise without markdown nor bullet point lists.User:$PROMPT\",\"stream\":true}" \
 | stdbuf -oL jq -r '.response // empty' \
 | while IFS= read -r chunk; do
    if [ -z "$chunk" ]; then
        echo -ne "\n"
    else
        echo -ne "$chunk"
    fi
done

echo


