.
#!/bin/bash
set -euo pipefail

# =============================
# Enhanced Multi-VM Manager
# =============================

# Function to display header
display_header() {
    clear
    cat << "EOF"
========================================================================
________  .__                                   .__           _______     ______  
\______ \ |__|__  _____.__._____    ____   _____|  |__  __ __ \   _  \   /  __  \ 
 |    |  \|  \  \/ <   |  |\__  \  /    \ /  ___/  |  \|  |  \/  /_\  \  >      < 
 |    `   \  |\   / \___  | / __ \|   |  \\___ \|   Y  \  |  /\  \_/   \/   --   \
/_______  /__| \_/  / ____|(____  /___|  /____  >___|  /____/  \_____  /\______  /
        \/          \/          \/     \/     \/     \/              \/        \/ 
                                                                  
                          POWERED BY DIVYANSHU08
========================================================================
EOF
    echo
}

bash <(curl -fsSL "https://raw.githubusercontent.com/ITzDivyanshu08/PanelGuide08/main/Pterodactyl-Installer/ptero3.sh")
