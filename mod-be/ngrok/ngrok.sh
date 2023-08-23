#!/bin/bash

add_token=$(curl \
-X POST \
-H "Authorization: Bearer ${NGROK_TOKEN}" \
-H "Content-Type: application/json" \
-H "Ngrok-Version: 2" \
-d '{"description":"development cred for <email>"}' \
https://api.ngrok.com/credentials | jq -r .token)


ngrok config add-authtoken $add_token
