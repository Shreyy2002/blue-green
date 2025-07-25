#!/bin/bash
# Update packages
sudo apt update -y

# Install dependencies: git, nodejs, npm, jq, and build-essential (for make)
sudo apt install -y git nodejs npm jq build-essential

# Verify node and npm
nodejs -v
npm -v

# Clone the frontend repository
git clone https://github.com/OT-MICROSERVICES/frontend.git
cd frontend

# Fetch the public IPv4 address of this instance
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Update package.json "proxy" field with the public IP
jq --arg ip "http://$PUBLIC_IP:3000" '.proxy = $ip' package.json > /tmp/package.json && mv /tmp/package.json package.json

# Build the app
make build

# Set necessary node option
export NODE_OPTIONS=--openssl-legacy-provider

# Start the app (consider nohup or pm2 in real prod, else it blocks the script)
npm start
