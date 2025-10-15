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
# Typing Animation Function
# -------------------------
type_text() {
  local text="$1"
  local delay="${2:-0.002}"
  while IFS= read -r -n1 char; do
    printf "%s" "$char"
    sleep "$delay"
  done <<< "$text"
  echo ""
}

# -------------------------
# Glowing Effect Function
# -------------------------
glow_text() {
  local text="$1"
  for color in "$CYAN" "$BLUE" "$CYAN" "$BLUE"; do
    echo -ne "${color}${text}${RESET}\r"
    sleep 0.3
  done
  echo -e "${CYAN}${text}${RESET}"
}

# -------------------------
# Animated Logo Display
# -------------------------
clear
echo -e "${BLUE}"
type_text "________  .__                                   .__           _______     ______  "
type_text "\\______ \\ |__|__  _____.__._____    ____   _____|  |__  __ __ \\   _  \\   /  __  \\ "
type_text " |    |  \\|  \\  \\/ <   |  |\\__  \\  /    \\ /  ___/  |  \\|  |  \\/  /_\\  \\  >      < "
type_text " |    \`   \\  |\\   / \\___  | / __ \\|   |  \\\\\\___ \\|   Y  \\  |  /\\  \\_/   \\/   --   \\"
type_text "/_______  /__| \\_/  / ____|(____  /___|  /____  >___|  /____/  \\_____  /\\______  /"
type_text "        \\/          \\/          \\/     \\/     \\/     \\/              \\/        \\/ "
echo -e "${RESET}\n"

sleep 0.5

# -------------------------
# Glowing Menu Header
# -------------------------
glow_text "=============================================="
glow_text "            VPS UNIVERSAL PANEL MENU          "
glow_text "=============================================="
echo ""

# -------------------------
# Menu Options
# -------------------------
echo -e "${GREEN}1.${RESET} Google IDX VM Transformer"
echo -e "${GREEN}2.${RESET} Ultra Pterodactyl Installer"
echo -e "${RED}0.${RESET} Exit"
echo ""

# -------------------------
# User Input
# -------------------------
echo -ne "${YELLOW}Select an option: ${RESET}"
read -r choice
echo ""

# -------------------------
# Actions
# -------------------------
case $choice in
  1)
    echo -e "${BLUE}Launching Google IDX VM Transformer...${RESET}"
    sleep 1
    bash <(curl -fsSL "https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/Vm.sh")
    ;;
  2)
    echo -e "${BLUE}Launching Ultra Pterodactyl Installer...${RESET}"
    sleep 1
    bash <(curl -fsSL "https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/ptero.sh")
    ;;
  0)
    echo -e "${RED}Exiting...${RESET}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid option. Please try again.${RESET}"
    ;;
esac
