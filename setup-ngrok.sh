#!/bin/bash

# Download the config file
curl -qks \
"https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.service?token=GHSAT0AAAAAABYHH5REFL3QQUGGI7KE5THKY37L3OA" \
| sed "s/\$username/$(whoami)/igm" \
> ngrok2.service
