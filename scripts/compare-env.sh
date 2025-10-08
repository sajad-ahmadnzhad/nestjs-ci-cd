#!/bin/bash
set -e

VPS_USER="root"
VPS_HOST="194.33.105.122"
VPS_PATH="./nestjs-ci-cd"
SSH_KEY="../../shopinka-vps-private-key"

ENV_FILES=(".env" ".env.docker")

echo "🔍 Checking env files differences..."

for ENV_FILE in "${ENV_FILES[@]}"; do

  if [ ! -f "./$ENV_FILE" ]; then
    echo "$ENV_FILE not found in local."
    continue
  fi

  LOCAL_FILE="$ENV_FILE"
  REMOTE_FILE="$VPS_PATH/$ENV_FILE"
  TEMP_FILE="/tmp/$(basename $ENV_FILE)_temp"

  echo "Checking $ENV_FILE..."

  scp -i "$SSH_KEY" "$VPS_USER@$VPS_HOST:$REMOTE_FILE" "$TEMP_FILE" > /dev/null 2>&1 || true

  if diff -q "$LOCAL_FILE" "$TEMP_FILE" >/dev/null 2>&1; then
    echo "$ENV_FILE is up to date — skipping sync."
  else
    echo "$ENV_FILE differs — syncing new version..."
    ssh -i "$SSH_KEY" "$VPS_USER@$VPS_HOST" "rm -f $REMOTE_FILE"
    scp -i "$SSH_KEY" "$LOCAL_FILE" "$VPS_USER@$VPS_HOST:$REMOTE_FILE" >/dev/null 2>&1
    echo "Synced $ENV_FILE successfully."
  fi

  rm -f "$TEMP_FILE"
done

echo "All env files are up-to-date."
