# AnyLinux-BCNC
Scripts to install/update bCNC in any linux environment without breaking system packages.

### Installation
```bash
mkdir -p ~/Applications &&
git clone https://github.com/ArtikciNarek2006/AnyLinux-BCNC.git ~/Applications/bCNC &&
echo '# bCNC-update.sh: Add bCNC maintenance scripts to PATH.' >> ~/.bashrc &&
echo 'export PATH="$PATH:$HOME/Applications/bCNC/"' >> ~/.bashrc  &&
export PATH="$PATH:$HOME/Applications/bCNC/"  &&
bCNC-update.sh
```

### Update/Fix missing shortcut
```bash
bCNC-update.sh
```

### Starting via terminal
```bash
bCNC-start.sh
```
