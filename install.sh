#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USERNAME="$(whoami)"
SCRIPT_DEST="$HOME/.local/bin/auto-rotate-screen.sh"
USER_SYSTEMD="$HOME/.config/systemd/user"
SYSTEM_SYSTEMD="/etc/systemd/system"

# Ensure directories exist
mkdir -p "$HOME/.local/bin"
mkdir -p "$USER_SYSTEMD"

check_dependencies() {
    echo "Checking dependencies..."
    local missing=0

    if ! command -v monitor-sensor &> /dev/null; then
        echo "  MISSING: monitor-sensor (install iio-sensor-proxy via dnf)"
        missing=1
    fi

    if ! command -v gnome-monitor-config &> /dev/null; then
        echo "  MISSING: gnome-monitor-config (install gnome-monitor-config via dnf)"
        missing=1
    fi

    if [ $missing -eq 1 ]; then
        echo "Please install missing dependencies and re-run."
        exit 1
    fi

    echo "All dependencies found."
}

install_orientation_fix() {
    echo "Installing orientation fix on resume..."

    sed "s|INSTALL_USER|$USERNAME|g" \
        "$REPO_DIR/systemd/fix-orientation-resume.service" \
        | sudo tee "$SYSTEM_SYSTEMD/fix-orientation-resume.service" > /dev/null

    sudo systemctl daemon-reload
    sudo systemctl enable fix-orientation-resume.service
    echo "Orientation fix installed and enabled."
}

install_auto_rotate() {
    echo "Installing auto-rotate screen..."

    cp "$REPO_DIR/scripts/auto-rotate-screen.sh" "$SCRIPT_DEST"
    chmod +x "$SCRIPT_DEST"

    cp "$REPO_DIR/systemd/auto-rotate-screen.service" "$USER_SYSTEMD/auto-rotate-screen.service"

    systemctl --user daemon-reload
    systemctl --user enable --now auto-rotate-screen.service
    echo "Auto-rotate installed and running."
}

install_all() {
    install_orientation_fix
    install_auto_rotate
}

check_dependencies

echo "GPD Pocket 4 Fedora fixes installer"
echo "===================================="
echo "  1) Orientation fix on resume from sleep"
echo "  2) Auto-rotate screen"
echo "  3) Everything"
read -rp "Choice [1/2/3]: " choice

case $choice in
    1) install_orientation_fix ;;
    2) install_auto_rotate ;;
    3) install_all ;;
    *) echo "Invalid choice, exiting." && exit 1 ;;
esac

echo "Done!"
