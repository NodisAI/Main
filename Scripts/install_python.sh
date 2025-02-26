#!/bin/bash

# Check if version argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

version=$1
url_base="https://github.com/bjia56/portable-python/releases/tag/cpython-v$version-build.0"

# Determine system type
if [[ "$OSTYPE" =~ ^darwin ]]; then
    system="darwin-universal2"
elif [[ "$OSTYPE" == "msys" ]]; then
    system="windows-x86_64"
elif [[ "$OSTYPE" =~ ^freebsd ]]; then
    system="$OSTYPE-x86_64"  # is this correct?
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    system="linux-x86_64"
else
    echo "Unsupported system type: $OSTYPE"
    exit 1
fi

# Create directories if they don't exist
mkdir -p "$WORKING_DIR"
mkdir -p "$CACHE_DIR"

# Download Python
cache_file="$CACHE_DIR/python-$version-$system"
if [ ! -f "$cache_file" ]; then
    echo "Downloading Python $version for $system..."
    curl -L -o "$cache_file" "$url_base/python-headless-$version-$system.zip"
else
    echo "Using cached Python $version for $system..."
fi

# Extract or install Python
unzip -o "$cache_file" -d "$WORKING_DIR"

echo "Python $version installed successfully in $WORKING_DIR"
