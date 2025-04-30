#! /bin/bash
session_name="pzserver"

tmux send-keys -t "$session_name" 'servermsg "Server Automatic Restart in 30 Seconds"' enter
sleep 30
tmux send-keys -t "$session_name" "quit" enter

# Discord Webhook
discord_url="DISCORD WEBHOOK API"

#Function to send a message
send_discord_notification() {
  local message=$1
message=$(echo "$message" | sed 's/\\/\\\\/g; s/"/\\"/g')  
# Construct payload
  local payload=$(cat <<EOF
{
  "content": "$message"
}
EOF
)

  # Send POST request to Discord Webhook
  curl -H "Content-Type: application/json" -X POST -d "$payload" $discord_url
}

# Use the function
send_discord_notification "Server is Shutting Down"
