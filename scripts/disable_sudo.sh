#!/bin/bash

# Get the current username
USER_NAME=$(whoami)

# Create a new sudoers file for the user inside /etc/sudoers.d
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER_NAME > /dev/null

# Set correct permissions
sudo chmod 0440 /etc/sudoers.d/$USER_NAME

echo "Passwordless sudo enabled for user $USER_NAME"
