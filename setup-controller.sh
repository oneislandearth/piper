#!/bin/bash

# Define the arguments
token=$1
subdomain=$2

# Define an alert message
function alert() {

  # Define the arguments
  message=$1
  color="34"

  # Check if color is set
  if [ -n "$2" ]; then

    # Check if red
    if [ $2 == "red" ]; then
      color="31"
    
    # Check if green
    elif [ $2 == "green" ]; then
      color="32"

    # Check if orange
    elif [ $2 == "orange" ]; then
      color="33"

    # Check if blue
    elif [ $2 == "blue" ]; then
      color="34"

     # Check if purple
    elif [ $2 == "purple" ]; then
      color="35"
    fi
  fi

  # Log the alert message
  echo -e "\033[0;${color}m${message}\033[0;0m\n"
}

# Define the ngrok installer function
function ngrok() {

  # Define the arguments
  token=$1
  subdomain=$2

  # Check whether ngrok exists or not
  if [ ! -d ~/ngrok ]; then

    # Creating ngrok
    alert "  » Setting up ngrok..."

    # Make the ngrok directory
    mkdir ~/ngrok

    # Download and install ngrok
    curl -sk https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz | tar xvz -C ~/ngrok/ >

    # Success alert message
    alert "    ✔ ngrok-executable" "green"

    # Download and configure the ngrok config file
    curl -qks \
    "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.yml" \
    | sed "s/\$token/${token}/igm" \
    | sed "s/\$domain/${subdomain}/igm" \
    > ~/ngrok/ngrok.yml

    # Success alert message
    alert "    ✔ ngrok-config" "green"

    # Download and configure the ngrok service file
    curl -qks \
    "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.service" \
    | sed "s/\$username/$(whoami)/igm" \
    > ~/ngrok/ngrok.service

    # Success alert message
    alert "    ✔ ngrok-service" "green"

    # Start the ngrok system service
    systemctl --user --now enable ~/ngrok/ngrok.service > /dev/null 2>&1

    # Sleep 3 seconds
    sleep 3

    # Check status
    grep -oh "\w*th\w*" *

  # Handle already installed
  else

    # Download and configure the ngrok config file
    curl -qks \
    "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.yml" \
    | sed "s/\$token/${token}/igm" \
    | sed "s/\$domain/${subdomain}/igm" \
    > ~/ngrok/ngrok.yml

    # Success alert message
    alert "  ✔ ngrok-config updated" "green"

    # Start the ngrok system service
    systemctl --user --now enable ~/ngrok/ngrok.service > /dev/null 2>&1

  fi

  # Final success
   alert "✔ All dependencies installed correctly" "green"
}

# Install and configure ngrok
ngrok $token $subdomain
