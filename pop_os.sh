# executed on PopOS v
# System update and essential tools
## ensure system is up-to-date with the latest security patches and software updates
sudo apt update && sudo apt dist-upgrade -y

## install essential packages for development tools and dependencies
sudo apt install -y build-essential curl git wget software-properties-common

## Git configuration
git config --global user.name "kasrsf"
git config --global user.email "kasra@kasrsf.com"

# Language-specific environment setup
## Python
### Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh

### Install python versions
#### add new versions by running 'uv python install x.xx [version number]'
uv python install 3.10 

### Add alias to run global python through uv in the terminal
echo -e "\n# Alias to run Python via 'uv' for consistent environment management\nalias python='uv run python'" >> ~/.bashrc

## Golang
### download the go installation tar file
wget -P ~/Downloads https://go.dev/dl/go1.23.4.linux-386.tar.gz

### remove any previous Go installations (if exists) then extract the downloaded archive into /usr/local, creating a fresh Go tree in /usr/local/go
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/Downloads/go1.23.4.linux-386.tar.gz

### Add /usr/local/go/bin to the PATH environment variable
echo -e "\n# add Go binary to PATH\nexport PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

## Protobuf
### download the latest release
wget -P ~/Downloads https://github.com/protocolbuffers/protobuf/releases/download/v29.3/protoc-29.3-linux-x86_64.zip
sudo unzip ~/Downloads/protoc-29.3-linux-x86_64.zip -d /usr/local/bin/protoc-29.3-linux-x86_64

### add to PATH
echo -e "\n# Protocol Buffers\nexport PATH=$PATH:/usr/local/bin/protoc-29.3-linux-x86_64/bin" >> ~/.bashrc

# Applications
## Godot
wget -P ~/Downloads https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip
unzip ~/Downloads/Godot_v4.3-stable_linux.x86_64.zip -d ~/Applications
chmod +x ~/Applications/Godot_v4.3-stable_linux.x86_64

### add godot alias to execute the engine from the terminal
echo -e "\n#Godot executable alias\nalias godot='~/Applications/Godot_v4.3-stable_linux.x86_64'" >> ~/.bashrc

## VSCode (https://code.visualstudio.com/docs/setup/linux)
### download latest linux x64 debian release from link
sudo apt install ~/Downloads/code_1.96.2-1734607745_amd64.deb

## 1Password (https://support.1password.com/install-linux/#debian-or-ubuntu)
### add the key for the 1Password apt repository
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
### add the 1Password apt repository:
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
### add the debsig-verify policy
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
### install 1Password
sudo apt update && sudo apt install 1password

## Dropbox (https://www.dropbox.com/install-linux)
### download latest debian release from link
sudo apt install ~/Downloads/dropbox_2020.03.04_amd64.deb

## Github CLI (https://github.com/cli/cli/blob/6fe21d8f5224c5d8a58d210bd2bc70f5a008294c/docs/install_linux.md)
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
	
## Tailscale
### Add the Tailscale repository and install
curl -fsSL https://tailscale.com/install.sh | sh
### Connect to tailscale network
sudo tailscale up
### have tailscale start automatically on boot
sudo systemctl enable --now tailscaled

## Remmina (screen share)
sudo apt install remmina remmina-plugin-vnc
