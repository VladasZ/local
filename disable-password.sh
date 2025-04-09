#!/bin/bash

# Get the current username
USER_NAME=$(whoami)

# Disable the password
sudo passwd -d "$USER_NAME"

echo "🪶 Password for user $USER_NAME has been disabled! Cock-a-doodle-no-more-password!"
