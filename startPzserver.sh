#! /bin/bash

#Create tmux instance with auto server start
session_name="pzserver"

tmux new-session -d -s "$session_name"
#Start pz server
tmux send-keys -t "$session_name" "bash /opt/pzserver/start-server.sh" enter

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
send_discord_notification "Server Is Booting Up"

tmux attach -t "$session_name" 
