#!/bin/sh

# Ensure /workspace/template exists
if [ ! -d "/workspace/template" ]; then
    mkdir -p /workspace/template
fi

# Check if an internet connection is present
if curl -s --head https://github.com > /dev/null; then
    # Check if the template is a git repository
    if [ -d "/workspace/template/.git" ]; then
        # Pull the latest changes
        git -C /workspace/template reset --hard -q
        git -C /workspace/template pull -q
        echo "Pulled latest template"
    # If the template is not a git repository, clone it
    else
        rm -rf /workspace/template/*
        git clone -q https://github.com/bitsneak/HTLLE-DA-Vorlage /workspace/template
        echo "Cloned template"
    fi
else
    # Restore the backup template
    if [ ! -d "/workspace/template/style" ] || [ ! -f "/workspace/template/Makefile" ]; then
        cp -r /template_backup/* /workspace/template/
        echo "Restored template from backup"
     else
        echo "Using existing template"
    fi
fi

# Remove all template files with an underscore
find /workspace/template -name "*_*" -exec rm -rf {} +

# Run the make command in /workspace/template
exec make pdf -C /workspace/template SOURCEDIR=/workspace
