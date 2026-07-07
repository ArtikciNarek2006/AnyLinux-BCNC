#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# --- Color Definitions ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if command -v python3 &>/dev/null; then
    PY="python3"
elif command -v python &>/dev/null; then
    PY="python"
else
    echo -e "${RED}Error: Python is not installed on this system.${NC}"
    exit 1
fi

PY_VERSION=$($PY -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')

INSTALL_PATH="$HOME/Applications/bCNC"
VENV_PATH="$INSTALL_PATH/bcnc_venv"
PY_ACTIVATE="$VENV_PATH/bin/activate"

echo -e "${BLUE}=== Starting bCNC ===${NC}"
echo -e "${BLUE}Using Python Version:${NC} $PY_VERSION"

if [ ! -f "$PY_ACTIVATE" ]; then
    echo -e "${RED}Venv not found. Run bCNC-update.sh${NC}"
    exit 1
fi

echo -e "${BLUE}Activating venv...${NC}"
source "$PY_ACTIVATE"
echo -e "${GREEN}Venv activated successfully.${NC}"
echo ""
echo -e "${GREEN}=== Launching bCNC ===${NC}"

$PY -m bCNC &>/dev/null &

echo -e "${BLUE}bCNC is running in the background. Enjoy!${NC}"
