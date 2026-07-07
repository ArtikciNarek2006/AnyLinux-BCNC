#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- Color Definitions ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 1. Determine which python command is available
if command -v python3 &>/dev/null; then
    PY="python3"
elif command -v python &>/dev/null; then
    PY="python"
else
    echo -e "${RED}Error: Python is not installed on this system.${NC}"
    exit 1
fi

# Get the exact version number (e.g., 3.11, 3.13) to install the matching tk package
PY_VERSION=$($PY -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')

INSTALL_PATH="$HOME/Applications/bCNC"
VENV_PATH="$INSTALL_PATH/bcnc_venv"
PY_ACTIVATE="$VENV_PATH/bin/activate"

echo -e "${BLUE}=== Starting bCNC Maintenance Script ===${NC}"
echo -e "${BLUE}Using Python Version:${NC} $PY_VERSION"

echo -e "${YELLOW}Installing/Updating system-wide tkinter and venv packages via apt...${NC}"
sudo apt update
# Installs python3-tk or specific version like python3.13-tk if available
sudo apt install -y "python${PY_VERSION}-tk" python3-venv

# 2. Check if virtual environment activation script DOES NOT exist
if [ ! -f "$PY_ACTIVATE" ]; then
    echo -e "${YELLOW}Venv not found. Creating in \"$VENV_PATH\"...${NC}"
    mkdir -p "$INSTALL_PATH"
    $PY -m venv "$VENV_PATH"
else
    echo -e "${GREEN}Existing virtual environment detected.${NC}"
fi

# 3. Activate the venv
echo -e "${BLUE}Activating venv...${NC}"
source "$PY_ACTIVATE"

echo -e "${GREEN}Venv activated successfully.${NC}"
echo -e "${YELLOW}Upgrading pip and installing/updating bCNC...${NC}"
pip install --upgrade pip
pip install --upgrade bCNC

if [ ! -f "$HOME/.local/share/applications/bCNC.desktop" ]; then
    echo -e "${YELLOW}Creating shortcut...${NC}"
    bash "${INSTALL_PATH}/bCNC-create-shortcut.sh"
fi

echo -e "${GREEN}=== Install/Upgrade complete. You are ready to run bCNC! ===${NC}"
