#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

RED='\033[0;31m'
GREEN='\033[0;92m'
BLUE='\033[0;94m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -en "${BLUE}(?) Install base packages (0 = no, 1 = yes): ${NC}"
read -r INSTALL_BASE
echo -en "${BLUE}(?) Install SDL build dependencies (0 = no, 1 = yes): ${NC}"
read -r INSTALL_SDL
echo -en "${BLUE}(?) Install VBox Linux Guest Additions ${RED}[WARNING: Ensure not in TTY]${BLUE} (0 = no, 1 = yes): ${NC}"
read -r INSTALL_VBOX

if [ "$INSTALL_BASE" = "1" ]; then
  echo -e "(...) Installing base packages"
  sudo apt update -qq >/dev/null 2>&1
  sudo apt install -y -qq \
    xorg i3 vim git pulseaudio alsa-utils pavucontrol rofi \
    tree zip unzip cmake build-essential tmux feh htop >/dev/null 2>&1
fi

if [ "$INSTALL_SDL" = "1" ]; then
  echo -e "(...) Installing SDL build dependencies"
  sudo apt update -qq >/dev/null 2>&1
  sudo apt install -y -qq \
    build-essential git make pkg-config cmake ninja-build gnome-desktop-testing \
    libasound2-dev libpulse-dev libaudio-dev libfribidi-dev libjack-dev libsndio-dev \
    libx11-dev libxext-dev libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev \
    libxss-dev libxtst-dev libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev \
    libgles2-mesa-dev libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev \
    libpipewire-0.3-dev libwayland-dev libdecor-0-dev liburing-dev >/dev/null 2>&1
fi

if [ "$INSTALL_VBOX" = "1" ]; then
  echo -e "(...) Installing VBox Linux Guest Additions"
  if sudo mount /dev/cdrom /mnt >/dev/null 2>&1; then
    if sudo sh /mnt/VBoxLinuxAdditions.run >/dev/null 2>&1; then
      echo -e "${GREEN}(!) Done installing VBox Linux Guest Additions${NC}"
    else
      echo -e "${RED}(X) Failed installing VBox Linux Guest Additions${NC}"
    fi
    sudo umount /mnt >/dev/null 2>&1
  else
    echo -e "${YELLOW}(^) Insert guest additions CD image first${NC}"
  fi
fi

rm -f "$HOME/.bash_profile"
ln -s "$DOTFILES_DIR/.bash_profile" "$HOME/.bash_profile"

mkdir -p "$HOME/.config/i3"
for file in "$DOTFILES_DIR/.config/i3/"*; do
  filename=$(basename "$file")
  rm -f "$HOME/.config/i3/$filename"
  ln -s "$file" "$HOME/.config/i3/$filename"
done

mkdir -p "$HOME/.config/i3status"
for file in "$DOTFILES_DIR/.config/i3status/"*; do
  filename=$(basename "$file")
  rm -f "$HOME/.config/i3status/$filename"
  ln -s "$file" "$HOME/.config/i3status/$filename"
done

for file in .fehbg .tmux.conf .vimrc .xinitrc .Xresources; do
  rm -f "$HOME/$file"
  ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
done

echo -e "${GREEN}(!) Dotfiles setup complete${NC}"
