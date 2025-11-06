#!/bin/bash
# Quantum Defense Matrix - Uninstall Script

set -e

echo "🛑 QUANTUM DEFENSE MATRIX - UNINSTALL"
echo "======================================"

# Check root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Run as root: sudo $0"
    exit 1
fi

echo "Stopping services..."
systemctl stop quantum-defense.service 2>/dev/null || true
systemctl stop quantum-update.service 2>/dev/null || true

echo "Disabling services..."
systemctl disable quantum-defense.service 2>/dev/null || true
systemctl disable quantum-update.service 2>/dev/null || true
systemctl disable quantum-update.timer 2>/dev/null || true

echo "Removing services..."
rm -f /etc/systemd/system/quantum-defense.service
rm -f /etc/systemd/system/quantum-update.service
rm -f /etc/systemd/system/quantum-update.timer

echo "Removing defense files..."
rm -f /usr/sbin/qdefense
rm -rf /usr/lib/quantum-defense
rm -rf /opt/quantum-ai

echo "Reloading systemd..."
systemctl daemon-reload

echo "✅ Quantum Defense Matrix uninstalled successfully"
echo ""
echo "Note: Defense databases and logs preserved in:"
echo "  /var/lib/quantum-defense/"
echo "  /var/log/quantum-ai/"
