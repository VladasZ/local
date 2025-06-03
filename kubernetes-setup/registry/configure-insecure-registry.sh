#!/bin/bash

set -e

REGISTRY="192.168.0.201:30500"
REGISTRIES_FILE="/etc/rancher/k3s/registries.yaml"

echo "Creating K3s registry config to allow insecure registry: $REGISTRY"

sudo mkdir -p /etc/rancher/k3s

# Write or overwrite the registries.yaml
sudo tee "$REGISTRIES_FILE" > /dev/null <<EOF
mirrors:
  "$REGISTRY":
    endpoint:
      - "http://$REGISTRY"
EOF

echo "Wrote $REGISTRIES_FILE"

# Restart k3s or k3s-agent
if systemctl is-active --quiet k3s; then
  echo "Restarting k3s..."
  sudo systemctl restart k3s
elif systemctl is-active --quiet k3s-agent; then
  echo "Restarting k3s-agent..."
  sudo systemctl restart k3s-agent
else
  echo "❌ Neither k3s nor k3s-agent is running!"
  exit 1
fi

echo "✅ Done. Insecure registry $REGISTRY is now allowed."
