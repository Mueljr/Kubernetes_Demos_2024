#!/bin/bash

# Update packages
sudo apt update -y && sudo apt upgrade -y

# Install Docker and Docker Compose
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Install Git
sudo apt install -y git

# Install Helm (optional but included)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Pull Prometheus and Grafana Docker images 
sudo docker pull prom/prometheus
sudo docker pull grafana/grafana

echo "✅ System setup complete. Please log out and back in or run 'newgrp docker' to activate Docker permissions."