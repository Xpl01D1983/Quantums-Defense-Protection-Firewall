#!/bin/bash
# Quantum Defense Matrix - Deployment Script

set -e

echo "🔮 QUANTUM DEFENSE MATRIX - ULTIMATE DEPLOYMENT"
echo "================================================"

# Check root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Run as root: sudo $0"
    exit 1
fi

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;94m'
RED='\033[0;91m'
NC='\033[0m'

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}[1/6] CHECKING SYSTEM REQUIREMENTS...${NC}"

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 not found. Installing..."
    apt update && apt install -y python3 python3-pip
fi

# Check other dependencies
for dep in sqlite3 jq curl wget git; do
    if ! command -v $dep &> /dev/null; then
        echo "📦 Installing $dep..."
        apt install -y $dep
    fi
done

echo -e "${BLUE}[2/6] DEPLOYING QUANTUM DEFENSE CORE...${NC}"

# Copy main defense script
cp "$PROJECT_ROOT/src/quantum_defense_ai.py" /usr/lib/quantum-defense/
chmod +x /usr/lib/quantum-defense/quantum_defense_ai.py

# Create directories
mkdir -p /usr/lib/quantum-defense /var/lib/quantum-defense /var/log/quantum-ai /var/cache/quantum-updates
chmod 700 /usr/lib/quantum-defense /var/lib/quantum-defense

echo -e "${BLUE}[3/6] SETTING UP AI ENVIRONMENT...${NC}"

# Create Python virtual environment
python3 -m venv /opt/quantum-ai
/opt/quantum-ai/bin/pip install --upgrade pip
/opt/quantum-ai/bin/pip install -r "$PROJECT_ROOT/requirements.txt"

echo -e "${BLUE}[4/6] CONFIGURING SYSTEM SERVICES...${NC}"

# Copy systemd services
cp "$PROJECT_ROOT/config/quantum-defense.service" /etc/systemd/system/
cp "$PROJECT_ROOT/config/quantum-update.service" /etc/systemd/system/
cp "$PROJECT_ROOT/config/quantum-update.timer" /etc/systemd/system/

# Copy management tool
cp "$PROJECT_ROOT/scripts/qdefense" /usr/sbin/
chmod +x /usr/sbin/qdefense

echo -e "${BLUE}[5/6] INITIALIZING DEFENSE DATABASE...${NC}"

# Initialize database
/opt/quantum-ai/bin/python3 /usr/lib/quantum-defense/quantum_defense_ai.py --init-only

echo -e "${BLUE}[6/6] ACTIVATING DEFENSE SYSTEM...${NC}"

# Enable services
systemctl daemon-reload
systemctl enable quantum-defense.service
systemctl enable quantum-update.timer

echo -e "${GREEN}✅ QUANTUM DEFENSE MATRIX DEPLOYMENT COMPLETE${NC}"
echo ""
echo "🎯 NEXT STEPS:"
echo "  sudo qdefense start    - Start defense system"
echo "  sudo qdefense status   - Check system status"
echo "  sudo qdefense enable   - Enable autostart"
echo ""
echo "📚 Documentation: https://github.com/yourusername/quantum-defense-matrix"