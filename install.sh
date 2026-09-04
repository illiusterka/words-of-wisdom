#!/bin/bash

set -e

SOURCE_URL="https://raw.githubusercontent.com/illiusterka/words-of-wisdom/main"

INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config"
QUOTES_FILE="$CONFIG_DIR/words-of-wisdom.list"
FASTFETCH_CONFIG="$CONFIG_DIR/fastfetch/config.jsonc"

mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"

curl -fsSL "$SOURCE_URL/words-of-wisdom" \
	-o "$INSTALL_DIR/words-of-wisdom"

chmod +x "$INSTALL_DIR/words-of-wisdom"

if [[ ! -f "$QUOTES_FILE" ]]; then
	curl -fsSL "$SOURCE_URL/presets/dracula-flow-3/words-of-wisdom.list" \
		-o "$QUOTES_FILE"
fi

if [[ -f "$FASTFETCH_CONFIG" ]] && \
	! grep -q 'BEGIN WORDS-OF-WISDOM' "$FASTFETCH_CONFIG"; then

	python - "$FASTFETCH_CONFIG" <<'PY'
import sys

path = sys.argv[1]

with open(path, "r", encoding="utf-8") as f:
	data = f.read()

module = '''    // BEGIN WORDS-OF-WISDOM
    {
      "type": "command",
      "key": "Wisdom",
      "keyColor": "yellow",
      "text": "words-of-wisdom"
    },
    // END WORDS-OF-WISDOM
'''

needle = '    "break",'

if needle not in data:
	raise SystemExit('Could not find "break" in Fastfetch config')

data = data.replace(needle, module + needle, 1)

with open(path, "w", encoding="utf-8") as f:
	f.write(data)
PY

fi

echo "Words of Wisdom installed."
