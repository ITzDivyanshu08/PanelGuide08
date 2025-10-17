#!/usr/bin/env bash

Base64-obfuscated creds -> .netrc -> curl --netrc -> run

set -euo pipefail

URL="https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/ptero3.sh"
HOST="raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/ptero3.sh"
NETRC="${HOME}/.netrc"

Ensure curl exists

if ! command -v curl >/dev/null 2>&1; then
echo "Error: curl is required but not installed." >&2
exit 1
fi

Prepare ~/.netrc with strict perms

touch "$NETRC"
chmod 600 "$NETRC"

tmpfile="$(mktemp)"
grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
mv "$tmpfile" "$NETRC"

{
printf 'machine %s ' "$HOST"
printf 'login %s ' "$USER_RAW"
printf 'password %s\n' "$PASS_RAW"
} >> "$NETRC"

Fetch and execute safely

script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

if curl -fsS --netrc -o "$script_file" "$URL"; then
bash "$script_file"
else
echo "Authentication or download failed." >&2
exit 1
fi

