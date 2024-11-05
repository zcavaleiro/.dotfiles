#!/bin/bash

# Author: https://github.com/zcavaleiro

# Safe exit of script
set -euo pipefail

# Declaring Initial Vars
CONFIG_FILE="fedora_apps.json"
APP_DIR="$HOME/Applications"

# Verify its a distro from RHEL Family
if grep -qEi "fedora|centos|rocky|rhel" /etc/*release; then 
    OS="RHEL" 
else 
    echo "Sistema Operativo não suportado" 
    exit 1 
fi

# Set hostname
echo "Lets give a name to the OS machine"
read -rp 'hostname: ' myhostname
sudo hostnamectl set-hostname "$myhostname"

# Configuring /etc/dnf/dnf.conf
sudo bash -c 'echo -e "\nfastestmirror=true\nmax_parallel_downloads=10\ndeltarpm=true" >> /etc/dnf/dnf.conf'

# Enable RPM Repositories Free e Non-Free
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y
sudo dnf upgrade --refresh -y

# Group multimedia codecs install
#dnf group upgrade --with-optional Multimedia -y # error

# Instaling OS packages
echo '# -------------- zcavaleiro:dotfiles Instaling defined OS packages and dependencies (jq or yp?)---------------'

# Function to read packages, urls and dirs from the json file.
read_config() {
    local file=$1
    jq -r '.packages[]' "$file"
    jq -c '.applications[]' "$file"
    jq -r '.signed_packages[]' "$file"
}

# Reading packages, urls, directories and signed packeges from config file
PACKAGES=$(jq -r '.packages[]' "$CONFIG_FILE")
APPLICATIONS=$(jq -c '.applications[]' "$CONFIG_FILE")
SIGNED_PACKAGES=$(jq -r '.signed_packages[]' "$CONFIG_FILE")

# Instaling System Packages
for PACKAGE in $PACKAGES; do
    sudo dnf install -y $PACKAGE
done


# Instaling apps with key signature
echo '# -------------- zcavaleiro:dotfiles Instaling apps with key ---------------'

for SIGNED_PACKAGE in $SIGNED_PACKAGES; do
    case $SIGNED_PACKAGE in
        "vscode")
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
            sudo dnf check-update
            sudo dnf install -y code
            ;;
        "brave")
            sudo dnf install -y dnf-plugins-core
            sudo dnf-3 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            sudo dnf install -y brave-browser
            ;;
        *)
            echo "Pacote assinado desconhecido: $SIGNED_PACKAGE"
            ;;
    esac
done


# App download, extract and create a desktop dir shortcut from url
echo '# -------------- zcavaleiro:dotfiles Download, extract and create a desktop shortcut ---------------'
mkdir -p $APP_DIR

# Workaround detecting Desktop name by language
DESKTOP_DIR="$HOME/Desktop"
if [ ! -d "$DESKTOP_DIR" ]; then
    DESKTOP_DIR="$HOME/Área de Trabalho"
fi

# Download and extract files to each tmp dir
for application in $APPLICATIONS; do
    URL=$(echo "$application" | jq -r '.url')
    DIR=$(echo "$application" | jq -r '.dir')
    TEMP_DIR=$(mktemp -d)
    wget -P $TEMP_DIR $URL
    FILE_NAME=$(basename $URL)
    mkdir -p $APP_DIR/$DIR
    if [[ $FILE_NAME == *.tar.gz ]]; then
        tar -xzf $TEMP_DIR/$FILE_NAME -C $APP_DIR/$DIR
    elif [[ $FILE_NAME == *.tar ]]; then
        tar -xf $TEMP_DIR/$FILE_NAME -C $APP_DIR/$DIR
    fi
    rm -rf $TEMP_DIR
    
    # Create shortcut in "desktop" -  "Area de trabalho"
    echo -e "[Desktop Entry]\nName=$DIR\nExec=xdg-open $APP_DIR/$DIR\nType=Application\nTerminal=false\nIcon=folder" > "$DESKTOP_DIR/$DIR.desktop"
    chmod +x "$DESKTOP_DIR/$DIR.desktop"
done


### Configure the dotfiles

echo '# -------------- zcavaleiro:dotfiles Download the dotfiles and creating symblinks ---------------'

# Clone the repo to home directory
cd $HOME
git clone https://github.com/zcavaleiro/.dotfiles ~/.dotfiles

# creates the symblinks to the system
cd ~/.dotfiles
ln -sf ~/.dotfiles/.bashrc ~/.bashrc
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf "~/.dotfiles/.config/Yubico/Yubikey Manager.conf" "~/.config/Yubico/Yubikey Manager.conf"


# Making pull from recent changes, use of alias for shortcut
echo "alias dotfiles='cd ~/.dotfiles && git pull && cd -'" >> ~/.bashrc

# Apply new congiguration changes
source ~/.bashrc


