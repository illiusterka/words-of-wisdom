#!/bin/bash

set -e

CONFIG_FILE="$HOME/.config/fastfetch/config.jsonc"

if [[ -f "$CONFIG_FILE" ]]; then
	python - "$CONFIG_FILE" <<'PY'
import re
import sys

path = sys.argv[1]

with open(path, "r", encoding="utf-8") as f:
	data = f.read()

pattern = r'\s*// BEGIN WORDS-OF-WISDOM.*?// END WORDS-OF-WISDOM\n'

data = re.sub(pattern, '\n', data, count=1, flags=re.DOTALL)

with open(path, "w", encoding="utf-8") as f:
	f.write(data)
PY
fi

rm -f "$HOME/.local/bin/words-of-wisdom"
rm -f "$HOME/.config/words-of-wisdom.list"

echo "Words of Wisdom uninstalled."
