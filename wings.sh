#!/bin/bash

# Display the ASCII Art logo
echo "██████╗ ██╗██╗   ██╗██╗   ██╗ █████╗ ███╗   ██╗███████╗██╗  ██╗██╗   ██╗ ██████╗  █████╗ "
echo "██╔══██╗██║██║   ██║╚██╗ ██╔╝██╔══██╗████╗  ██║██╔════╝██║  ██║██║   ██║██╔═████╗██╔══██╗"
echo "██║  ██║██║██║   ██║ ╚████╔╝ ███████║██╔██╗ ██║███████╗███████║██║   ██║██║██╔██║╚█████╔╝"
echo "██║  ██║██║╚██╗ ██╔╝  ╚██╔╝  ██╔══██║██║╚██╗██║╚════██║██╔══██║██║   ██║████╔╝██║██╔══██╗"
echo "██████╔╝██║ ╚████╔╝    ██║   ██║  ██║██║ ╚████║███████║██║  ██║╚██████╔╝╚██████╔╝╚█████╔╝"
echo "╚═════╝ ╚═╝  ╚═══╝     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝  ╚════╝ "

# Install necessary dependencies
echo "Installing necessary dependencies..."

# Add NodeSource GPG key
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Add NodeSource repository to sources list
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Update package list
sudo apt update

# Install Node.js and Git
sudo apt install -y nodejs git

# Clone the repository
git clone https://github.com/achul123/skyportd

echo "Installation Done. Next Commands To Run:"
echo "cd skyportd"
echo "npm install"
echo "Enter Your Node Config"
echo "node ."
