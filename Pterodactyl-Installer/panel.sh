#!/bin/bash
set -euo pipefail

# -------------------------
# Color Definitions
# -------------------------
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

# -------------------------
# Animated Logo
# -------------------------
animate_logo() {
  clear
  local logo=(
 "________  .__                                   .__           _______     ______  "
"\\______ \\ |__|__  _____.__._____    ____   _____|  |__  __ __ \\   _  \\   /  __  \\ "
" |    |  \\|  \\  \\/ <   |  |\\__  \\  /    \\ /  ___/  |  \\|  |  \\/  /_\\  \\  >      < "
" |    \`   \\  |\\   / \\___  | / __ \\|   |  \\\\___ \\|   Y  \\  |  /\\  \\_/   \\/   --   \\"
"/_______  /__| \\_/  / ____|(____  /___|  /____  >___|  /____/  \\_____  /\\______  /"
"        \\/          \\/          \\/     \\/     \\/     \\/              \\/        \\/ "
  )
  
  for line in "${logo[@]}"; do
    echo -e "${CYAN}${line}${RESET}"
    sleep 0.15
  done
  echo ""
  sleep 0.4
}

# -------------------------
# Show Animated Logo
# -------------------------
animate_logo

# -------------------------
# Display Menu
# -------------------------
echo -e "${YELLOW}Select an option:${RESET}"
echo -e "${GREEN}1) Pterodactyl Installer${RESET}"
echo -e "${BLUE}2) Google IDX Real VPS${RESET}"
echo -e "${RED}3) Exit${RESET}"
echo -ne "${YELLOW}Enter your choice (1-3): ${RESET}"
read choice

case $choice in
  1)
    echo -e "${GREEN}Running Pterodactyl Installer...${RESET}"
    bash <(curl -fsSL "https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/ptero.sh")
    ;;
  2)
    echo -e "${BLUE}Running Google IDX Real VPS...${RESET}"
    cd || exit 1
    rm -rf myapp flutter
    mkdir -p vps123/.idx
    cd vps123/.idx || exit 1

    cat <<EOF > dev.nix
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

  env = {
    EDITOR = "nano";
  };

  idx = {
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];

    workspace = {
      onCreate = { };
      onStart = { };
    };

    previews = {
      enable = false;
    };
  };
}
EOF

    cd ..
    echo -ne "${YELLOW}Do you want to continue? (y/n): ${RESET}"
    read confirm
    case "$confirm" in
      [yY]*)
        bash <(curl -fsSL "https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/Vm.sh")
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
    echo -e "${RED}Exiting...${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid choice! Please select 1, 2, or 3.${RESET}"
    exit 1
    ;;
esac

echo -e "${CYAN}Made by Divyanshu08 ✅${RESET}"
