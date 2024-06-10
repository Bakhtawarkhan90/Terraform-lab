#!/bin/bash

# Update the package list
sudo apt-get update

# Install wget, unzip, and Apache2
sudo apt-get install -y wget unzip apache2

# Start and enable Apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Download the template
wget https://www.tooplate.com/zip-templates/2117_infinite_loop.zip

# Unzip the template
unzip -o 2117_infinite_loop.zip

# Copy the unzipped files to the Apache web directory
sudo cp -r 2117_infinite_loop/* /var/www/html/

# Restart Apache2 to apply changes
sudo systemctl restart apache2
