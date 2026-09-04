#!/bin/bash

set -e

SOURCE_URL="https://raw.githubusercontent.com/illiusterka/words-of-wisdom/main"

INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config"
QUOTES_FILE="$CONFIG_DIR/words-of-wisdom.list"

mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"

curl -fsSL "$SOURCE_URL/words-of-wisdom" \
	-o "$INSTALL_DIR/words-of-wisdom"

chmod +x "$INSTALL_DIR/words-of-wisdom"

if [[ ! -f "$QUOTES_FILE" ]]; then
	curl -fsSL "$SOURCE_URL/presets/dracula-flow-3/words-of-wisdom.list" \
		-o "$QUOTES_FILE"
fi

echo "Words of Wisdom installed."
