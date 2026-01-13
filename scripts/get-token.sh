#!/usr/bin/env sh

auth=$(curl -X POST "https://oauth.accounts.hytale.com/oauth2/device/auth" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=hytale-server" \
  -d "scope=openid offline auth:server")

verification_uri=$(echo $auth | jq '.verification_uri')
user_code=$(echo $auth | jq '.user_code')
interval=$(echo $auth | jq '.interval')
device_code=$(echo $auth | jq '.device_code')

echo "Please go to $verification_uri"
echo "And use Code $user_code to verify"

while true
do
  token=$(curl -X POST "https://oauth.accounts.hytale.com/oauth2/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "client_id=hytale-server" \
    -d "grant_type=urn:ietf:params:oauth:grant-type:device_code" \
    -d "device_code=$device_code")

  if echo "$token" | jq -e 'has("error")' > /dev/null; then
    echo $token | jq
  else
    access_token=$(echo $token | jq '.access_token')
    break
  fi

  sleep $interval
done

curl -X GET "https://account-data.hytale.com/my-account/get-profiles" \
  -H "Authorization: Bearer $access_token"