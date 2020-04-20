#####################################################################
# Brave Browser install
sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser

# TODO make brave default browser
# TODO restore configuration from backup (backup default config first located @ ~/.config/BraveSoftware/BraveBroser)
# TODO install plasma browser integration extension
#####################################################################

#####################################################################
# Remove games when desktop == KDE
sudo apt remove \
kdegames-card-data-kf5 \
kdegames-mahjongg-data-kf5 \
kmahjongg \
kmines \
kpat \
ksudoku

# Manually remove games from Ubuntu Software if desktop == GNOME

# Remove preinstalled openjdk packages
sudo apt remove openjdk-11-jre:amd64 openjdk-11-jre-headless:amd64

# Remove software
sudo apt remove ksshaskpass

sudo apt autoremove
#####################################################################

#####################################################################
# Ubuntu Tweaks for Dell
# repo: https://github.com/JackHack96/dell-xps-9570-ubuntu-respin
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/dell-xps-9570-ubuntu-respin/master/xps-tweaks.sh)"
#####################################################################

#####################################################################
# Apt packages
# Right after install
sudo apt install \
git \
vim \
tmux \
python3 \
python3-pip \
python3-gpg \
fonts-powerline \
xsel \
xclip \
network-manager \
network-manager-gnome \
network-manager-openvpn-gnome \
network-manager-openconnect-gnome

# Misc apt packages
sudo apt install \
flameshot \
php7.2 \
php7.2-curl \
php7.2-xml \
jq \
backintime-common \
backintime-qt

# Timeshift (backup utility)
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install timeshift

# QBitTorrent
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt install qbittorrent

# Syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt update
sudo apt install syncthing
#####################################################################

#####################################################################
# VPN
#####################################################################

#####################################################################
# Citrix
# download https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
# debian -> full packages -> Citrix Workspace app for Linux (x86_64)
sudo dpkg -i ~/Downloads/icaclient_19.12.0.19_amd64.deb

# fix ssl error
sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
sudo c_rehash /opt/Citrix/ICAClient/keystore/cacerts
#####################################################################

#####################################################################
# Pip packages
pip3 install --user virtualenv
pip3 install --user virtualenvwrapper
pip3 install --user ansible
#####################################################################

#####################################################################
# Dotfiles
# repo: https://github.com/voku/dotfiles?files=1
cd ~ ; git clone https://github.com/voku/dotfiles.git; cd dotfiles

# Check aptitude packages installed from the first install script
# and remove any unneeded ones or those that can't be found
# comment out mktemp
# comment out locales and localepurge
# replace python packages with python3
# comment out ttf-freefont
cp ./firstInstallDebianBased.sh ./firstInstall.sh
vim ./firstInstall.sh

# Run for the first installation
sudo ./firstInstall.sh

# Copy dotfiles to home
./bootstrap.sh
# TODO configure using zsh for default Terminal app
#####################################################################

#####################################################################
# Tmux dotfiles
# repo: https://github.com/gpakosz/.tmux
mv ~/.tmux.conf ~/.tmux.conf.bak
cd ~ ; git clone https://github.com/gpakosz/.tmux.git
ln -s -f ~/.tmux/.tmux.conf
cp ~/.tmux/.tmux.conf.local ~/.
#####################################################################

#####################################################################
# Restore dotfiles configuration
cp /path/to/backup/home/sergio/dotfiles/startpage-nord.html ~/dotfiles/.

diff -ENwburq backup_dir original_dir # recurse diff files in dirs

# symlinks
ln -s ~/phabricator/arcanist/bin/arc ~/bin/arc
ln -s ~/phabricator/elhubdev/bin ~/bin/elhubdev
ln -s ~/Downloads /path/to/data/Downloads
#####################################################################

#####################################################################
# Install Atom
#####################################################################

#####################################################################
# Install appimaged
# TODO Download the .deb file from https://github.com/AppImage/appimaged/releases
sudo dpkg -i appimaged_*.deb
systemctl --user add-wants default.target appimaged
systemctl --user start appimaged
#####################################################################

#####################################################################
# Install AppImage applications
# KeePassXC https://keepassxc.org/download/
# PCloud https://www.pcloud.com/download-free-online-cloud-file-storage.html
# Cryptomator https://cryptomator.org/downloads/
# Wire https://wire.com/en/download/
#####################################################################

#####################################################################
# Install sdkman
# url: https://sdkman.io/
curl -s "https://get.sdkman.io?rcupdate=false" | bash
#####################################################################

#####################################################################
# Install NodeVersionManager
# git: https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# remove lines added to ~/.zshrc
#####################################################################

#####################################################################
# Install FZF
# git: https://github.com/junegunn/fzf
#####################################################################

#####################################################################
# Install Guake terminal
sudo apt install \
gir1.2-keybinder-3.0 \
gir1.2-notify-0.7 \
gir1.2-vte-2.91 \
libkeybinder-3.0-0 \
libutempter0 \
python3-setuptools \
python3-cairo \
python3-dbus \
python3-gi \
python3-pbr \
python3-pip \
python3 \
gir1.2-wnck-3.0 # fixes some dependency issue but not mentioned in the prerequisites

pip3 install --user guake
# TODO add desktop application for quick launch
# TODO settings
#####################################################################

#####################################################################
# Install Joplin
# copy config and notes from backup to ~/.config/joplin-desktop
# TODO this can be automated once notes are encrypted
wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
#####################################################################

#####################################################################
# Install DavMail Client
# url: http://davmail.sourceforge.net/download.html
# url: https://sourceforge.net/projects/davmail/files/
#####################################################################

#####################################################################
# Add applications to menu
kmenuedit

# TODO add Development -> Guake (icon: https://commons.wikimedia.org/wiki/File:Faenza-guake.svg)
# TODO add icons to Cryptomator, KeePassXC, PCloud if needed (usually gets picked up from appimage)
#####################################################################

#####################################################################
# Change logrotate duration for apt and dpgk
sudo vim /etc/logrotate.d/apt
# change rotate from 12 (months) to any other value
sudo vim /etc/logrotate.d/dpkg
# same as above
#####################################################################

#####################################################################
# Battery saving options
#####################################################################

#####################################################################
# Add to startup if necessary
# Cryptomator, KeePassXC, Dropbox, PCloud, JetBrains Toolbox,
#####################################################################

#####################################################################
# Install IntelliJ Toolbox
# Install IntelliJ Idea
#####################################################################

#####################################################################
# Install citrix client
#
#####################################################################

#####################################################################
# VPN connections
#####################################################################

#####################################################################
# Visuals / Desktop
# TODO install Latte Dock
# TODO install Sweet Theme and use desktop layout from the theme
# Window Behavior -> Multiscreen Behavior -> Active screen follows mouse
# Advanced Window Behavior -> Window placement -> Centered

# sweet theme: https://www.gnome-look.org/p/1253385/
#####################################################################
