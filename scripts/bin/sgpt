#!/usr/bin/env bash

##
## DAluai shell GPT. Uses gpt-40-mini, and relies in env variable CHATGPT_API_KEY
## TODO: fix limiation - sgpt only prints query anwser after getting it all (think TCP vs UDP)
##

if [ $# -lt 1 ]; then
    echo "Usage: $(basename $0) Message to chatGPT"
    exit 1
fi

if [ -z "$CHATGPT_API_KEY" ]; then
  echo "Error: environment variable CHATGPT_API_KEY is empty"
  exit 1
fi


message="$@"
echo ""

curl -s https://api.openai.com/v1/chat/completions   -H "Content-Type: application/json"   -H "Authorization: Bearer $CHATGPT_API_KEY"   -d '{
     "model": "gpt-4o-mini",
     "messages": [{"role": "user", "content": "You are a helpful bash/ubuntu assistant tool. Please provide a concise a answer to the user: '"${message}"'"}],
     "temperature": 0.7
   }' | jq ".choices[0].message.content" | sed 's/\\n/\n/g' | sed 's/\\//g'




