#!/bin/bash

# Display the ASCII Art logo
echo "██████╗ ██╗██╗   ██╗██╗   ██╗ █████╗ ███╗   ██╗███████╗██╗  ██╗██╗   ██╗ ██████╗  █████╗ ";
echo "██╔══██╗██║██║   ██║╚██╗ ██╔╝██╔══██╗████╗  ██║██╔════╝██║  ██║██║   ██║██╔═████╗██╔══██╗";
echo "██║  ██║██║██║   ██║ ╚████╔╝ ███████║██╔██╗ ██║███████╗███████║██║   ██║██║██╔██║╚█████╔╝";
echo "██║  ██║██║╚██╗ ██╔╝  ╚██╔╝  ██╔══██║██║╚██╗██║╚════██║██╔══██║██║   ██║████╔╝██║██╔══██╗";
echo "██████╔╝██║ ╚████╔╝    ██║   ██║  ██║██║ ╚████║███████║██║  ██║╚██████╔╝╚██████╔╝╚█████╔╝";
echo "╚═════╝ ╚═╝  ╚═══╝     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚════╝ ";

# Install necessary dependencies
echo "Installing necessary dependencies..."


# Step 2: Add NodeSource GPG key
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Step 3: Add NodeSource repository to sources list
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Step 4: Update package list
sudo apt update

# Step 5: Install Node.js and Git
sudo apt install -y nodejs git

# Step 6: Clone the repository
git clone https://github.com/achul123/skyportd

# Step 7: Go to directory
cd skyportd

# Step 8: Install NPM
npm i

# 𝐄𝐧𝐣𝐨𝐲 🎉
echo "𝐌𝐚𝐧𝐮𝐚𝐥 𝐂𝐨𝐦𝐦𝐚𝐧𝐝𝐬 -"
echo "𝐄𝐧𝐭𝐞𝐫 𝐘𝐨𝐮𝐫 𝐍𝐨𝐝𝐞 𝐂𝐨𝐧𝐟𝐢𝐠"
echo "𝐧𝐨𝐝𝐞 ."
echo "𝐈𝐧𝐬𝐭𝐚𝐥𝐥𝐚𝐭𝐢𝐨𝐧 𝐂𝐨𝐦𝐩𝐥𝐞𝐭𝐞𝐝 🎉"
