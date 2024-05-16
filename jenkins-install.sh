#!/bin/bash

# Download Jenkins repository configuration
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins RPM key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade existing packages
sudo yum upgrade -y

# Install required packages
sudo yum install -y fontconfig java-17-openjdk

# Install Jenkins
sudo yum install -y jenkins

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start Jenkins service
sudo systemctl enable jenkins

sudo systemctl start jenkins

# Add Jenkins as an exception in firewall
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

echo "Commands executed successfully."
