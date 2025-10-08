#!/bin/bash
set -e

VPS_USER="root"
VPS_HOST="194.33.105.122"
VPS_PATH="./nestjs-ci-cd/.env"
SSH_KEY="../../shopinka-vps-private-key"

echo "Syncing .env file to VPS..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "rm -f $VPS_PATH"
scp -i $SSH_KEY .env $VPS_USER@$VPS_HOST:$VPS_PATH >/dev/null 2>&1
echo ".env synced successfully."
