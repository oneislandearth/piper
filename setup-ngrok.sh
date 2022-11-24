#!/bin/bash

# Download the config file
curl -qk "https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.service?token=GHSAT0AAAAAABYHH5REQ7ML34XOP5AGFP5AY37LLKA" \
| sed -i "s/\$username/$(whoami)/igm" > ngrok2.service
