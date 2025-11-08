
# Installation Guide

## System Requirements

- **OS**: Ubuntu 18.04+, Debian 9+, CentOS 7+
- **RAM**: 512MB minimum, 1GB recommended
- **Storage**: 100MB free space
- **Python**: 3.6 or higher
- **Permissions**: Root access required

## Installation Methods

### Method 1: Automated Deployment (Recommended)



```bash
git clone https://github.com/yourusername/quantum-defense-matrix.git
cd quantum-defense-matrix
sudo ./scripts/deploy.sh

Manual Installation 


# Install dependencies
sudo apt update
sudo apt install python3 python3-pip python3-venv sqlite3 jq curl wget git

# Clone repository
git clone https://github.com/yourusername/quantum-defense-matrix.git
cd quantum-defense-matrix

# Create directories
sudo mkdir -p /usr/lib/quantum-defense /var/lib/quantum-defense /var/log/quantum-ai

# Copy files
sudo cp src/quantum_defense_ai.py /usr/lib/quantum-defense/
sudo chmod +x /usr/lib/quantum-defense/quantum_defense_ai.py

# Set up Python environment
sudo python3 -m venv /opt/quantum-ai
sudo /opt/quantum-ai/bin/pip install -r requirements.txt

# Enable services
sudo systemctl enable /etc/systemd/system/quantum-defense.service




