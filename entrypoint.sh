#!/bin/bash
# Ensure prompts.json exists in the data volume
# When Railway mounts a volume at /app/data, it overlays the original directory
# So we need to copy the default prompts.json from a backup location

if [ ! -f /app/data/prompts.json ]; then
    echo "Copying default prompts.json to data volume..."
    cp /app/data-defaults/prompts.json /app/data/prompts.json
fi

# Start the application
exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 server:app
