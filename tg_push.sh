#!/bin/bash

chat_id='2050411579'

send1(){
jq -n \
  --arg chat_id "$chat_id" \
  --arg text "$(bash subGit.sh)" \
'{
  chat_id: $chat_id,
  text: $text,
  parse_mode: "HTML"
}' | curl -sL -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}


send2(){
output="$(bash subGit.sh)"

jq -n \
  --arg chat_id "$chat_id" \
  --arg text "$output" \
'{
  chat_id: $chat_id,
  text: $text
}' | curl -sL -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}


send3(){
output="$(bash subGit.sh | sed -r 's/\x1B\[[0-9;]*[mK]//g')"

jq -n \
  --arg chat_id "$chat_id" \
  --arg text "$output" \
'{
  chat_id: $chat_id,
  text: $text
}' | curl -sL -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}

send_markdown(){
output="$(bash subGit.sh | sed -r 's/\x1B\[[0-9;]*[mK]//g')"

jq -n \
  --arg chat_id "$chat_id" \
  --arg text "```
$output
```" \
'{
  chat_id: $chat_id,
  text: $text,
  parse_mode: "Markdown"
}' | curl -sL -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}


send_html(){
output="$(bash commit.sh | sed -r 's/\x1B\[[0-9;]*[mK]//g' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')"

jq -n \
  --arg chat_id "$chat_id" \
  --arg text "<pre>$output</pre>" \
'{
  chat_id: $chat_id,
  text: $text,
  parse_mode: "HTML"
}' | curl -sL -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}

telegram_send_output() {
output="$(
  bash subGit.sh \
  | col -b \
  | sed -E 's/\x1B\[[0-9;]*[a-zA-Z]//g; s/[0-9;]*//g'
)"

jq -n \
  --arg chat_id "$chat_id" \
  --arg text "<pre>$output</pre>" \
'{
  chat_id: $chat_id,
  text: $text,
  parse_mode: "HTML"
}' | curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -H "Content-Type: application/json" \
     -d @-

}


# telegram_send_output
send_html
