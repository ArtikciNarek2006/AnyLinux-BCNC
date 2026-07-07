#!/bin/bash

# Define the target directory and file name
LAUNCHER_DIR="$HOME/.local/share/applications"
LAUNCHER_FILE="$LAUNCHER_DIR/bCNC.desktop"

# Ensure the applications directory exists
if [ ! -d "$LAUNCHER_DIR" ]; then
    echo "Creating directory: $LAUNCHER_DIR"
    mkdir -p "$LAUNCHER_DIR"
fi

echo "Placing bCNC.desktop into $LAUNCHER_DIR..."

# Using EOF without quotes allows $HOME to expand to your actual path (e.g., /home/user)
cat << EOF > "$LAUNCHER_FILE"
[Desktop Entry]
Categories=Science;Electronics;Engineering;CNC;Tools;
Comment=bCNC CNC Coordinator
Exec=bash -c "$HOME/Applications/bCNC/bCNC-start.sh"
Icon=$HOME/Applications/bCNC/bCNC.png
Name=bCNC
StartupNotify=true
Terminal=false
Type=Application
Version=1.0
EOF

# Make the desktop entry executable so the system trusts it
chmod +x "$LAUNCHER_FILE"

echo "Success! (The launcher has been updated using your dynamic user path: $HOME)"
