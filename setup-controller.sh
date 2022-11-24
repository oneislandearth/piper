#!/bin/bash

# Define the arguments
token=$1
subdomain$2

# Define the ngrok installer function
function ngrok() {

  # Define the arguments
  token=$1
  subdomain$2

  # Check whether ngrok exists or not
  if [ ! -d ~/ngrok ]; then

    # Make the ngrok directory
    mkdir ~/ngrok

    # Download and install ngrok
    curl -sk https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz | tar xvz -C ~/ngrok/

    # Download and configure the ngrok config file
    curl -qks \
    "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.yml?token=GHSAT0AAAAAABYHH5RFUYJALIZEMRBFX3WEY37OJDA" \
    | sed "s/\$token/${token}/igm" \
    | sed "s/\$domain/${subdomain}/igm" \
    > ~/ngrok/ngrok.yml

    # Download and configure the ngrok service file
    curl -qks \
    "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.service?token=GHSAT0AAAAAABYHH5RFAFJS7AFNBPYVPOCGY37OJXA" \
    | sed "s/\$username/$(whoami)/igm" \
    > ~/ngrok/ngrok.service

    # Start the ngrok system service
    systemctl --user --now enable ~/ngrok/ngrok.service
  fi
}

# Install and configure ngrok
ngrok $token $subdomain
