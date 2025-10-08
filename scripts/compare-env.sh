#!/bin/bash
set -e

VPS_USER="root"
VPS_HOST="194.33.105.122"
VPS_PATH="./nestjs-ci-cd/.env"
SSH_KEY="../../shopinka-vps-private-key"

echo "🔍 Checking if local .env differs from VPS..."

scp -i $SSH_KEY $VPS_USER@$VPS_HOST:$VPS_PATH /tmp/vps_env_temp > /dev/null 2>&1 || true

if diff -q .env /tmp/vps_env_temp >/dev/null 2>&1; then
  echo ".env files are identical — skipping sync."
else
  echo ".env files differ — syncing new version..."
  bash scripts/sync-env.sh
fi

rm -f /tmp/vps_env_temp
