#!/bin/bash

# INSTALLING TERRAFORM v1.9.5

# Ensure that your system is up to date
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common unzip

# Download HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the GPG key
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add HashiCorp repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package lists
sudo apt update

# Remove any existing Terraform binary
sudo rm -f /usr/local/bin/terraform

# Download Terraform v1.9.5
wget https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip

# Unzip the downloaded file
unzip terraform_1.9.5_linux_amd64.zip

# Move the Terraform binary to /usr/local/bin
sudo mv terraform /usr/local/bin/

# Clean up the downloaded zip file
rm terraform_1.9.5_linux_amd64.zip

# Display Terraform version
echo "*******************************************************************************************************"
terraform --version
echo "*******************************************************************************************************"

# Installation message
echo "*******************************************************************************************************"
echo " $(terraform --version) has been installed successfully"
echo "*******************************************************************************************************"
