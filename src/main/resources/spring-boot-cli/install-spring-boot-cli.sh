#!/bin/bash

cd src/main/resources/spring-boot-cli
# Download the Spring Boot CLI
wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/3.0.2/spring-boot-cli-3.0.2-bin.tar.gz
pwd
# Extract the downloaded archive
tar -xvf spring-boot-cli-3.0.2-bin.tar.gz

# Move the extracted folder to a directory on your PATH
sudo mv spring-3.0.2 /opt/spring-boot-cli

# Add the path to the Spring Boot CLI to your PATH
echo "export PATH=$PATH:/opt/spring-boot-cli/bin" >> ~/.bashrc

# Reload your PATH
source ~/.bashrc

# Verify the installation
spring --version
