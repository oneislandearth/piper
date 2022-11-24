#!/bin/bash

# Download the config file
curl -qks \
"https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.service?token=GHSAT0AAAAAABYHH5REFL3QQUGGI7KE5THKY37L3OA" \
| sed "s/\$username/$(whoami)/igm" \
> ngrok2.service

# 
curl -qks \
"https://raw.githubusercontent.com/oneislandearth/piper/main/ngrok.yml?token=GHSAT0AAAAAABYHH5RFBZ4DOCPVIOIJLTHWY37L6NA" \
| sed "s/\$token/$1/igm" \
| sed "s/\$domain/$2/igm" \
> ngrok2.yml
