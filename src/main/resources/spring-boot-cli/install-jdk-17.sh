#!/bin/bash

# Update package index
sudo apt update

# Install OpenJDK 17
sudo apt install openjdk-17-jdk -y

# Set OpenJDK 17 as the default JAVA_HOME
sudo update-alternatives --config java

# Verify the installation
java -version